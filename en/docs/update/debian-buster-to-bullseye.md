# Update Debian Buster (10) to Debian Bullseye (11)

!!! danger "Backup"
    Before you start, make sure you have a **working backup** of your system!

Please make sure to run all commands as `root` user.

In order to always be able to use the latest version of openITCOCKPIT, it is important to keep the underlying operating system up to date.
You can use this guide to upgrade your Debian Buster System to Debian Bullseye.

!!! warning "End of life"
    Debian 10 (Buster) reached its end of life in June 2024 and Debian 11 (Bullseye) in August 2026.
    Neither release receives security updates anymore. Use this guide only to migrate an existing
    installation - a fresh installation of a supported release is usually the better choice.

##  Requirements
 -  openITCOCKPIT in version 4.x
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
systemctl stop php7.3-fpm.service
```

## Detect openITCOCKPIT packages
First all installed packages of openITCOCKPIT are determined and saved in the variable `openitcockpit_upd`.
```
openitcockpit_upd=$(apt-mark showmanual | grep openitcockpit | xargs echo)" "$(apt-mark showauto | grep openitcockpit | xargs echo)
```

## Change package sources
Now the package sources can be changed to the next Debian release
```
echo "deb http://deb.debian.org/debian bullseye main contrib non-free" > /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian bullseye main contrib non-free" >> /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://security.debian.org/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian bullseye-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free" >> /etc/apt/sources.list

sed -i 's/buster/bullseye/g' /etc/apt/sources.list.d/*.list
```

## Perform the upgrade
Now the actual upgrade from Debian 10 to 11 starts.
```
apt update
apt -y full-upgrade $openitcockpit_upd php-json php-curl php-gearman php-xml
```

### Update PHP
Now all PHP packages will be updated.
```
systemctl stop php7.3-fpm.service
```

```
dpkg -l | awk '/php7.3/ { print $2}' | sed 's/php7.3/php7.4/' | xargs apt-get install -y
dpkg -l | awk '/php7.3/ { print $2}' | xargs apt-get purge -y

systemctl restart php7.4-fpm.service
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
