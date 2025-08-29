# Docker images

Die offiziellen Docker-Images von openITCOCKPIT stehen hier zur Verfügung:

 - [Docker Hub](https://hub.docker.com/r/openitcockpit/openitcockpit-ce)

Die Docker-Images von openITCOCKPIT stehen für die `amd64` und `arm64` CPU Architekturen zur Verfügung und können somit auch auf einem SoC wie dem Raspberry Pi 4 genutzt werden.

## Voraussetzungen

Docker und Docker Compose sind erforderlich. Bitte folgen Sie der [offiziellen Dokumentation](https://docs.docker.com/get-docker/),
sollten Sie noch kein Docker installiert haben.

### System requirements
- 2 CPU Kerne (x86-64 oder arm64)
- 4 GB RAM
- 60 GB freier Festplattenspeicher

!!! info
    Der verwendete Festplattenspeicher hängt von der Anzahl der überwachten Hosts und Services ab.

## Einstellungen
Die Konfiguration von openITCOCKPIT kann über die Datei `openitcockpit.env` angepasst werden. Es wird empfohlen,
**vor dem ersten start der Container** die Anmeldedaten zu ändern:

```sh
OITC_ADMIN_EMAIL=user@example.org
OITC_ADMIN_PASSWORD=asdf12
OITC_ADMIN_FIRSTNAME=John
OITC_ADMIN_LASTNAME=Doe
```

Alternativ können Sie auch einen neuen [Benutzer erstellen](https://docs.openitcockpit.io/en/configuration/usermanagement/) oder das Passwort ändern.

Außerdem wird empfohlen, dass Password des Grafana-Admin-Benutzers zu ersetzten. Setzten Sie dafür die folgenden zwei Variablen auf den gleichen Wert:
```sh
OITC_GRAFANA_ADMIN_PASSWORD=bGsPMxURCjg4esgJ

GF_SECURITY_ADMIN_PASSWORD=bGsPMxURCjg4esgJ
```

Zur Generierung eines sicheren Passworts kann der Befehl `pwgen -s -1 16` genutzt werden.

Wie üblich bei Docker-Containern, können weitere Einstellungen wie Ports oder Volumes im `compose.yml` bei Bedarf angepasst werden.

## Standardwerte

Standardmäßig stellt openITCOCKPIT diese Ports zur Verfügung:

 - 80 (HTTP)
 - 443 (HTTPS)

Die Standardanmeldeinformationen sind:

 - E-Mail `user@example.org`
 - Password: `asdf12`

## Vorbereitungen

1. Am einfachsten ist es, wenn Sie zuerst mit `git` eine lokale Kopie des Repositories erstellen, welches alle benötigten Daten enthält.
```
git clone https://github.com/openITCOCKPIT/openITCOCKPIT-ce-docker.git
```

2. Wechseln Sie nun in den Ordner
```
cd openITCOCKPIT-ce-docker
```

3. Bearbeiten Sie die Datei `openitcockpit.env` und passen Sie Benutzername und Passwort an.

## Container starten

Das Starten der Container erfolgt mit Hilfe des Befehls

```
docker compose up -d
```


## Container aktualisieren

Um die Container von openITCOCKPIT zu aktualisieren, folgen Sie bitte diesen Schritten:

1. Aktualisieren Sie die lokale Kopie Ihres Repositories:
```bash
git pull origin main
```

2. Stoppen Sie die laufenden Container
```bash
docker compose down
```

3. Führen Sie das Docker Compose Kommando aus, um die Container zu aktualisieren und starten:
```bash
docker compose up --pull always -d
```

## Tags

Die Docker-Registry von openITCOCKPIT beinhaltet für alle Container die folgende Tags:

- `latest` - Die letzte stabile Version von openITCOCKPIT (empfohlen)
- Eine Version wie z.B. `4.6.4` - Diese Tags beinhalten die angegebene Version von openITCOCKPIT und können genutzt werden, um eine spezifische stabile Version zu erhalten.

- `nightly` - Ein **ungetesteter** Build von openITCOCKPIT, welcher automatisiert erstellt und veröffentlicht wurde. Kann zum Testen von neuen Versionen und Feature genutzt werden. **Nicht für den produktiven Einsatz gedacht!**

## TLS-Zertifikate einrichten
Standardmäßig erstellt und verwendet openITCOCKPIT ein selbstsigniertes Zertifikat. Es ist jedoch auch möglich, eigene Zertifikate wie zum Beispiel von Let’s Encrypt zu verwenden.

Zuerst müssen Sie den Pfad zu den Zertifikatsdateien in der Datei `openitcockpit.env` anpassen:
```
OITC_NGINX_SSL_CERTIFICATE=/tmp/Lets_Encrypt/cert.crt
OITC_NGINX_SSL_CERTIFICATE_KEY=/tmp/Lets_Encrypt/private.key
```

Im nächsten Schritt müssen Sie die Zertifikatsdateien in den Container einbinden. Dies geschieht, indem Sie in der `compose.yml` einen Bind-Mount für den `openitcockpit`-Container erstellen.

Kurzes Beispiel
```yml
    volumes:
      - /host/ssl/Lets_Encrypt:/tmp/Lets_Encrypt:ro                           # Pfad zu den Zertifikatsdateien
```

Komplettes Beispiel
```yml
  openitcockpit:
    image: openitcockpit/openitcockpit-ce:latest                              # Community Edition of openITCOCKPIT
    init: true
    env_file:
     - openitcockpit.env
    ports:
      - "80:80"       # HTTP
      - "443:443"     # HTTPS
    networks:
      - oitc-backend
    volumes:
      - naemon-config:/opt/openitc/nagios/etc/config                          # Configuration files related to Naemon
      - naemon-var:/opt/openitc/nagios/var                                    # The status.dat is required for the recurring downtimes cronjob
      - oitc-frontend-src:/opt/openitc/src_sharing/frontend                   # Frontend of openITCOCKPIT to be shared with mod_gearman container so that the container can execute the EVC plugin
      - oitc-webroot:/opt/openitc/frontend/webroot                            # Webroot of openITCOCKPIT to keep images and share files with puppeteer
      - oitc-maps:/opt/openitc/frontend/plugins/MapModule/webroot/img         # Images of the MapModule
      - oitc-agent-cert:/opt/openitc/agent                                    # TLS certificats of the openITCOCKPIT Monitoring Agent
      - oitc-agent-etc:/opt/openitc/receiver/etc                              # Configuration for the openITCOCKPIT Monitoring Agent Check Reciver
      - oitc-var:/opt/openitc/var                                             # A safe harbor to store .lock files
      - oitc-backups:/opt/openitc/nagios/backup                               # Automaticaly generated MySQL dumps
      #- oitc-import:/opt/openitc/frontend/plugins/ImportModule/webroot/files # Uplaoded files of the ImportModule
      - oitc-styles:/opt/openitc/frontend/plugins/DesignModule/webroot/css    # Custom styles of the DesignModule
      - checkmk-agents:/opt/openitc/check_mk/agents:ro
      - checkmk-etc:/opt/openitc/check_mk/etc/check_mk
      - checkmk-var:/opt/openitc/check_mk/var/check_mk
      - /host/ssl/Lets_Encrypt:/tmp/Lets_Encrypt:ro                           # Pfad zu den Zertifikatsdateien
```

## Fehlersuche

### Befehle in einem Container ausführen

1.  Führen Sie den Befehl `docker ps` aus, um die ID des gewünschten Containers auszulesen.
2. Im nächsten Schritt können Sie über den Befehl  `docker exec` in den Container _springen_
```
docker exec -it d92a1431e619 bash
```

### Eine MySQL Konsole starten

1. Gehen Sie zuerst mit dem Befehl `docker exec` in den `openitcockpit-ce` Container.
2. Führen Sie den Befehl `mysql --defaults-file=/opt/openitc/etc/mysql/mysql.cnf` aus um eine MySQL Shell zu erhalten.

### Query Gearman status
1. Gehen Sie zuerst mit dem Befehl `docker exec` in den `openitcockpit-ce` Container.
2. Führen Sie den Befehl `gearadmin --status -h gearmand` aus um eine Gearman Status Ausgabe zu erhalten.

Sollten Sie den Hostnamen des Gearman-Job-Servers angepasst haben, können Sie den Wert direkt aus der Umgebungsvariable auslesen: `gearadmin --status -h $OITC_GEARMAN_ADDRESS`

### Neustarten von Diensten
In der Regel müssen Sie keine Dienste manuell neustarten. Über den `openitcockpit-ce` Container ist es jedoch möglich, bestimmte Dienste in anderen Containern neu zu starten.
Dafür kann der Befehl `oitc supervisor --help` genutzt werden.

Beispiele:
```
oitc supervisor status naemon
oitc supervisor restart nginx
oitc supervisor stop nginx
oitc supervisor start nginx
```

## Eigene Monitoring-Plugins installieren

openITCOCKPIT unterstützt zwei verschiedene Methoden, um die Überwachung durch benutzerdefinierten Check-Plugins zu erweitern. Die _containerisierte Methode_ wird für Benutzer empfohlen, die Erfahrung mit dem Erstellen und Verwalten von Container-Images haben.

Wenn Sie jedoch lieber einen Bare-Metal-Server oder eine virtuelle Maschine verwenden möchten, schauen Sie sich die _traditionelle Methode_ an.

### Containerisierte Methode

Der Container `openitcockpit/mod_gearman_worker` ist verantwortlich für das Ausführen von Monitoring-Plugins. Dieser Container basiert immer auf
der aktuellen LTS Version von Ubuntu und kann als Basisimage für neue Container genutzt werden.

Dafür müssen Sie zuerst ein eigenes `Dockerfile` erstellen, welche alle gewünschten Plugins installieren. In diesem Beispiel, wird der Container um das Plugin
[check_ssl_cert](https://github.com/matteocorti/check_ssl_cert) erweitert.

```Dockerfile
FROM openitcockpit/mod_gearman_worker:latest

USER root

# Install plugin dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y perl wget curl bind9-host bc openssl nmap

# Install the plugin
RUN wget https://github.com/matteocorti/check_ssl_cert/releases/download/v2.69.0/check_ssl_cert-2.69.0.tar.gz &&\
    tar xfv check_ssl_cert-2.69.0.tar.gz &&\
    cp check_ssl_cert-2.69.0/check_ssl_cert /opt/openitc/nagios/libexec/check_ssl_cert &&\
    chmod +x /opt/openitc/nagios/libexec/check_ssl_cert

```


Erstellen Sie das neues Docker-Image:
```
docker build --rm -t openitcockpit/custom_mod_gearman_worker:latest .
```

Im letzten Schritt müssen Sie noch Ihr eigenes Docker-Image in der `compose.yml`-Datei eintragen. Suchen Sie dafür den Container `openitcockpit/mod_gearman_worker` und ersetzten
Sie das Image durch Ihr eigenes, zum Beispiel `openitcockpit/custom_mod_gearman_worker:latest`


Nach einem Neustart der Container, wird Ihr eigener angepasster Container genutzt.
```
[Ubuntu][11:49]root@srvcontainerswarm04/tmp/custom_mod_gearman# docker exec -it dffc5ffe8681 bash
root@dffc5ffe8681:/# /opt/openitc/nagios/libexec/check_ssl_cert -H openitcockpit.io
SSL_CERT OK - openitcockpit.io:443, https, x509 certificate 'openitcockpit.io' from 'Let's Encrypt' valid until Aug  6 21:32:16 2023 GMT (expires in 76 days)|days_chain_elem1=76;20;15;; days_chain_elem2=847;20;15;; days_chain_elem3=497;20;15;;
root@dffc5ffe8681:/#
```

### Traditionelle Methode

openITCOCKPIT verwendet `Mod-Gearman`, um die Ausführung von Check-Plugins auf mehrere Server (oder Container) zu verteilen.

Sollten Sie kein Freund von eigenen Container-Image sein, bietet openITCOCKPIT ein Paket an, mit dem Sie jedes Debian, Ubuntu oder Red Hat Enterprise Linux basierende System als Worker verwenden können. Abhängig von der Systemlast kann es sinnvoll sein, die Last auf mehrere Server zu verteilen.

!!! warning
    Aus Sicherheitsgründen empfelen wir dringen die <a href="#verschlusselung-aktivieren">Verschlüsselung zu aktivieren</a>.

#### Vorbereitung der Container
Zuerst müssen Sie die bestehenden Container vorbereiten.

1. Freigeben des Gearmand

    Um einen externen Mod-Gearman Worker mit openITCOCKPIT zu verbinden, müssen Sie den "Gearman-Job-Server" in Ihrem Netzwerk freigeben.
    Zunächst bearbeiten Sie die Datei `compose.yml` und suchen nach dem Dienst "gearmand". Ersetzen Sie die Zeile:
    ```
    - "4730"       # Gearman-Job-Server
    ```
    durch
    ```
    - "4730:4730"       # Gearman-Job-Server
    ```
2. Deaktivieren Sie die Verarbeitung von Host- und Servicechecks durch openITCOCKPIT

    Um sicherzustellen, dass alle Host- und Service-Checks von Ihrem eigenen benutzerdefinierten Worker ausgeführt werden,
    ist es wichtig, die standardmäßige Ausführung der Checks von openITCOCKPIT zu deaktivieren.
    Bearbeiten Sie dazu die Datei `openitcockpit.env` und setzen Sie die folgenden Werte:
    ```cfg
    #####
    ## Naemon Environment Variables
    #####

    MOD_GEARMAN_ENCRYPTION=yes
    MOD_GEARMAN_KEY=should_be_changed

    #####
    ## Mod_Gearman_Worker Environment Variables
    #####
    MOD_GEARMAN_WORKER_EVENTHANDLER=no
    MOD_GEARMAN_WORKER_NOTIFICATIONS=yes
    MOD_GEARMAN_WORKER_SERVICES=no
    MOD_GEARMAN_WORKER_HOSTS=no
    MOD_GEARMAN_WORKER_ENCRYPTION=yes
    MOD_GEARMAN_WORKER_KEY=should_be_changed
    ```
    Um die Änderungen anzuwenden, starten Sie die Container neu.
    Der Container `openitcockpit/mod_gearman_worker` wird weiterhin verwendet, um Benachrichtigungen zu senden.
    Dieses Verhalten kann auch geändert werden, aber dies wird nur für fortgeschrittene Benutzer empfohlen.

#### Vorbereitung der VM
Nun ist es an der Zeit, eine VM (oder einen Server) einzurichten, den Sie für die Ausführung der Checks verwenden möchten.
Wir empfehlen, mit einer leeren VM der neuesten Ubuntu LTS-Version zu beginnen.

1. Laden des Repositories

    Stellen Sie bitte sicher, dass Sie das [openITCOCKPIT-Repository](https://openitcockpit.io/download_server/) auf Ihrem System aktivieren.

2. Installation der Abhängigkeiten
    ```
    apt-get install openitcockpit-mod-gearman-worker-go
    ```
    Alle Check-Plugins sind unter `/opt/openitc/nagios/libexec` abgelegt. Sie können dort (oder an jedem anderen Dateipfad) eigene Check-Plugins hinterlegen.

3. Verbindung zum openITCOCKPIT Server

    Öffnen Sie die Datei `/etc/openitcockpit-mod-gearman/worker.cfg` und tragen sie den Hostnamen oder die IP-Adresse Ihres openITCOCKPIT Servers ein.
    ```cfg
    server=srvpod03.example.org:4730

    # Bedenken Sie auch die Einstellungen für die Verschluesselung
    encryption=yes
    key=should_be_changed
    ```
    Um die Einstellungen zu übernehmen, muss der Dienst neugestartet werden: `systemctl restart mod-gearman-worker.service`

### Verschlüsselung aktivieren
Standardmäßig ist in openITCOCKPIT **keine Verschlüsselung** für Mod-Gearman aktiviert. Dies liegt daran, dass standardmäßig alle Kommunikation nur für die Container in demselben Container-Netzwerk verfügbar ist.
Falls Sie jedoch den Gearman-Port (4730) freigegeben haben oder externe Mod-Gearman-Worker verwenden, empfehlen wir, die Verschlüsselung zu aktivieren.
Mod-Gearman verfügt über ein gemeinsames Geheimnis, daher müssen Sie die Änderungen auf allen betroffenen Systemen vornehmen!

Für **Container** Installationen bearbeiten Sie die Datei `openitcockpit.env` und passen Sie die folgenden Variablen an:
```
#####
## Naemon Environment Variables
#####

MOD_GEARMAN_ENCRYPTION=yes
MOD_GEARMAN_KEY=should_be_changed

#####
## Mod_Gearman_Worker Environment Variables
#####

MOD_GEARMAN_WORKER_ENCRYPTION=yes
MOD_GEARMAN_WORKER_KEY=should_be_changed
```

Für **traditionelle** Installationen bearbeiten Sie die Konfigurationsdatei. `/etc/openitcockpit-mod-gearman/worker.cfg`:
```
encryption=yes
key=should_be_changed
```
Die `key`-Option enthält das gemeinsame Geheimnis und sollte durch eine sichere Zeichenkette ersetzt werden.
Um die Änderungen zu übernehmen, starten Sie alle Container neu, oder den `mod-gearman-worker.service`.

## Portainer

[Portainer Community Edition](https://github.com/portainer/portainer) ist eine Weboberfläche, mit dessen Hilfe sich Docker-Container bequem und einfach verwalten lassen.

Über _Stacks_ ermöglicht die Portainer Oberfläche, dass Verwalten von Docker-Compose Dateien. Klicken Sie dazu unter `Stacks` auf `Add stack`.

1. Als Name können sie `openitcockpit-ce` setzen.

2. Das [Docker-Compose-File](https://raw.githubusercontent.com/openITCOCKPIT/openITCOCKPIT-ce-docker/main/compose.yml) können Sie entweder über den Web-Editor hinzufügen, oder alternativ direkt aus dem GitHub Repository `https://github.com/openITCOCKPIT/openITCOCKPIT-ce-docker` beziehen.

    **Bitte beachten Sie**, dass alle Verweise auf das `openitcockpit.env`-File durch `stack.env` ersetzten müssen.

    Suchen Sie dafür nach diesen Einträgen
    ```
    env_file:
     - openitcockpit.env
    ```

    Ersetzten Sie sie durch
    ```
    env_file:
     - stack.env
    ```

    Sie können dies mit Hilfe des Web-Editors durchführen. (`CTRL + F` oder `CMD + F`)
    ![Find and replace openitcockpit.env with stack.env](/images/docker/portainer_stack_env.png)

3. Wähle Sie unter `Environment variables` den `Advanced mode` und kopieren Sie den Inhalt der Datei [openitcockpit.env](https://raw.githubusercontent.com/openITCOCKPIT/openITCOCKPIT-ce-docker/main/openitcockpit.env).
    Alternative können Sie auch `Load variables from .env file` auswählen dann die Datei `openitcockpit.env` hochladen.
    ![Portainer Stack configuration for openITCOCKPIT](/images/docker/portainer_create_stack.png)


4. Klicken Sie auf `Deploy the stack`
    Portainer wird nun den kompletten Stack erstellen und alle Container starten.
    ![Portainer running stack](/images/docker/portainer_stack_running.png)

## Startsequenz

Der Startvorgang des openITCOCKPIT Containers kann einige Zeit in Anspruch nehmen. Der Container überprüft bei jedem Start den Zustand der Datenbank und führt eventuelle Updates durch.
Sobald das openITCOCKPIT Frontend erreichbar ist, gibt der Container die Meldung `openITCOCKPIT is now ready` aus.

### Docker
![openITCOCKPIT is ready via Docker Compose](/images/docker/docker_ready.png)

### Portainer
![openITCOCKPIT is ready via Portainer CE](/images/docker/container_ready.png)

## MySQL Binary Log

Im Standard ist das Binary Log des MySQL-Servers über die `compose.yml`-Datei deaktiviert. Das Binary Log wird für eine Replikation zwischen mehrere MySQL-Servern benötigt,
kann allerdings auch im Falle einer Wiederherstellung der Datenbank nützlich sein. Weitere Informationen können der [MySQL Dokumentation](https://dev.mysql.com/doc/refman/8.0/en/binary-log.html)
entnommen werden.

Sollten Sie das Binary Log aktivieren wollen, muss in der `compose.yml`-Datei der Parameter `--skip-log-bin` entfernt werden.
Der Aufbewahrungszeitraum des Binary Logs, kann über den Parameter `--binlog-expire-logs-seconds=2592000` gesteuert werden. Dieser beträgt im Standard 30 Tage.

