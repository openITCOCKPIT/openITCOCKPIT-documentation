# Troubleshooting

## I've created a host, but I can't find it in the hosts list

A newly created host will not automatically appear in the main host list. Instead, newly created hosts can be found in the host list under the `Not monitored` tab. This means that the host exists in openITCOCKPIT, but is not yet known to the monitoring engine.

You will first need to [export the configuration](../../monitoring/basic-principles/#how-do-i-carry-out-an-export) in order for the newly created host to be monitored.

## sudo_server

**Error message**

Englisch:
```
Attention! Lost connection to SudoServer. External commands may not work. Please try to reload this page
```

Deutsch:
```
Achtung! Verbindung zum SudoServer verloren. Externe Befehle funktionieren möglicherweise nicht. Bitte versuche diese Seite neu zu laden.
```



**Problem**

`sudo_server.service` is not running or the web interface has lost the connection.

**Solution**

Reload the web page.
If the problem still exists, restart the sudo_server service.

```
systemctl restart sudo_server.service
```

If the problem persists, you can [contact us for further assistance](../support/#support).

## Debugging/Troubleshooting Page

### Interface information

The interface information provides you with an overview of your openITCOCKPIT server. Information on the version and edition being used will also be displayed here. In addition, information on the monitoring engine being used as well as the paths to the configuration, backups and command interface are also provided here.

![interface info](/images/debugging-interfaceinfo.png)

### Process information

Under `Administration -> System tools -> Debugging` you will find the debugging (troubleshooting) overview. Using process information you can get an overview of the processes required for running openITCOCKPIT.

![process info](/images/debugging-processinfo.png)

### SQL Query Log

The SQL Query Log displays all SQL queries that are executed in the SQL database.

![querylog](/images/debugging-sqlquerylog.png)

!!! tip
    tip For SQL query logging to take place, the option `'log' => true` must be set in the file `/opt/openitc/frontend/config/datasource.php`!

### Server information

The server information contains various basic data about your openITCOCKPIT server. This includes information about the operating system, web server, basic PHP information and the CPU.

### CPU load and RAM/hard disk utilisation of the openITCOCKPIT server

The openITCOCKPIT web interface offers an overview of the current CPU, RAM, SWAP and hard disk utilisation. This can be viewed on the debugging page.

### Queuing engine
You can find an overview of the queuing engine on the debugging page. All the queues for the Gearman job server and their status are displayed here.
![gearman-job-server overview](/images/debugging-queuingengine.png)

### Email configuration
You can get an overview of the current email configuration on the debugging page under "Email configuration".

### PHP configuration
An overview of the current overall PHP configuration can be found at the end of the debugging page.

## System Health
The System Health display provides information about the overall status of the openITCOCKPIT system. See [System Health display](../../monitoring/user-interface/#system-health)

## Where can I find the various log files?

### Naemon log

The log file for the Naemon monitoring engine can be found at

```
/opt/openitc/nagios/var/nagios.log
```

It is recommended to view the log file with the `oitc debug --tailf` command, as this replaces the Unix timestamps and UUIDs, which significantly increases the readability of the log file.

### openITCOCKPIT web frontend

```
/opt/openitc/logs/frontend/
```

### Gearman Job Server

```
/var/log/gearman-job-server/gearmand.log
```

### PHP-FPM

```
/var/log/php7.{0,1,2,3,4,...}-fpm.log
```

### NGINX

```
/opt/openitc/logs/nginx/
```

### MySQL

```
/var/log/mysql/error.log
```

## Refresh monitoring configuration is stucking

In case of an error with the openITCOCKPIT backend, it could happen that the refresh of the monitoring configuration is running forever.
The refresh is done by a separate background worker. To resolve the issue please follow the steps described below.
The current state of the refresh is stored in the openITCOCKPIT database, so rebooting the machine will not resolve the issue.

![Running refresh of monitoring configuration](/images/troubleshooting/refresh_monitoring_configuration.png)

1. Stop the openITCOCKPIT `gearman_worker` background process
```plaintext
systemctl stop gearman_worker.service
```

2. Now execute the command `gearadmin --status`, to verify that no pending Jobs are waiting in the `oitc_gearman` queue. If there are no pending jobs, the output should look something like this:
```plaintext
oitc_gearman	0	0	0           # Pending jobs    Actively running    Available workers
```

3. If there are pending jobs, run the following command to truncate the queue. Repeat this until no more pending jobs are waiting in the queue.
```plaintext
gearman -w -c 1 -t 1000 -f oitc_gearman > /dev/null
```

4. Truncate the table `exports` in the `openitcockpit` database, to reset the current state of the refresh.
```
mysql --defaults-extra-file=/opt/openitc/etc/mysql/mysql.cnf -e "TRUNCATE TABLE openitcockpit.exports;"
```

5. Restart the `gearman_worker` service
```plaintext
systemctl start gearman_worker.service
```

### Refresh is still crashing

Under some rare circumstances it could happen that the `gearman_worker` is crashing due to an error within the code itself.
To print out any error messages, follow the steps 1 to 4 as described above. Instead of starting the  `gearman_worker` via systemd in the background,
start it in foreground mode and refresh the monitoring configuration via the openITCOCKPIT interface.

```
export OITC_DEBUG=1

oitc gearman_worker
```

Check the terminal for any errors.

![gearman_worker running in foreground mode to print out error message](/images/troubleshooting/gearman_worker_foreground_mode.JPG)


## Recommended packages

openITCOCKPIT installs some optional **but still important** packages through weak dependencies. A good example is the MySQL server.
While openITCOCKPIT requires a MySQL server, the MySQL server can be installed on a different server, so openITCOCKPIT only recommends to install
the `mysql-server` package rather than having a hard dependency.

![apt showing recommended packages](/images/troubleshooting/apt_recommended.jpg)

Another example is the `Grafana Module`. While it is nice to have Grafana installed, it is not a must have. So openITCOCKPIT just recommends to install Grafana
but it has no hard dependency for it.

By default, Ubuntu and Debian systems are installing recommended packages. How ever, _some cloud providers_ have configured `apt`
to **not install** recommended packages.

To see if your apt is configured to **not install** recommended packages, you can use this command
```
grep -ri 'Install-Recommends\|Install-Suggests' /etc/apt
```

This example shows an apt configuration, where the installation of suggested and recommended packages is disabled:
```
root@ubuntu-4gb-hel1-1:~# grep -ri 'Install-Recommends\|Install-Suggests' /etc/apt
/etc/apt/apt.conf.d/01norecommends:APT::Install-Recommends "0";
/etc/apt/apt.conf.d/01norecommends:APT::Install-Suggests "0";
```

### RHEL based systems

On RHEL based systems we use the same technique. Instead of "Recommended packages", RHEL based systems call these `weak dependencies`.

![weak dependencies on RHEL](/images/troubleshooting/RHEL_weak_dependencies.jpg)

### Unsupported distribution or /etc/mysql/debian.cnf is missing!

If you see this error message when you try to run `/opt/openitc/frontend/SETUP.sh` most likely the recommended `mysql-server` package was not installed on your system.
To resolve the issue, run `apt-get install mysql-server` on Ubuntu and `apt-get install mariadb-server` on Debian systems and restart the `SETUP.sh`.

![mysql server is missing](/images/troubleshooting/unsupported_distribution.jpg)

### /opt/openitc/nagios/libexec: No such file or directory

In this case, you have not installed the default set of monitoring plugins. Run `apt-get install openitcockpit-monitoring-plugins` to resolve this issue.

### No checks are executed

In case you get `(service check orphaned, is the mod-gearman worker on queue 'service' running?)` as service check output, please make sure that Mod-Gearman
is installed and running.

To ensure that the Mod-Gearman Worker is installed on your openITCOCKPIT Server execute `apt-get install openitcockpit-mod-gearman-worker-go-local`

If this does not resolve the issue, please take a look at the [Mod-Gearman section](/additional/mod-gearman/) for more information.

### Grafana is missing

In case your openITCOCKPIT interface has no `Grafana`, you have to install the package: `apt-get install openitcockpit-module-grafana`.


## Empty package manager

!!! info
    This only affects openITCOCKPIT versions **3.x** and **4.x**, which are End of Life.
    For openITCOCKPIT 5 this is **not** required.

openITCOCKPIT has its own package manager, which makes it easy to install openITCOCKPIT modules.
The list of available modules is retrieved from a server. The server address was changed in 2025,
from
```
packagemanager.it-novum.com
```

to
```
packagemanager.openitcockpit.io
```

Since openITCOCKPIT versions 3.x and 4.x are no longer maintained, the server address must be changed manually.

### openITCOCKPIT 3.x

Open the file `/usr/share/openitcockpit/app/Console/Command/Task/SystemMetricsTask.php` and replace in line 90 `packagemanager.it-novum.com`
with `packagemanager.openitcockpit.io`.

GitHub: [https://github.com/openITCOCKPIT/openITCOCKPIT/blob/779a60216416ac8bb5c4cb73f82f3515ac65ed46/app/Console/Command/Task/SystemMetricsTask.php#L90](https://github.com/openITCOCKPIT/openITCOCKPIT/blob/779a60216416ac8bb5c4cb73f82f3515ac65ed46/app/Console/Command/Task/SystemMetricsTask.php#L90)

Open the file `/usr/share/openitcockpit/app/src/itnovum/openITCOCKPIT/Core/PackagemanagerRequestBuilder.php` and replace in line 45 `packagemanager.it-novum.com` with `packagemanager.openitcockpit.io`.

GitHub: [https://github.com/openITCOCKPIT/openITCOCKPIT/blob/779a60216416ac8bb5c4cb73f82f3515ac65ed46/app/src/itnovum/openITCOCKPIT/Core/PackagemanagerRequestBuilder.php#L45](https://github.com/openITCOCKPIT/openITCOCKPIT/blob/779a60216416ac8bb5c4cb73f82f3515ac65ed46/app/src/itnovum/openITCOCKPIT/Core/PackagemanagerRequestBuilder.php#L45)

From now on, the package manager should work again.

### openITCOCKPIT 4.x

Open the file `/opt/openitc/frontend/src/Command/SystemMetricsCommand.php` and replace in line 111 `packagemanager.it-novum.com`
with `packagemanager.openitcockpit.io`.

GitHub: [https://github.com/openITCOCKPIT/openITCOCKPIT/blob/e24ff4327edd98bf8dfcf12c404ecbb24f4eb758/src/Command/SystemMetricsCommand.php#L111](https://github.com/openITCOCKPIT/openITCOCKPIT/blob/e24ff4327edd98bf8dfcf12c404ecbb24f4eb758/src/Command/SystemMetricsCommand.php#L111)

Open the file `/opt/openitc/frontend/src/itnovum/openITCOCKPIT/Core/PackagemanagerRequestBuilder.php` and replace in lines 32 and 45 `packagemanager.it-novum.com` with `packagemanager.openitcockpit.io`.

GitHub: [https://github.com/openITCOCKPIT/openITCOCKPIT/blob/e24ff4327edd98bf8dfcf12c404ecbb24f4eb758/src/itnovum/openITCOCKPIT/Core/PackagemanagerRequestBuilder.php#L32-L45](https://github.com/openITCOCKPIT/openITCOCKPIT/blob/e24ff4327edd98bf8dfcf12c404ecbb24f4eb758/src/itnovum/openITCOCKPIT/Core/PackagemanagerRequestBuilder.php#L32-L45)

From now on, the package manager should work again.

