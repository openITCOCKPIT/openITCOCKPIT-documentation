# Update Ubuntu Jammy (22.04) to Ubuntu Noble (24.04)

!!! danger "Backup"
    Before you start, make sure you have a **working backup** of your system!
    On virtual machines, create a snapshot as well, so the complete upgrade can be rolled back.

Please make sure to run all commands as `root` user.

In order to always be able to use the latest version of openITCOCKPIT, it is important to keep the underlying operating system up to date.
You can use this guide to upgrade your Ubuntu Jammy System to Ubuntu Noble.

!!! info "openITCOCKPIT version"
    The upgrade installs the latest openITCOCKPIT version that is available for Ubuntu Noble.
    It is not possible to keep the previous openITCOCKPIT version during the operating system upgrade.

!!! info "Duration and availability"
    Expect 15 to 60 minutes, depending on the number of packages and the performance of the system.
    From the moment PHP-FPM is stopped, the openITCOCKPIT web interface is not available until the
    configuration has been rewritten at the end of this guide.

---

## Requirements
- openITCOCKPIT in version 4.x or 5.x
- At least 5 GB free disk space on `/` - about 2 GB of packages are downloaded during the upgrade

Check the free disk space before you start:

```bash
df -h /
```

---

## Installation of all updates
Before you start upgrading Ubuntu, please make sure that all available updates have been installed.

```bash
apt update && apt -y full-upgrade
```

---

## Stop PHP-FPM
PHP-FPM 8.1 should be stopped before the upgrade to avoid conflicts:

```bash
systemctl stop php8.1-fpm.service
```

If you are running a different PHP version, stop the corresponding `phpX.Y-fpm.service` instead.

---

## Remove legacy systemd units
openITCOCKPIT 5.9 replaces Statusengine 3 by Statusengine 4. The cleanup service now starts
`/opt/openitc/statusengine4/worker/bin/db_cleanup`, older installations used
`/opt/openitc/statusengine3/worker/bin/Console.php`.

Units below `/etc/systemd/system` take precedence over the units shipped in `/usr/lib/systemd/system`.
A leftover unit from Statusengine 3 shadows the new unit and the service fails with `status=203/EXEC`.

Check which unit is currently used:

```bash
systemctl cat statusengine_cleanup.service statusengine_cleanup.timer
ls -l /etc/systemd/system/statusengine_cleanup.*
```

If a unit below `/etc/systemd/system` exists, disable it, move it out of the way and enable it again:

```bash
systemctl disable statusengine_cleanup.timer
mkdir -p /root/backup_units
mv /etc/systemd/system/statusengine_cleanup.* /root/backup_units/
systemctl daemon-reload
systemctl enable --now statusengine_cleanup.timer
```

After this step both units must be loaded from `/usr/lib/systemd/system`.

---

## Detect openITCOCKPIT packages
First all installed packages of openITCOCKPIT are determined and saved in the variable `openitcockpit_upd`:

```bash
openitcockpit_upd=$(apt-mark showmanual | grep openitcockpit | grep -v '^openitcockpit-statusengine3-worker$' | xargs echo)" "$(apt-mark showauto | grep openitcockpit | grep -v '^openitcockpit-statusengine3-worker$' | xargs echo)
```

!!! warning "Do not pin openitcockpit-statusengine3-worker"
    Since openITCOCKPIT 5.9 the package `openitcockpit-statusengine3-worker` is replaced by
    `openitcockpit-statusengine4-worker`. If the old package is requested explicitly, apt aborts with
    `openitcockpit-statusengine4-worker : Conflicts: openitcockpit-statusengine3-worker`.

---

## Change package sources
The Ubuntu package sources have to be changed to the new release Noble:

```bash
for f in /etc/apt/sources.list /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources; do
    [ -f "$f" ] && sed -i 's/jammy/noble/g' "$f"
done
```

This changes `/etc/apt/sources.list` as well as deb822 style sources such as `/etc/apt/sources.list.d/ubuntu.sources`.

Check that no Jammy source is left:

```bash
grep -rn jammy /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null
```

The `grep` command must not return any line.

---

## Upgrade
Now the actual upgrade from Ubuntu 22.04 to 24.04 starts:

```bash
apt update

# Simulation (check only) - must not report unresolved dependencies
apt -s full-upgrade $openitcockpit_upd apache2-

# Perform the upgrade
apt -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" full-upgrade $openitcockpit_upd apache2-
```

The `Dpkg::Options` keep existing configuration files without asking. Configuration files that are
managed by openITCOCKPIT are rewritten by the update script in the next step.

If the upgrade fails, continue with:

```bash
dpkg --configure -a
```

---

## Remove unnecessary packages
```bash
apt -y autoremove
```

---

## Start PHP after the upgrade
```bash
systemctl restart php8.3-fpm.service
```

---

## Update configuration
In the last step, all configuration files are updated and regenerated if necessary.

### openITCOCKPIT Master
If you are running the update on an openITCOCKPIT master system, use the following command:

```bash
openitcockpit-update --cc
```

### openITCOCKPIT Satellite
For openITCOCKPIT Satellite execute:

```bash
/opt/openitc/frontend/UPDATE.sh
```

---

## Reboot
A restart of the system is required to activate the new kernel:

```bash
reboot
```

---

## Verification
After the reboot, check that the upgrade was completed successfully:

```bash
grep PRETTY_NAME /etc/os-release
systemctl --failed
systemctl status php8.3-fpm.service
systemctl status statusengine_cleanup.timer
```

`systemctl --failed` must not list any unit, and the cleanup timer must be loaded from
`/usr/lib/systemd/system/statusengine_cleanup.timer`.
