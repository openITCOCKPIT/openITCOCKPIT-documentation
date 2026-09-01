# Update Ubuntu Jammy (22.04) to Ubuntu Noble (24.04)

!!! danger "Backup"
    Before you start, make sure you have a **working backup** of your system!

Please make sure to run all commands as `root` user.

In order to always be able to use the latest version of openITCOCKPIT, it is important to keep the underlying operating system up to date.
You can use this guide to upgrade your Ubuntu Jammy System to Ubuntu Noble.

##  Requirements
 -  openITCOCKPIT in version 4.x


## Installation of all updates
Before you start updating Ubuntu, please make sure that all available updates have been installed.

```
apt update && apt -y full-upgrade
```

## Stop PHP-FPM service
```
systemctl stop php8.1-fpm.service
```

## Detect openITCOCKPIT packages
First all installed packages of openITCOCKPIT are determined and saved in the variable `openitcockpit_upd`.
```
openitcockpit_upd=$(apt-mark showmanual | grep openitcockpit | xargs echo)" "$(apt-mark showauto | grep openitcockpit | xargs echo)
```

## Change package sources
Now the package sources can be changed to the next Ubuntu release
```
sed -i 's/jammy/noble/g' /etc/apt/*.list
sed -i 's/jammy/noble/g' /etc/apt/*/*.list
```

## Upgrade
Now the actual upgrade from Ubuntu 22.04 to 24.04 starts.
```
apt update && apt -y full-upgrade $openitcockpit_upd apache2-
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
