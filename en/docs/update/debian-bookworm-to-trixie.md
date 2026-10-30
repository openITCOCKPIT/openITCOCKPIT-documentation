# Upgrade from Debian Bookworm (12) to Debian Trixie (13)

!!! danger "Backup"
    Before you begin, make sure you have created a **working backup** of your system!
    On virtual machines, create a snapshot as well, so the complete upgrade can be rolled back.

Run all commands as the `root` user.

To always use the latest version of openITCOCKPIT, it is important to keep the underlying operating system up to date.  
With this guide, you can upgrade your Debian Bookworm system to Debian Trixie.

!!! info "openITCOCKPIT version"
    The upgrade installs the latest openITCOCKPIT version that is available for Debian Trixie.
    It is not possible to keep the previous openITCOCKPIT version during the operating system upgrade.

---

## Requirements
- openITCOCKPIT version 5.x
- No packages containing `lxd`
- Internet access to download Docker repository keys
- At least 5 GB free disk space on `/` - about 2 GB of packages are downloaded during the upgrade

Check the free disk space before you start:

```bash
df -h /
```

---

## Remove all `lxd` packages
If `lxd` packages are installed on your system, they must be removed first. You can check with:

```bash
apt list --installed | grep lxd
```

If packages are installed, remove them with:

```bash
apt -y remove lxd*
```

---

## Add Docker repository
To install Docker from the official sources, the repository must be added:

```bash
# Create keyring directory
install -d -m 0755 /etc/apt/keyrings

# Store Docker GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc

# Add repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
| tee /etc/apt/sources.list.d/docker.list > /dev/null
```

---

## Install all updates (still on Bookworm)
Before starting the upgrade to Debian Trixie, make sure all available updates are installed:

```bash
apt update
apt -y full-upgrade
```

---

## Stop PHP-FPM service
Before the upgrade, PHP-FPM 8.2 should be stopped to avoid conflicts:

```bash
systemctl stop php8.2-fpm.service
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

## Identify openITCOCKPIT packages
Next, gather all installed openITCOCKPIT packages and store them in a variable:

```bash
openitcockpit_upd=$(apt-mark showmanual | grep openitcockpit | grep -v '^openitcockpit-statusengine3-worker$' | xargs echo)" "$(apt-mark showauto | grep openitcockpit | grep -v '^openitcockpit-statusengine3-worker$' | xargs echo)
```

!!! warning "Do not pin openitcockpit-statusengine3-worker"
    Since openITCOCKPIT 5.9 the package `openitcockpit-statusengine3-worker` is replaced by
    `openitcockpit-statusengine4-worker`. If the old package is requested explicitly, apt aborts with
    `openitcockpit-statusengine4-worker : Conflicts: openitcockpit-statusengine3-worker`.

---

## Update package sources
The Debian package sources now need to be adjusted to the new Trixie release:

```bash
# sources.list and any *.list files (e.g. docker.list)
sed -i 's/bookworm/trixie/g' /etc/apt/sources.list /etc/apt/sources.list.d/*.list

# deb822 style sources - default since Debian 13, may not exist on Bookworm
if [ -f /etc/apt/sources.list.d/debian.sources ]; then
    sed -ri 's/\bbookworm-security\b/trixie-security/g; s/\bbookworm-updates\b/trixie-updates/g; s/\bbookworm\b/trixie/g' /etc/apt/sources.list.d/debian.sources
fi
```

Verify that no Bookworm source is left:

```bash
grep -rn bookworm /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null
```

The `grep` command must not return any line.

---

## Perform the upgrade
Now start the actual upgrade:

```bash
apt update

# Simulation (check only) - must not report unmet dependencies
apt -s full-upgrade $openitcockpit_upd

# Perform the upgrade
apt -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" full-upgrade $openitcockpit_upd
```

The `Dpkg::Options` keep existing configuration files without asking. Configuration files that are
managed by openITCOCKPIT are rewritten by the update script in the last step.

On error:

```bash
dpkg --configure -a
```

---

## Remove unnecessary packages
```bash
apt autoremove
```

---

## Start PHP after the upgrade
```bash
systemctl restart php8.4-fpm.service
```

---

## Update configuration
As the last step, update and regenerate all configuration files if needed.

### openITCOCKPIT Master
If you are performing the update on an openITCOCKPIT Master system, use the following command:
```
openitcockpit-update --cc
```

### openITCOCKPIT Satellite
On an openITCOCKPIT Satellite, use the following command:
```
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
systemctl status php8.4-fpm.service
systemctl status statusengine_cleanup.timer
```

`systemctl --failed` must not list any unit, and the cleanup timer must be loaded from
`/usr/lib/systemd/system/statusengine_cleanup.timer`.
