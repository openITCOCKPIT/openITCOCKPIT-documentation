# Update Debian Bullseye (11) to Debian Bookworm (12)

!!! danger "Backup"
    Before you start, make sure you have a **working backup** of your system!

Please make sure to run all commands as `root` user.

In order to always be able to use the latest version of openITCOCKPIT, it is important to keep the underlying operating system up to date.
You can use this guide to upgrade your Debian Bullseye System to Debian Bookworm.

!!! warning "End of life"
    Debian 11 (Bullseye) reached its end of life in August 2026 and no longer receives security updates.
    Use this guide only to migrate an existing installation - a fresh installation of a supported
    release is usually the better choice.

##  Requirements
 -  openITCOCKPIT in version 4.x or 5.x
 -  No packages containing `lxd`


## Removal of all `lxd` packages
If you have `lxd` packages installed on your system, they must be removed first. You can check this with the command
```
apt list --installed | grep lxd
```

If any `lxd` packages were found, remove them like so
```
apt -y remove lxd*
```

## Installation of all updates
Before you start updating Debian, please make sure that all available updates have been installed.

```
apt update
apt -y full-upgrade
```

## Stop PHP-FPM service
```
systemctl stop php7.4-fpm.service
```

## Detect openITCOCKPIT packages
First all installed packages of openITCOCKPIT are determined and saved in the variable `openitcockpit_upd`.
```
openitcockpit_upd=$(apt-mark showmanual | grep openitcockpit | xargs echo)" "$(apt-mark showauto | grep openitcockpit | xargs echo)
```

## Change package sources
Now the package sources need to be changed to the next Debian release. Do not overwrite
`/etc/apt/sources.list` - it may contain a mirror or proxy configuration, and the openITCOCKPIT
repository is stored in `/etc/apt/sources.list.d/openitcockpit.sources`.

Replace the release name in all source files - this includes the `*.sources` files in deb822 format:

```bash
for f in /etc/apt/sources.list /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources; do
    [ -f "$f" ] && sed -i 's/bullseye/bookworm/g' "$f"
done
```

Debian 12 introduced the `non-free-firmware` component. Add it to your sources if it is missing:

```bash
sed -i 's/ main contrib non-free$/ main contrib non-free non-free-firmware/' /etc/apt/sources.list
```

Verify that no Bullseye source is left:

```bash
grep -rn bullseye /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null
```

The `grep` command must not return any line.

## Perform the upgrade
Now the actual upgrade from Debian 11 to 12 starts.
```bash
apt update

# Simulation (check only) - must not report unmet dependencies
apt -s full-upgrade $openitcockpit_upd php-json php-curl php-gearman php-xml

# Perform the upgrade
apt -y full-upgrade $openitcockpit_upd php-json php-curl php-gearman php-xml
```

### Update PHP
Now all PHP packages will be updated. Debian 12 ships PHP 8.2, the old 7.4 packages have to be removed.

Make sure the PHP-FPM 7.4 service is stopped - the upgrade may have started it again:

```bash
systemctl stop php7.4-fpm.service
```

```bash
dpkg -l | awk '/^ii +php7\.4/ { print $2 }' | xargs -r apt-get purge -y
rm -rf /etc/php/7.4/
```

### Set the timezone in php.ini (optional)

openITCOCKPIT uses the timezone of the PHP configuration. Check the current value in
`/etc/php/8.2/fpm/php.ini`:

```bash
grep '^;\?date.timezone' /etc/php/8.2/fpm/php.ini
```

If the value is empty or does not match your timezone, set it to the timezone of the system:

```bash
timezone=$(timedatectl show -p Timezone --value)
sed -i "s|^;\?date.timezone =.*|date.timezone = ${timezone}|" /etc/php/8.2/fpm/php.ini
```

### PHP FPM (re-)start
```bash
systemctl restart php8.2-fpm.service
```

### Update configuration
In the last step, all configuration files are updated and regenerated if necessary.

#### openITCOCKPIT Master
If you are running the update on an openITCOCKPIT master system, use the following command
```
openitcockpit-update --cc
```

#### openITCOCKPIT Satellite
For openITCOCKPIT Satellite execute
```
/opt/openitc/frontend/UPDATE.sh
```

A restart of the system is recommended to complete the update
```
reboot
```
