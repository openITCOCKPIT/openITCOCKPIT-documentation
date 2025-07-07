# Graphing Backend

## Docker Container

Das Graphing Backend von openITCOCKPIT läuft auf verschiedenen Docker Containern. Wir nutzen [Docker Compose](https://docs.docker.com/compose/)
um die Container zu verwalten. Alle Container können mittels `systemd` kontrolliert werden.

Graphing Backend starten:
```bash
systemctl start openitcockpit-graphing.service
```

Graphing Backend stoppen:
```bash
systemctl stop openitcockpit-graphing.service
```

Graphing Backend Status:
```bash
systemctl status openitcockpit-graphing.service
```


![systemd status](/images/systemd-graphing-backend-status.png)


Sie können den Status der Container auch durch das Docker CLI abfragen

Graphing Backend Status:
```bash
docker container ps
```

![docker status](/images/docker-status.png)


### Logdatei

```bash
cd /opt/openitc/docker/container/graphing
docker-compose logs -f
```

### docker-compose.yml Datei

Die Datei `docker-compose.yml` ist in folgendem Ordner zu finden:

```bash
/opt/openitc/docker/container/graphing/docker-compose.yml
```

!!! danger
    Editieren Sie die docker-compose Datei nicht von Hand, da diese von openITCOCKPIT automatisch generiert wird!

### Carbon-C-Relay

Das Carbon-C-Relay ist ein Load-Balancer für mehrere Carbon-Cache-Instanzen.

Der Standard `LINE_RECEIVER_PORT` (Plaintext Protokoll basierend auf TCP) ist `2003` und wird auf `127.0.0.1:2003` 
geöffnet.

Sie können den Port über die openITCOCKPIT Weboberfläche ändern.

Die Konfigurationsdatei wird automatisch unter `/opt/openitc/etc/carbon/carbon-c-relay.conf` generiert.


### Carbon-Cache Instanzen

Die Carbon-Cache-Instanzen schreiben und lesen daten aus den Whisper Dateien.

Der Standard Whisper Pfad auf dem openITCOCKPIT server ist `/var/lib/graphite/whisper`. 

Die Konfigurationsdatei wird automatisch unter `/opt/openitc/etc/carbon/carbon.conf` generiert.


### Graphite-Web

Bietet eine HTTP-JSON-API für den einfachen zugriff, auf die in den Whisper Dateien gespeicherten Daten.

Graphite-Web sendet seine anfragen an die [Carbon-Cache Instanzen](#carbon-cache-instanzen).

Die Konfigurationsdatei wird automatisch unter `/opt/openitc/etc/carbon/local_settings.py` generiert.

### Grafana

[Grafana](../../monitoring/graphing/#grafana) ist ein mächtiges und einfach zu benutzendes Tool um Graphen Dashboards zu
erstellen. Es wird von openITCOCKPIT im Hintergrund durch die API genutzt.

Die Grafana Weboberfläche kann durch die URL `https://<openITCOCKPIT-adresse>/grafana/` erreicht werden.

Die Konfigurationsdatei wird automatisch unter `/opt/openitc/etc/grafana/grafana.ini` generiert.

Der Benutzername für die Grafana Weboberfläche ist `admin`.

Ein Zufalls-generiertes Passwort wird während des Installationsprozesses erstellt. Es wird unter 
`/opt/openitc/etc/grafana/admin_password` gespeichert.

Der API-Key, der von openITCOCKPIT genutzt wird ist in der Datei `/opt/openitc/etc/grafana/api_key` gespeichert.

## Speicherort der Whisper Dateien

Standardmäßig werden alle Whisper Dateien unter dem Ordner `/var/lib/graphite/whisper` abgelegt. 

Das Speicherschema ist `/var/lib/graphite/whisper/<prefix>/<$HOSTNAME$>/<$SERVICEDESC$>/<$METRIC$>.wsp`.

![whisper file location](/images/whisper-location.png)

Sie können das openITCOCKPIT Debugging Tool nutzen, um die UUIDs durch Host und Servicenamen zu ersetzen.

```bash 
ls -la /var/lib/graphite/whisper/openitcockpit/ | oitc debug -s
```

![whisper files translated](/images/whisper-location-with-translated-hostnames.png)

## Konfigurationsänderungen

Falls nötig, können Sie die Konfiguration des Graphing Backend über die openITCOCKPIT Weboberfläche anpassen.

Navigieren Sie dazu nach `Systemkonfiguration -> System -> Konfigurationsdatei Editor` und wählen Sie die Datei 
`docker-compose.yml` des Graphing Backend aus.

![graphing backend configfile editor](/images/configfileeditor-graphing-backend.png)

Im nächsten Schritt können Sie alle wichtigen einstellungen, wie zum Beispiel den Speicherpfad oder die Anzahl der 
Carbon-Cache Instanzen anpassen. 

![graphing backend configfile editor edit](/images/configfileeditor-graphing-backend-edit.png)

## Überblick

![graphing backend overview](/images/graphing-backend.png)

## Mitgelieferten Graphite und Grafana Server nutzen (Standard und empfohlen)

openITCOCKPIT wird mit mehreren Docker Containern ausgeliefert.

Standardmäßig nutzt openITCOCKPIT den mitgelieferten Docker Container um Performance-daten zu Speichern.

In dieser Sektion der Dokumentation werden die Standardwerte für diese Konfiguration beschrieben.

### Performance-daten in mitgeliefertem Graphite speichern

Navigieren Sie dazu nach `Systemkonfiguration -> System -> Konfigurationsdatei Editor` und wählen Sie die Datei
`statusengine.php` aus.

![statusengine configfileeditor](/images/configfileeditor-statusengine.png)

|Konfigurationsschlüssel|Standardwert|Beschreibung|
|---|---|---|
|graphite_port|2003|Carbon-Cache Server Adresse (Offener `LINE_RECEIVER_PORT` des Carbon-C-Relay)|
|graphite_address|127.0.0.1|Carbon-Cache Server Adresse (Offene Adresse des Carbon-C-Relay)|
|graphite_prefix|openitcockpit|Präfix, welches zu jeder Metrik in Carbon angehängt wird (Metric: <prefix>.<$HOSTNAME$>.<$SERVICEDESC$>.<$METRIC$>)|

### Performance-daten in mitgeliefertem Graphite lesen

Navigieren Sie dazu nach `Systemkonfiguration -> System -> Konfigurationsdatei Editor` und wählen Sie die Datei
`statusengine.php` aus.

![graphite configfileeditor](/images/configfileeditor-graphite.png)

|Konfigurationsschlüssel|Standardwert|Beschreibung|
|---|---|---|
|graphite_web_host|127.0.0.1|Adresse des Graphite-Web server, welche openITCOCKPIT nutzt um daten der Whisper Dateien abzufragen|
|graphite_prefix|openitcockpit|Prefix, welches zu jeder Metrik in Carbon angehängt wird (Metric: <prefix>.<$HOSTNAME$>.<$SERVICEDESC$>.<$METRIC$>)|
|graphite_web_port|8888|Port des Graphite-Web Server|
|use_https|No|Bestimmt ob HTTPS zur Verbindungserstellung genutzt werden soll. Nicht benötigt bei lokal laufenden Graphite-Web Instanzen|
|use_proxy|No|Bestimmt ob der [Proxy Server](../../configuration/proxy/) genutzt werden soll. Nicht benötigt bei lokal laufenden Graphite-Web Instanzen|

Im nächsten Schritt öffnen Sie die `perfdatabackend.php` Konfigurationsdatei und stellen sicher, dass das ausgewählte
Backend `Whisper` ist.
![perfdatabackend configfileeditor](/images/configfileeditor-perfdatabackend.png)

![perfdatabackend whisper configfileeditor](/images/configfileeditor-perfdatabackend-whisper.png)

### Konfiguration um ausgeliefertes Grafana mit ausgeliefertem Graphite zu nutzen

Navigieren Sie nach `Systemkonfiguration -> APIs -> Grafana`

Konfigurationsschlüssel|Standardwert|Beschreibung|
|---|---|---|
|Grafana URL|grafana.docker|Adresse des Grafana Servers. `grafana.docker` wird automatisch zum ausgelieferten Grafana aufgelöst. |
|Grafana API Schlüssel|Zufalls-generiert|Gespeichert unter `/opt/openitc/etc/grafana/api_key`. Nutzen Sie den Wert aus dieser Datei.|
|Grafana Prefix|openitcockpit|Präfix, welches zu jeder Metrik in Carbon angehängt wird (Metric: <prefix>.<$HOSTNAME$>.<$SERVICEDESC$>.<$METRIC$>).|
|Verbindung über HTTPS herstellen|Ja|Bestimmt ob HTTPS zu Verbindungsherstellung genutzt werden soll.|
|Benutze Proxy|Nein|Bestimmt ob der [Proxy Server](../../configuration/proxy/) genutzt werden soll.|
|SSL-Zertifikat ignorieren|Ja|Selbstsignierten Zertifikaten wird vertraut|
|Dashboard Stil|hell|Hell oder Dunkler Stil von Grafana nutzen|
|Hostgruppe|*leer*|Ist dieser Wert gesetzt, werden Grafana-Dashboards für alle Hosts der angegebenen Hostgruppe(n) generiert (Wenn leer wird für alle Hosts ein Dashboard generiert)|
|Hostgruppen (ausgeschlossen)|*leer*|Wenn gesetzt werden **keine** Grafana-Dashboards für die Hosts in den angegebenen Hostgruppen erstellt|

## Externen Graphite und Grafana Server nutzen (Experten)

Um die Systemauslastung auf verschiedene Nodes zu verteilen, haben Sie die Möglichkeit, externe Systeme zum Speichern von Performancedaten zu konfigurieren.

### Performance-daten in externem Graphite speichern
Navigieren Sie dazu nach `Systemkonfiguration -> System -> Konfigurationsdatei Editor` und wählen Sie die Datei
`statusengine.php` aus.

![statusengine configfileeditor](/images/configfileeditor-statusengine.png)

|Konfigurationsschlüssel|Wert|Beschreibung|
|---|---|---|
|graphite_port|2003|Standard `LINE_RECEIVER_PORT` von Graphite)|
|graphite_address|xxx.xxx.xxx.xxx|Hostname oder IP-Adresse des Externen Graphite Server|
|graphite_prefix|openitcockpit|Präfix, welches zu jeder Metrik in Carbon angehängt wird (Metric: <prefix>.<$HOSTNAME$>.<$SERVICEDESC$>.<$METRIC$>)|

### Performance-daten von extern lesen (openITCOCKPIT selbst)

Navigieren Sie dazu nach `Systemkonfiguration -> System -> Konfigurationsdatei Editor` und wählen Sie die Datei
`statusengine.php` aus.

![graphite configfileeditor](/images/configfileeditor-graphite.png)

|Konfigurationsschlüssel|Wert|Beschreibung|
|---|---|---|
|graphite_web_host|xxx.xxx.xxx.xxx|Hostname oder IP-Adresse des Externen Graphite-Web Server|
|graphite_prefix|openitcockpit|Prefix, welches zu jeder Metrik in Carbon angehängt wird (Metric: <prefix>.<$HOSTNAME$>.<$SERVICEDESC$>.<$METRIC$>)|
|graphite_web_port|80|Port des Externen Graphite-Web Server|
|use_https|Yes/No|Bestimmt, ob HTTPS zur Verbindungserstellung genutzt werden soll.|
|use_proxy|Yes/No|Bestimmt, ob der [Proxy Server](../../configuration/proxy/) genutzt werden soll.|

Im nächsten Schritt öffnen Sie die `perfdatabackend.php` Konfigurationsdatei und stellen sicher, dass das ausgewählte
Backend `Whisper` ist.
![perfdatabackend configfileeditor](/images/configfileeditor-perfdatabackend.png)

![perfdatabackend whisper configfileeditor](/images/configfileeditor-perfdatabackend-whisper.png)

### Konfiguration um externes Grafana mit externem Graphite zu nutzen

Navigieren Sie nach `Systemkonfiguration -> APIs -> Grafana`

Konfigurationsschlüssel|Wert|Beschreibung|
|---|---|---|
|Grafana URL|xxx.xxx.xxx.xxx| Adresse des externen Grafana Server |
|Grafana API Schlüssel|Zufalls-generiert|Es muss ein [Grafana API Schlüssel](#grafana-api-schlussel-erzeugen) mit "Editor" Berechtigungen erzeugt werden|
|Grafana Prefix|openitcockpit|Präfix, welches zu jeder Metrik in Carbon angehängt wird (Metric: <prefix>.<$HOSTNAME$>.<$SERVICEDESC$>.<$METRIC$>).|
|Verbindung über HTTPS herstellen|Ja/Nein|Bestimmt, ob HTTPS zu Verbindungsherstellung genutzt werden soll.|
|Benutze Proxy|Ja/Nein|Bestimmt, ob der [Proxy Server](../../configuration/proxy/) genutzt werden soll.|
|SSL-Zertifikat ignorieren|Ja/Nein|Selbst signierten Zertifikaten wird vertraut|
|Dashboard Stil|hell|Hell oder Dunkler Stil von Grafana nutzen|
|Hostgruppe|*leer*|Ist dieser Wert gesetzt, werden Grafana-Dashboards für alle Hosts der angegebenen Hostgruppe(n) generiert (Wenn leer wird für alle Hosts ein Dashboard generiert)|
|Hostgruppen (ausgeschlossen)|*leer*|Wenn gesetzt, werden **keine** Grafana-Dashboards für die Hosts in den angegebenen Hostgruppen erstellt|

#### Grafana API Schlüssel erzeugen
![new grafana api key](/images/Create-new-Grafana-API-Key.png)

![new grafana api key edit](/images/New-created-Grafana-API-Key.png)

## Migration von RRDTool zu Whisper

Seit openITCOCKPIT 3.6 werden Performance-daten (für Grafen genutzt) in [Whisper](https://graphite.readthedocs.io/en/latest/whisper.html) (Carbon) gespeichert.


!!! info
    Es gibt keine automatische Migration, wenn Sie von einer älteren Version von openITCOCKPIT auf version 3.6 oder neuer
    aktualisieren. Aus diesem Grund werden leere Grafen angezeigt, bis neue daten gesammelt wurden. 

Um die Migration von RRDTool zu Whisper so einfach wie möglich zu halten, bieten wir ein eigenes Tool an: [rrd2whisper](https://github.com/openITCOCKPIT/rrd2whisper)


### Download und Installation von rrd2whisper

Wir bieten eigene Pakete von rrd2whisper für jede unterstützte Distribution auf der [offiziellen Download Seite](https://github.com/openITCOCKPIT/rrd2whisper/releases).

!!! info "Internetverbindung wird benötigt"
    Um rrd2whisper zu installieren, wird eine funktionierende Internetverbindung benötigt. Sollten Sie eine HTTP-Proxy 
    verbindung benötigen, [Konfigurieren Sie diese zuerst](https://wiki.ubuntuusers.de/Proxyserver/#Alternatives-Verfahren)

```bash
sudo wget -O /usr/local/bin/rrd2whisper https://github.com/openITCOCKPIT/rrd2whisper/releases/download/v2.0.1/rrd2whisper_v2.0.1_$(lsb_release -sc)_amd64
sudo chmod +x /usr/local/bin/rrd2whisper
sudo apt-get install rrdtool
```

rrd2whisper ist nun unter dem folgenden Pfad installiert: `/opt/rrd2whisper`.


### Migration starten

Der Migrationsprozess wird alle `.rrd` Dateien aus `/opt/openitc/nagios/share/perfdata` lesen und als `.wsp` Dateien unter
`var/lib/graphite/whisper` Speichern.


!!! warning
    Stellen Sie sicher, dass Sie genügend freien Festplattenspeicher bereitstellen können, bevor Sie die Migration starten
    Whisper benötigt zirka die hälfte des Speicherplatzes, den RRDTool benötigt.

#### Migration testen

Bevor Sie mit der Migration aller Dateien starten, sollten Sie einen Test mit einer einzelnen `.rrd` Datei durchführen.

```bash
sudo /usr/local/bin/rrd2whisper -limit 1
```

Mit dem Parameter `--limit 1` wird nur eine einzelne Datei verarbeitet. Sie sollten eine ähnliche ausgabe wie diese sehen:

![convert test](/images/converttest.JPG)

In diesem Beispiel wurde der Service mit der UUID `b123beaf-0575-4ec4-b353-328df2fba0e3` migriert. Im nächsten Schritt 
öffnen Sie die openITCOCKPIT Weboberfläche und suchen nach dieser UUID. Stellen Sie sicher, dass der Graph die migrierten
Performance-daten beinhaltet.

#### Migration durchführen

Nach dem erfolgreichen Test kann die Migration aller Performance-daten erfolgen.

!!! info
    Abhängig von der Menge der Performance-daten, die migriert werden müssen, kann die Migration mehrere Stunden in 
    anspruch nehmen. Der Migrationsprozess beeinflusst ihr Monitoring **nicht**. Neue Performance-daten werden 
    zusammengeführt.

Migration mit Standardparametern:
```bash
sudo /usr/local/bin/rrd2whisper
```
Die Ausgabe der Migration wird nach `/var/log/rrd2whisper.log` geloggt.


Nutzen Sie den Parameter `--help`, um alle Optionen sehen zu können.
```bash
sudo /usr/local/bin/rrd2whisper -help
```

### Fehlerfall 

Für den Fall, dass die Migration fehlgeschlagen oder andere unerwartete Fehler erscheinen, können Sie die Migration erneut
starten. Jede erfolgreich verarbeitete `.rrd` Datei wird mit `.ok` markiert, somit werden keine einträge doppelt migriert.

```bash
[16:02]root@graphing/tmp# ls /opt/openitc/nagios/share/perfdata/abfb63a8-5187-46bf-a6f1-5120fcac66b6/*
/opt/openitc/nagios/share/perfdata/abfb63a8-5187-46bf-a6f1-5120fcac66b6/279b7b4a-4812-4bc5-a251-cec81e11a705.ok
/opt/openitc/nagios/share/perfdata/abfb63a8-5187-46bf-a6f1-5120fcac66b6/279b7b4a-4812-4bc5-a251-cec81e11a705.rrd
/opt/openitc/nagios/share/perfdata/abfb63a8-5187-46bf-a6f1-5120fcac66b6/279b7b4a-4812-4bc5-a251-cec81e11a705.xml
/opt/openitc/nagios/share/perfdata/abfb63a8-5187-46bf-a6f1-5120fcac66b6/27e67fe9-16fd-4ce2-90d1-442e1e7a1164.ok
/opt/openitc/nagios/share/perfdata/abfb63a8-5187-46bf-a6f1-5120fcac66b6/27e67fe9-16fd-4ce2-90d1-442e1e7a1164.rrd
/opt/openitc/nagios/share/perfdata/abfb63a8-5187-46bf-a6f1-5120fcac66b6/27e67fe9-16fd-4ce2-90d1-442e1e7a1164.xml
/opt/openitc/nagios/share/perfdata/abfb63a8-5187-46bf-a6f1-5120fcac66b6/30a267ae-05a4-432a-9066-15d14eb6a6e8.ok
/opt/openitc/nagios/share/perfdata/abfb63a8-5187-46bf-a6f1-5120fcac66b6/30a267ae-05a4-432a-9066-15d14eb6a6e8.rrd
/opt/openitc/nagios/share/perfdata/abfb63a8-5187-46bf-a6f1-5120fcac66b6/30a267ae-05a4-432a-9066-15d14eb6a6e8.xm
```
