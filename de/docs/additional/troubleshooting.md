# Troubleshooting

## Ich habe einen Host erstellt, finde ihn aber nicht in der Host-liste

Ein neu erstellter Host wird nicht in der Host-liste angezeigt. Neu erstellte Hosts finden Sie in der Host-liste unter
dem Reiter `Nicht überwacht`. Dies bedeutet, dass der Host zwar in openITCOCKPIT existiert, der Monitoring Engine aber
nicht bekannt ist.

Sie müssen einen [Export der Konfiguration](../../monitoring/basic-principles/#wie-fuhre-ich-einen-export-aus)
durchführen, damit der Host überwacht wird.

## sudo_server

**Fehlermeldung**

Englisch:
```
Attention! Lost connection to SudoServer. External commands may not work. Please try to reload this page
```

Deutsch:
```
Achtung! Verbindung zum SudoServer verloren. Externe Befehle funktionieren möglicherweise nicht. Bitte versuche diese Seite neu zu laden.
```



**Problem**

`sudo_server.service` läuft nicht oder die Weboberfläche hat die Verbindung verloren.

**Lösung**

Laden Sie die Webseite neu.

Ist das Problem immer noch vorhanden, starten Sie den Dienst sudo_server neu.

```
systemctl restart sudo_server.service
```

Sollte das Problem weiterhin bestehen, können Sie sich [mit uns in Verbindung setzen](../support/#support).

## Debugging / Fehlerbeseitigungsseite

### Interface Informationen (Informationen zur Schnittstelle)

Über die Interface-Informationen bekommen Sie eine Übersicht Ihres openITCOCKPIT Servers. Hier werden Informationen zur
genutzten Version und Edition angezeigt. Darüber hinaus werden hier auch Informationen zur verwendeten Monitoring-Engine
sowie deren Pfade zur Konfiguration, den Backups und dem Command Interface bereitgestellt.

![interface info](/images/debugging-interfaceinfo.png)

### Prozessinformationen

Unter `Verwaltung -> Systemwerkzeuge -> Fehlerbeseitigung` finden Sie die Debugging (Fehlerbeseitigung) Übersicht. Über
die Prozessinformationen bekommen Sie eine Übersicht der Prozesse, die für den Betrieb von openITCOCKPIT notwendig sind.

![process info](/images/debugging-processinfo.png)

### SQL Query Log

Im SQL Query Log werden alle SQL Queries angezeigt, die in der SQL Datenbank vonstattengehen.

![querylog](/images/debugging-sqlquerylog.png)

!!! tip
    Damit das logging der SQL Queries gelingt, muss die Option `'log' => true` in der
    Datei `/opt/openitc/frontend/config/datasource.php` gesetzt werden!

### Server Informationen

Die Server Informationen halten verschiedene Basisdaten zu Ihrem openITCOCKPIT Server bereit. Darunter fallen
Informationen zum Betriebssystem, Webserver, Basis PHP Informationen und der CPU.

### CPU Load und RAM / Festplatten auslastung des openITCOCKPIT Servers

Die openITCOCKPIT Weboberfläche bietet eine Übersicht der aktuellen CPU, RAM, SWAP sowie Festplattenauslastung an.
Diese ist auf der Debugging-Seite einsehbar.

### Queuing Engine
Eine Übersicht der Queuing Engine finden Sie auf der Debugging-Seite. Hier werden alle Queues des Gearman-Job-Servers sowie deren Status angezeigt.
![gearman-job-server overview](/images/debugging-queuingengine.png)

### E-Mail Konfiguration
Eine Übersicht der aktuellen E-Mail Konfiguration erhalten Sie auf der Debugging-Seite unter dem Punkt "E-Mail konfiguration".

### PHP Konfiguration
Eine Übersicht der aktuellen gesamten PHP Konfiguration erhalten Sie am Ende der Debugging-Seite.

## System Health / Systemzustand
Die System Health Anzeige gibt aufschluss über den gesamtstatus des openITCOCKPIT Systems.
Siehe [System Health anzeige](../../monitoring/user-interface/#system-health)

## Wo finde ich welche Logdateien?

### Naemon Log

Die Logdatei der Monitoring Engine Naemon finden Sie unter

```
/opt/openitc/nagios/var/nagios.log
```

Es wird empfohlen die Logdatei mit dem Befehl `oitc debug --tailf` zu betrachten, da hierbei die Unix-Timestamps und UUIDs
ersetzt werden, was die Lesbarkeit der Protokolldatei deutlich erhöht.

### openITCOCKPIT Web Frontend

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

## Aktualisierung der Überwachungskonfiguration hängt fest

Im Falle eines Fehlers im Hintergrund von openITCOCKPIT kann es passieren, dass die Aktualisierung der Überwachungskonfiguration hängen bleibt und sich nicht beendet.
Die Überwachungskonfiguration wird von einem eigenen Hintergrundprozess aktualisiert. Um das Problem zu beheben, folgen Sie bitte den unten beschriebenen Schritten.
Da der Status der Aktualisierung in der openITCOCKPIT Datenbank gespeichert wird, kann das Problem nicht durch einen Neustart des Systems behoben werden.


![Aktualisierung der Überwachungskonfiguration hängt fest](/images/troubleshooting/refresh_monitoring_configuration.png)

1. Stoppen Sie den Hintergrundprozess `gearman_worker`
```plaintext
systemctl stop gearman_worker.service
```

2. Führen Sie nun den Befehl `gearadmin --status` aus, um zu überprüfen, dass keine Aufträge mehr in der Warteschlange `oitc_gearman` warten. Die Ausgabe sollte in etwas so aussehen:
```plaintext
oitc_gearman	0	0	0           # Wartende Aufträge    Aktive Aufträge    Verfügbare Prozesse
```

3. Sofern Sie wartende Aufträge in der Warteschlange haben, führen Sie solange den folgenden Befehl aus, bis alle Aufträge gelöscht wurden.
```plaintext
gearman -w -c 1 -t 1000 -f oitc_gearman > /dev/null
```

4. Leeren Sie nun die Tabelle `exports` in der `openitcockpit` Datenbank, um den Status der Aktualisierung der Überwachungskonfiguration zurückzusetzen.
```
mysql --defaults-extra-file=/opt/openitc/etc/mysql/mysql.cnf -e "TRUNCATE TABLE openitcockpit.exports;"
```

5. Starten Sie nun wieder den `gearman_worker` Dienst.
```plaintext
systemctl start gearman_worker.service
```

### Aktualisierung bleibt immer noch hängen

In seltenen Fällen kann es sein, dass der `gearman_worker` Dienst erneut abstürzt. Dies liegt dann wahrscheinlich an einem Fehler im Programmcode selbst.
Um eventuelle Fehlermeldungen auszugeben, folgen Sie zunächst den Schritten 1 bis 4 wie oben beschrieben.

Starten Sie nun den Dienst `gearman_worker` im Vordergrund. Führen Sie anschließend eine Aktualisierung der Überwachungskonfiguration über die openITCOCKPIT Weboberfläche durch und prüfen Sie das Terminal
auf eventuelle Fehler und Ausgaben.

```
export OITC_DEBUG=1

oitc gearman_worker
```

![gearman_worker running in foreground mode to print out error message](/images/troubleshooting/gearman_worker_foreground_mode.JPG)


## Empfohlene Pakete

openITCOCKPIT installiert einige optionale **aber dennoch wichtige** Pakete anhand weicher Abhängigkeiten. Ein gutes Beispiel dafür ist der MySQL-Server.
Um zu funktionieren benötigt openITCOCKPIT zwar einen MySQL-Sever, dieser kann aber auch auf einem zweiten System installiert sein. Ein zentraler Datenbank Server zum Beispiel.
Aus diesem Grund empfiehlt openITCOCKPIT nur die Installation des Paketes `mysql-server`, anstelle eine harte Abhängigkeiten auf das Paket zu haben.

![apt zeigt empfohlene Pakete](/images/troubleshooting/apt_recommended.jpg)

Ein weiteres Beispiel ist das `Grafana Module`. Grafana ist für den Betrieb von openITCOCKPIT nicht erforderlich, jedoch ist es für den Benutzer schön, Grafana zu haben.
Also empfiehlt hier openITCOCKPIT wieder die Installation des Modules, hat jedoch keine  harte Abhängigkeiten auf Grafana.

In der Standardkonfiguration installiert der Paketmanager `apt` sowohl unter Ubuntu als auch Debian empfohlene (recommended) Pakete automatisch. _Manche Cloud Anbieter_ haben jedoch `apt`
so konfiguriert, dass **keine empfohlene Pakete** installiert werden sollen.

Um zu überprüfen ob eine solche Konfiguration vorliegt, kann dieser Befehl benutzt werden:
```
grep -ri 'Install-Recommends\|Install-Suggests' /etc/apt
```

Das Beispiel zeigt eine apt Konfiguration, welche die Installation von empfohlenen Paketen verhindert:
```
root@ubuntu-4gb-hel1-1:~# grep -ri 'Install-Recommends\|Install-Suggests' /etc/apt
/etc/apt/apt.conf.d/01norecommends:APT::Install-Recommends "0";
/etc/apt/apt.conf.d/01norecommends:APT::Install-Suggests "0";
```

### RHEL basierende Systeme

Auf RHEL basierenden Systemen nutzen wir die gleiche Tehnik, hier werden empfohlene Pakete als `Weak Dependencies` bezeichnet.

![weak dependencies on RHEL](/images/troubleshooting/RHEL_weak_dependencies.jpg)

### Unsupported distribution or /etc/mysql/debian.cnf is missing!

Wenn Sie diese Fehlermeldung bei der Ausführung von `/opt/openitc/frontend/SETUP.sh` bekommen, haben Sie sehr wahrscheinlich openITCOCKPIT ohne das empfohlene `mysql-server` Pakete installiert.
Unter Ubuntu kann das Problem durch `apt-get install mysql-server` und unter Debian mit `apt-get install mariadb-server` behoben werden.

Führen Sie im Anschluss wieder die `SETUP.sh` aus.

![mysql server ist nicht installiert](/images/troubleshooting/unsupported_distribution.jpg)

### /opt/openitc/nagios/libexec: No such file or directory

In diesem Fall haben Sie die standard Monitoring Plugins nicht installiert. Diese können einfach über `apt-get install openitcockpit-monitoring-plugins` nachinstalliert werden.

### Es werden keine Checks ausgeführt

Falls Sie die Meldung `(service check orphaned, is the mod-gearman worker on queue 'service' running?)` als Prüfausgabe erhalten, stellen Sie bitte sicher das der Mod-Gearman Worker
installiert und gestartet ist.

Um sicherzustellen das der Mod-Gearman Worker auf Ihrem openITCOCKPIT Server installiert ist, führen Sie `apt-get install openitcockpit-mod-gearman-worker-go-local` aus.

Sollte dies das Problem nicht beheben, schauen Sie sich bitte den [Mod-Gearman Abschnitt](/additional/mod-gearman/) an.

### Grafana fehlt

Sollte Ihre openITCOCKPIT Oberfläche kein `Grafana` enthalten, kann dies mit `apt-get install openitcockpit-module-grafana` nachinstalliert werden.

## Paketmanager leer

!!! info
    Dies betrifft nur die openITCOCKPIT Versionen **3.x** und **4.x**, welche End of Life sind.
    Für openITCOCKPIT 5 ist dies **nicht** erforderlich.

openITCOCKPIT verfügt über einen eigenen Paketmanager, welcher die Installation von openITCOCKPIT Modulen erleichtert.
Die Liste der verfügbaren Module wird von einem Server abgerufen. Die Adresse des Servers wurde im Jahr 2025 geändert,
von
```
packagemanager.it-novum.com
```

zu
```
packagemanager.openitcockpit.io
```

Da die openITCOCKPIT Versionen 3.x und 4.x nicht mehr gewartet werden, muss die Adresse des Servers manuell geändert werden.

### openITCOCKPIT 3.x

Öffnen Sie die Datei `/usr/share/openitcockpit/app/Console/Command/Task/SystemMetricsTask.php` und ersetzten Sie in Zeile 90 `packagemanager.it-novum.com`
durch `packagemanager.openitcockpit.io`.

GitHub: [https://github.com/openITCOCKPIT/openITCOCKPIT/blob/779a60216416ac8bb5c4cb73f82f3515ac65ed46/app/Console/Command/Task/SystemMetricsTask.php#L90](https://github.com/openITCOCKPIT/openITCOCKPIT/blob/779a60216416ac8bb5c4cb73f82f3515ac65ed46/app/Console/Command/Task/SystemMetricsTask.php#L90)

Offnen Sie die Datei `/usr/share/openitcockpit/app/src/itnovum/openITCOCKPIT/Core/PackagemanagerRequestBuilder.php` und ersetzten Sie in Zeile 45 `packagemanager.it-novum.com` durch `packagemanager.openitcockpit.io`.

GitHub: [https://github.com/openITCOCKPIT/openITCOCKPIT/blob/779a60216416ac8bb5c4cb73f82f3515ac65ed46/app/src/itnovum/openITCOCKPIT/Core/PackagemanagerRequestBuilder.php#L45](https://github.com/openITCOCKPIT/openITCOCKPIT/blob/779a60216416ac8bb5c4cb73f82f3515ac65ed46/app/src/itnovum/openITCOCKPIT/Core/PackagemanagerRequestBuilder.php#L45)

Ab jetzt sollte der Paketmanager wieder funktionieren.

### openITCOCKPIT 4.x

Öffnen Sie die Datei `/opt/openitc/frontend/src/Command/SystemMetricsCommand.php` und ersetzten Sie in Zeile 111 `packagemanager.it-novum.com`
durch `packagemanager.openitcockpit.io`.

GitHub: [https://github.com/openITCOCKPIT/openITCOCKPIT/blob/e24ff4327edd98bf8dfcf12c404ecbb24f4eb758/src/Command/SystemMetricsCommand.php#L111](https://github.com/openITCOCKPIT/openITCOCKPIT/blob/e24ff4327edd98bf8dfcf12c404ecbb24f4eb758/src/Command/SystemMetricsCommand.php#L111)

Offnen Sie die Datei `/opt/openitc/frontend/src/itnovum/openITCOCKPIT/Core/PackagemanagerRequestBuilder.php` und ersetzten Sie in den Zeilen 32 und 45 `packagemanager.it-novum.com` durch `packagemanager.openitcockpit.io`.

GitHub: [https://github.com/openITCOCKPIT/openITCOCKPIT/blob/e24ff4327edd98bf8dfcf12c404ecbb24f4eb758/src/itnovum/openITCOCKPIT/Core/PackagemanagerRequestBuilder.php#L32-L45](https://github.com/openITCOCKPIT/openITCOCKPIT/blob/e24ff4327edd98bf8dfcf12c404ecbb24f4eb758/src/itnovum/openITCOCKPIT/Core/PackagemanagerRequestBuilder.php#L32-L45)

Ab jetzt sollte der Paketmanager wieder funktionieren.

