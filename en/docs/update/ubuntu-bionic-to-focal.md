# Update Ubuntu Bionic (18.04) to Ubuntu Focal (20.04)

!!! danger "Backup"
    Before you start, make sure you have a **working backup** of your system!

Please make sure to run all commands as `root` user.

In order to always be able to use the latest version of openITCOCKPIT, it is important to keep the underlying operating system up to date.
You can use this guide to upgrade your Ubuntu Bionic System to Ubuntu Focal.

!!! warning "End of life"
    Ubuntu 18.04 (Bionic) reached its end of life in May 2023 and Ubuntu 20.04 (Focal) in May 2025.
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
Before you start updating Ubuntu, please make sure that all available updates have been installed.

```
apt update && apt -y full-upgrade
```

## Disable MySQL Query Cache
The MySQL Query Cache got removed with [MySQL 8.0](https://dev.mysql.com/blog-archive/mysql-8-0-retiring-support-for-the-query-cache/).
Therefore it is important to make sure that the Query Cache feature is disabled in your MySQL configuration.
```
sed -i 's/^[ ]*query_cache/#query_cache/g' /etc/mysql/mysql.conf.d/*.cnf
```

## Stop PHP-FPM service
```
systemctl stop php7.2-fpm.service
```

## Change package sources
Now the package sources can be changed to the next Ubuntu release
```
sed -i 's/bionic/focal/g' /etc/apt/*.list
sed -i 's/bionic/focal/g' /etc/apt/*/*.list
```

## Upgrade
Now the actual upgrade from Ubuntu 18.04 to 20.04 starts.
```
apt update && apt -y full-upgrade
```

During the upgrade, the system may ask you various questions. You should answer them as follows.

### libc6
Any queries regarding `libc6` must be answered with `Yes`.
![libc6 configure](/images/updates/ubuntu-bionic/libc6.png){ align=center }

### MySQL
Most likely, restarting the MySQL server will fail. This can be ignored.

![mysql restart will fail](/images/updates/ubuntu-bionic/mysql.png){ align=center }

### openssh-server
Keep the current configuration of your OpenSSH server

### phpMyAdmin
If you have phpMyAdmin installed on your system, answer this question with `Yes`

![configure phpMyAdmin](/images/updates/ubuntu-bionic/mysql.png){ align=center }

### Sub-process error
It can happen that the installation aborts with error `E: Sub-process /usr/bin/dpkg returned an exit code (1)`.
This can be ignored.

![E: Sub-process error](/images/updates/ubuntu-bionic/fehler.png){ align=center }

### Update PHP
Now all PHP packages will be updated.
```
systemctl stop php7.2-fpm.service
```

```
dpkg -l | awk '/php7.2/ { print $2}' | sed 's/php7.2/php7.4/' | xargs apt-get install -y
dpkg -l | awk '/php7.2/ { print $2}' | xargs apt-get purge -y
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
