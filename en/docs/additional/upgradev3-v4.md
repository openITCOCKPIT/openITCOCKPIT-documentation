# Upgrade openITCOCKPIT 3 to openITCOCKPIT 4

![oitc upgrade v3 - v4](/images/oitc_autobahn.png)

These instructions describe how to update your current installation of openITCOCKPIT 3.7.3 (or newer) to openITCOCKPIT 4.

!!! info
    "Before beginning the upgrade, please be sure to create a backup of your system!" We recommend testing both your backup and update processes in a test environment before using them on a live system.

### Prerequisites

-	Make sure that:
-	your openITCOCKPIT installation is up to date
-	openITCOCKPIT >= 3.7.3
-	all operating system updates have been installed
-	a working backup of your openITCOCKPIT installation is available (in case something goes wrong)
-	you have at least **20 GB** free hard disk space
-	Distributed Monitoring: it is assumed that **all** satellite systems will be also be updated to openITCOCKPIT v4
-	you execute all commands as `root` user

### Supported operating systems:

| Ubuntu Focal (20.04) | Ubuntu Bionic (18.04) | Ubuntu Xenial (16.04) | Ubuntu Trusty (14.04) | Debian Buster (10) | Debian Stretch (9) | Debian Jessie (8) |
|---|---|---|---|---|---|---|
|:fontawesome-solid-check:|:fontawesome-solid-check:|:fontawesome-solid-check: :fontawesome-solid-triangle-exclamation:|:fontawesome-solid-xmark:|:fontawesome-solid-check:|:fontawesome-solid-check: :fontawesome-solid-triangle-exclamation:|:fontawesome-solid-xmark:|


:fontawesome-solid-triangle-exclamation: **Ubuntu Xenial (16.04)**

openITCOCKPIT does not support Ubuntu Xenial. When updating to openITCOCKPIT 4, an upgrade to Ubuntu Bionic (18.04) will also be carried out.


:fontawesome-solid-triangle-exclamation: **Debian Stretch (9)**

openITCOCKPIT does not support Debian Stretch. When upgrading to openITCOCKPIT 4, an upgrade to Debian Buster (10) will also be carried out.

### Preparing the system

If you are using Ubuntu Xenial you will need to remove the lxd package as this could potentially cause errors when upgrading to Ubuntu Bionic and openITCOCKPIT v4.
```bash
#only run on Ubuntu Xenial!
apt-get remove lxd
```

### Step 1 - Update the operating system

```bash
apt-get update
apt-get dist-upgrade
```

### Step 2 - Back up the database

!!! warning
    Make sure that there is sufficient free hard disk space before you attempt to create a backup!

```bash
mysqldump --defaults-extra-file=/etc/mysql/debian.cnf --databases openitcockpit --flush-privileges --single-transaction --triggers --routines --events --hex-blob \
  --ignore-table=openitcockpit.nagios_externalcommands \
  --ignore-table=openitcockpit.nagios_hostchecks \
  --ignore-table=openitcockpit.nagios_logentries \
  --ignore-table=openitcockpit.nagios_servicechecks \
  --ignore-table=openitcockpit.nagios_systemcommands \
  --ignore-table=openitcockpit.nagios_timedeventqueue \
  --ignore-table=openitcockpit.nagios_timedevents \
  --ignore-table=openitcockpit.statusengine_dbversion \
  --ignore-table=openitcockpit.statusengine_host_acknowledgements \
  --ignore-table=openitcockpit.statusengine_host_downtimehistory \
  --ignore-table=openitcockpit.statusengine_host_notifications \
  --ignore-table=openitcockpit.statusengine_host_scheduleddowntimes \
  --ignore-table=openitcockpit.statusengine_host_statehistory \
  --ignore-table=openitcockpit.statusengine_hostchecks \
  --ignore-table=openitcockpit.statusengine_hoststatus \
  --ignore-table=openitcockpit.statusengine_logentries \
  --ignore-table=openitcockpit.statusengine_nodes \
  --ignore-table=openitcockpit.statusengine_perfdata \
  --ignore-table=openitcockpit.statusengine_service_acknowledgements \
  --ignore-table=openitcockpit.statusengine_service_downtimehistory \
  --ignore-table=openitcockpit.statusengine_service_notifications \
  --ignore-table=openitcockpit.statusengine_service_scheduleddowntimes \
  --ignore-table=openitcockpit.statusengine_service_statehistory \
  --ignore-table=openitcockpit.statusengine_servicechecks \
  --ignore-table=openitcockpit.statusengine_servicestatus \
  --ignore-table=openitcockpit.statusengine_tasks \
  --ignore-table=openitcockpit.statusengine_users \
  >/root/openitcockpit_dump_v3_upgrade.sql
```


### Step 3 - Carry out the openITCOCKPIT v4 compatibility check

!!! danger
    "Note for users of the i-doit and discovery module" The module `openitcockpit-module-discovery` and `openitcockpit-module-idoit` sind in openITCOCKPIT 4 **are not available** in openITCOCKPIT 4. If you are using these modules, you should **not** update to openITCOCKPIT 4 at the current time!

To ensure that your system is capable of being updated to openITCOCKPIT 4.x, we provide a compatibility script for checking your system(s).

Execute the following script on your openITCOCKPIT instance:

Führen Sie das Skript auf ihrer openITCOCKPIT Instanz aus.

```bash
curl -s https://raw.githubusercontent.com/openITCOCKPIT/openITCOCKPIT/development/bin/scripts/oitc3to4.sh | sudo /bin/bash
```

![oitc 3-4](/images/oitc3to4.png)


**No changes have been made to your system at this point!**

!!! danger
    "Warning!" Do not continue with the update if you receive any errors or warnings after carrying out the compatibility check!


First resolve the issues that have been highlighted and run the script again. Once you have resolved all errors, you can continue with the update.


#### Step 3.1 – Distributed monitoring

It is assumed that all satellite systems have been updated to openITCOCKPIT 4.
This is important, because with the current release it is not possible to connect openITCOCKPIT 3.x satellites to an openITCOCKPIT 4.x master system. If, for any reason, you are currently **unable to update your satellite systems**, do not update your master system at this time!

#### Step 3.2 – Updating openITCOCKPIT

!!! warning
    "Stable SSH connection is required!" The update process may take a while. To prevent SSH connection problems, we recommend using `tmux` or `screen`.

**The compatibility checking script displays the commands required to update your openITCOCKPIT installation based on the modules installed and the distribution being used. The update commands are individually generated for each system**

!!! danger
    DO NOT use any other commands to update your system!

##### Ubuntu users

Make sure the universe repositories have been activated on your system.

```bash
add-apt-repository universe
```

##### Debian users

Make sure that the non-free repositories have been activated on your system.

`/etc/apt/sources.list`

```bash
deb http://ftp.de.debian.org/debian/ buster main contrib non-free
deb http://ftp.de.debian.org/debian/ buster-updates main contrib non-free
deb http://security.debian.org/ buster/updates main contrib non-free
```

**You can now execute the commands from the compatibility script to update your openITCOCKPIT installation**

During the update you may be asked if you want to overwrite some configuration files with newer versions. These configuration files belong to the operating system, so you can choose whether you want to keep your current versions or update to the newer versions. This will have no impact on the openITCOCKPIT update.

##### Ubuntu Xenial and Debian Stretch users

The openITCOCKPIT update will also update your Linux distribution (Ubuntu Xenial to Ubuntu Bionic and Debian Stretch to Debian Buster). If you have integrated your own software or third-party repositories, you must ensure that these are compatible with Ubuntu Bionic or Debian Buster.

### Resetting user passwords

After the update process has completed, all [user passwords must be reset](../reset-passwords/). If, however, you are using LDAP, this does not have to be done.

#### Passwort eines Benutzers zurücksetzen

The following command can be used to reset an individual user's password:

```bash
oitc reset_password --print --enable
```

The system will generate a new, randomly generated password. This will then be sent to the user's registered email address.

`--print` will also show the new password in the terminal.

`--no-email` will NOT send the new password to the user's email address.

![reset password](/images/oitc_reset_password.png)

![password mail](/images/oitc_new_password_mail.png)

#### Reset all user passwords

The following command can be used to reset all local user passwords:

```bash
oitc update3_to4 --reset-all-passwords
```

The system will generate a new, randomly generated password. These will then be sent to each user's respective email address.

### Step 5 - Clear browser cache

Before logging into your new openITCOCKPIT interface, you should clear your browser cache

Mozilla Firefox: <https://support.mozilla.org/en-US/kb/how-clear-firefox-cache>

Google Chrome: <https://support.google.com/accounts/answer/32050?co=GENIE.Platform%3DDesktop&hl=en>

#### Step 5.1 – Log into the new openITCOCKPIT interface

We recommend you now [update the monitoring configuration](../../monitoring/basic-principles/#export). This step will ensure that all configuration files relevant to the monitoring process are written.

### Step 6 - Restart the NSTA (only applies to distributed monitoring)

To begin processing your satellite check results, you will need to restart the NSTA daemon

```bash
systemctl restart nsta
```

### Step 7 - Reboot the system

A system restart is recommended, especially when updating Ubuntu Xenial or Debian Stretch.

### Updating the openITCOCKPIT satellite systems (only applies to distributed monitoring)

#### Update the operating system

**All system updates must be installed first**

```bash
apt-get update
apt-get dist-upgrade
```

**Then run the openITCOCKPIT satellite checklist script and follow the instructions**

```bash
curl -s https://raw.githubusercontent.com/openITCOCKPIT/openITCOCKPIT/development/bin/scripts/oitcSat3to4.sh | sudo /bin/bash
```

### Known problems

#### All distributions

The Modules `openitcockpit-module-discovery` and `openitcockpit-module-idoit` are currently **not** available for openITCOCKPIT 4. If you use these modules, consider **not** updating your system.

##### No login possible after password reset

If the password has been correctly reset, but the user is still unable to log into the openITCOCKPIT interface (error message: `Invalid username or password`), the user must be manually activated in the database. This can be done with the following SQL command:

```sql
UPDATE users SET is_active = 1 WHERE users.email= 'user@example.com';
```

##### Warnings and dependency issues during the upgrade process

During the update process, you will see messages similar to these:

```bash
Unpacking openitcockpit-module-distribute (4.0.4-20200721154853bionic) over (3.7.3-1ubuntu16.04) ...
dpkg: warning: unable to delete old directory '/etc/openitcockpit/app/Plugin/DistributeModule/Config/Schema': Directory not empty
dpkg: warning: unable to delete old directory '/etc/openitcockpit/app/Plugin/DistributeModule/Config': Directory not empty
dpkg: warning: unable to delete old directory '/etc/openitcockpit/app/Plugin/DistributeModule': Directory not empty
dpkg: warning: unable to delete old directory '/usr/share/openitcockpit/app/Plugin/DistributeModule': Directory not empty
```

or:

```bash
Removing php7.0-cli (7.0.33-0ubuntu0.16.04.15) ...
dpkg: php7.0-mysql: dependency problems, but removing anyway as you requested:
 phpmyadmin depends on php-mysql | php-mysqli | php-mysqlnd; however:
  Package php-mysql is not configured yet.
  Package php-mysqli is not installed.
  Package php7.2-mysql which provides php-mysqli is not configured yet.
  Package php7.0-mysql which provides php-mysqli is to be removed.
  Package php-mysqlnd is not installed.
  Package php7.2-mysql which provides php-mysqlnd is not configured yet.
  Package php7.0-mysql which provides php-mysqlnd is to be removed.
 phpmyadmin depends on php-mysql | php-mysqli | php-mysqlnd; however:
  Package php-mysql is not configured yet.
  Package php-mysqli is not installed.
  Package php7.2-mysql which provides php-mysqli is not configured yet.
  Package php7.0-mysql which provides php-mysqli is to be removed.
  Package php-mysqlnd is not installed.
  Package php7.2-mysql which provides php-mysqlnd is not configured yet.
  Package php7.0-mysql which provides php-mysqlnd is to be removed.
```

You can ignore these messages.

##### No satellite check results on the master server

If the master server is not receiving any check results from its satellite systems, [updating the monitoring](../../monitoring/basic-principles/#export) and restarting the NSTA may resolve the issue.

```bash
systemctl restart nsta
```

##### Checkmk
`Filesystem checks: UNKN - check failed - please submit a crash report!`

Edit the service template `CHECK_MK_DF` and set the following value for ARG1:

```
{'levels': (80.0, 90.0)}
```

![checkmk df template](/images/edit_checkmk_df_servicetemplate.png)

![checkmk df template arg1](/images/new_checkmk_df_arg1.png)


### Troubleshooting

#### Network error

If you find you are having connectivity errors with your system, you can try to repair the installation. To do this, use the following command:

```bash
apt-get install -f
```

#### If your openITCOCKPIT version is < 3.7.3

For the update process to complete successfully, you must be using at least version 3.7.3 of openITCOCKPIT. Please note our [blog posts]((https://openitcockpit.io/blog/#blog) if you want to update from an older version 3 - especially if you are working with version 3.5 or older. It will be necessary to make manual changes if you want to use the newer version of the performance graph.

#### Table nagios servicechecks is 36626 MB but /var/lib/mysql only has 16316 MB free disk space

During the update process, all MySQL tables are converted from UTF8 to UTF8mb4. This process will require a certain amount of hard drive space. Please do not ignore these errors.

#### openITCOCKPIT v4 update from Ubuntu Xenial 16.04 to Bionic 18.04 fails due to lxd package

If the update of Ubuntu Xenial fails due to the lxd package and the following error appears:

```bash
Old bridge configuration detected in /etc/default/lxd-bridge, upgrading
Unsetting deprecated profile options
Error: unknown command "profile" for "lxc"

Did you mean this?
    Profil

Run 'lxc --help' for usage.
dpkg: error processing package lxd (--configure):
 installed lxd package post-installation script subprocess returned error exit status 1

....

Errors  occurred while processing:
 lxd
E: Sub-process /usr/bin/dpkg returned an error code (1)
```

The openITCOCKPIT web interface is not visible in the browser.

The following commands must be executed:

```bash
apt-get install -f
apt-get remove lxd
apt-get autoremove
reboot

#after reboot you need to trigger the UPGRADE script from itcockpit which was not triggered during the upgrade
/opt/openitc/frontend/bin/scripts/UPGRADE.sh
```

The web interface should then be visible and the distribution update should be completed.

#### What if I use Ubuntu Trusty or Debian Jessie?

Please get in touch with us using our [Sales contact form](https://www.allgeier-its.com/unternehmen/#kontakt)
