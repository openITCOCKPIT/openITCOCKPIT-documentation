

# Upgrade openITCOCKPIT 3 zu openITCOCKPIT 4

![oitc upgrade v3 - v4](/images/oitc_autobahn.png)

Diese Anleitung beschreibt die Aktualisierung von ihrer aktuellen openITCOCKPIT 3.7.3 (oder neuer) zu openITCOCKPIT 4.

!!! info "Bevor Sie mit dem Upgrade Starten, erstellen Sie bitte ein Backup ihres Systems!"
    Es wird empfohlen das Backup und den Aktualisierungsprozess in einer Testumgebung zu testen.

### Voraussetzungen

- Stellen Sie sicher, dass ihre openITCOCKPIT Installation auf dem neusten Stand ist.
- openITCOCKPIT >= 3.7.3
- Alle Betriebssystemupdates sind installiert.
- Ein funktionierendes Backup ihrer openITCOCKPIT installation (für den fall, dass etwas schiefläuft).
- mindestens **20 GB** freier Festplatten speicherplatz.
- Distributed Monitoring: es wird vorausgesetzt, dass **alle** Satellitensysteme auch auf openITCOCKPIT v4 aktualisiert werden.
- Führen Sie alle Kommandos als `root` Benutzer aus

### Unterstützte Betriebssysteme

| Ubuntu Focal (20.04) | Ubuntu Bionic (18.04) | Ubuntu Xenial (16.04) | Ubuntu Trusty (14.04) | Debian Buster (10) | Debian Stretch (9) | Debian Jessie (8) |
|---|---|---|---|---|---|---|
|:fontawesome-solid-check:|:fontawesome-solid-check:|:fontawesome-solid-check: :fontawesome-solid-triangle-exclamation:|:fontawesome-solid-xmark:|:fontawesome-solid-check:|:fontawesome-solid-check: :fontawesome-solid-triangle-exclamation:|:fontawesome-solid-xmark:|


:fontawesome-solid-triangle-exclamation: **Ubuntu Xenial (16.04)**

openITCOCKPIT unterstützt kein Ubuntu Xenial. Bei einer aktualisierung auf openITCOCKPIT 4 wird ein Distributionsupgrade auf Ubuntu Bionic (18.04) durchgeführt.


:fontawesome-solid-triangle-exclamation: **Debian Stretch (9)**

openITCOCKPIT unterstützt kein Debian Stretch. Bei einer aktualisierung auf openITCOCKPIT 4 wird ein Distributionsupgrade auf Debian Buster (10) durchgeführt.

### System vorbereiten

Wenn Sie Ubuntu Xenial verwenden, müssen Sie das `lxd` Paket entfernen, da dies möglicherweise Fehler beim Upgrade auf Ubuntu Bionic und openITCOCKPIT v4 verursachen könnte.
```bash
#only run on Ubuntu Xenial!
apt-get remove lxd
```

### Schritt 1 - Betriebssystem aktualisieren

```bash
apt-get update
apt-get dist-upgrade
```

### Schritt 2 - Datenbank Backup erstellen

!!! warning
    Stellen Sie sicher, dass genügend freier Festplattenspeicher bereitsteht.

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


### Schritt 3 - Führen Sie den openITCOCKPIT v4 Kompatibilitätscheck aus

!!! danger "Hinweis für Benutzer des i-doit und discovery Moduls"
    Die Module `openitcockpit-module-discovery` und `openitcockpit-module-idoit` sind in openITCOCKPIT 4 **nicht verfügbar**.
    Sollten Sie diese Module in benutzung haben, sollten Sie aktuell noch **nicht** auf openITCOCKPIT 4 aktualisieren!

Um sicherzustellen, dass ihr System in der lage ist auf openITCOCKPIT 4.x aktualisiert werden zu können, stellen wir ein
Kompatibilitätscheck-Skript zur verfügung.

Führen Sie das Skript auf ihrer openITCOCKPIT Instanz aus.

```bash
curl -s https://raw.githubusercontent.com/openITCOCKPIT/openITCOCKPIT/development/bin/scripts/oitc3to4.sh | sudo /bin/bash
```

![oitc 3-4](/images/oitc3to4.png)


**Es wurden bisher keine änderungen an ihrem System vorgenommen!**

!!! danger "Achtung!"
    Fahren Sie nicht mit der aktualisierung fort, solange Sie noch Fehler oder Warnungen durch den Kompatibilitätscheck
    bekommen!


Lösen Sie sie angezeigten Probleme und führen Sie das check Skript erneut aus.
Haben Sie alle Fehler gelöst, können Sie mit der aktualisierung fortfahren.


#### Schritt 3.1 Distributed monitoring

Es wird vorausgesetzt, dass alle Satelliten Systeme auf openITCOCKPIT 4 aktualisiert werden.

Mit dem aktuellen Release ist es nicht möglich openITCOCKPIT 3.x Satelliten mit einem openITCOCKPIT 4.x Master System zu
verbinden. Sollten Sie aus irgend welchen Gründen ihre Satelliten Systeme **nicht** aktualisieren können, aktualisieren
Sie ihr Master System jetzt nicht!

#### Schritt 3.2 openITCOCKPIT aktualisieren

!!! warning "Stabile SSH-Verbindung wird benötigt!"
    Der Aktualisierungsprozess kann eine Weile dauern. Um SSH Verbindungsproblemen vorzubeugen, empfehlen wir die
    Benutzung von `tmux` oder `screen`.

**Das Kompatibilitätscheck-Skript zeigt die benötigten Kommandos zum Aktualisieren ihrer openITCOCKPIT Installation auf
Basis der installierten Module und der genutzten Distribution an. Die Aktualisierungskommandos werden individuell für
jedes System generiert**

!!! danger
    Nutzen sie KEINE anderen Kommandos um ihr System zu aktualisieren!

##### Ubuntu Nutzer

Stellen Sie sicher, dass auf ihrem System die `universe` repositories aktiviert sind.

```bash
add-apt-repository universe
```

##### Debian Nutzer

Stellen Sie sicher, dass auf ihrem System die `non-free` repositories aktiviert sind.

`/etc/apt/sources.list`

```bash 
deb http://ftp.de.debian.org/debian/ buster main contrib non-free
deb http://ftp.de.debian.org/debian/ buster-updates main contrib non-free
deb http://security.debian.org/ buster/updates main contrib non-free
```

**Führen Sie die Kommandos aus ihrem Kompatibilitätscheck-Skript aus um ihre openITCOCKPIT Installation zu aktualisieren**

Während der aktualisierung werden Sie möglicherweise gefragt, ob Sie einige Konfigurationsdateien mit neueren Versionen
überschreiben möchten. Diese Konfigurationsdateien gehören dem Betriebssystem an, Sie können also wählen, ob Sie Ihre
Version oder die neuere Version haben möchten. Dies hat keine Auswirkung auf die openITCOCKPIT aktualisierung.

##### Ubuntu Xenial und Debian Stretch Nutzer

Die openITCOCKPIT aktualisierung wird zusätzlich auch ihre Distribution aktualisieren (Ubuntu Xenial auf Ubuntu Bionic
und Debian Stretch auf Debian Buster). Haben Sie eigene Software oder Drittanbieter-Repositories eingebunden, müssen Sie
zudem sicherstellen, dass diese Kompatibel mit Ubuntu Bionic oder Debian Buster ist.

### Schritt 4 - Benutzerpasswörter zurücksetzen

Nach dem Aktualisierungsprozess müssen alle [Benutzerpasswörter zurückgesetzt](../reset-passwords/) werden. Sollten Sie LDAP nutzen müssen Sie
dies nicht durchführen.

#### Passwort eines Benutzers zurücksetzen

Um das Passwort eines einzelnen Benutzers zurückzusetzen, können Sie das folgende Kommando nutzen:

```bash
oitc reset_password --print --enable
```

Das System wird ein neues, zufallsgeneriertes Passwort erzeugen und an die E-Mail-Adresse des Benutzers senden.

`--print` zeigt das neue Passwort zusätzlich im Terminal an.

`--no-email` versendet das neue Passwort nicht an die E-Mail-Adresse des Benutzers.

![reset password](/images/oitc_reset_password.png)

![password mail](/images/oitc_new_password_mail.png)

#### Alle Benutzerpasswörter zurücksetzen

Um alle lokalen Benutzerpasswörter zurückzusetzen, können Sie folgendes Kommando nutzen:

```bash
oitc update3_to4 --reset-all-passwords
```

Das System wird neue, zufallsgenerierte Passwörter für jeden Benutzer erzeugen und an die jeweilige E-Mail-Adresse des
Benutzers senden.

### Schritt 5 - Browser Cache leeren

Bevor Sie sich in ihrer neuen openITCOCKPIT Oberfläche anmelden, sollten Sie ihren Browser Cache leeren

Mozilla Firefox: <https://support.mozilla.org/en-US/kb/how-clear-firefox-cache>

Google Chrome: <https://support.google.com/accounts/answer/32050?co=GENIE.Platform%3DDesktop&hl=en>

#### Schritt 5.1 Einloggen in der neuen openITCOCKPIT Oberfläche

Es wird empfohlen, eine [Aktualisierung der Überwachungskonfiguration](../../monitoring/basic-principles/#export) durchzuführen.
Dieser Schritt stellt sicher, dass alle Monitoring relevanten Konfigurationsdateien geschrieben werden.

### Schritt 6 - Neustart des NSTA (betrifft nur Distributed Monitoring)

Um die verarbeitung von Satelliten check ergebnissen zu starten, ist es erforderlich, den NSTA daemon neu zu starten

```bash 
systemctl restart nsta
```

### Schritt 7 - System neu starten

Speziell bei einer aktualisierung von Ubuntu Xenial oder Debian Stretch wird ein Neustart empfohlen.

### Aktualisierung der openITCOCKPIT Satellitensysteme (betrifft nur Distributed Monitoring)

#### Betriebssystem aktualisieren

**Zunächst müssen alle Systemupdates installiert werden**

```bash
apt-get update
apt-get dist-upgrade
```

**Danach führen Sie das openITCOCKPIT Satelliten Checklisten Skript aus und folgen den Anweisungen**

```bash
curl -s https://raw.githubusercontent.com/openITCOCKPIT/openITCOCKPIT/development/bin/scripts/oitcSat3to4.sh | sudo /bin/bash
```

### Bekannte Probleme

#### Alle Distributionen

Die Module `openitcockpit-module-discovery` und `openitcockpit-module-idoit` sind bisher **nicht** für openITCOCKPIT 4
verfügbar. Sollten Sie diese Module nutzen, ziehen Sie in erwägung eine Aktualisierung **nicht** durchzuführen.

##### Kein Login möglich nach Passwort reset

Wenn das Passwort richtig zurückgesetzt wurde, der Benutzer sich aber weiterhin nicht in der openITCOCKPIT oberfläche
anmelden kann (Fehlermeldung: `Invalid username or password`), muss der Benutzer manuell in der Datenbank aktiviert
werden. Dies kann durch das folgende SQL Kommando erfolgen:

```sql 
UPDATE users SET is_active = 1 WHERE users.email= 'user@example.com';
```

##### Warnungen und Abhängigkeitsprobleme während des Aktualisierungsprozesses

Während des Aktualisierungsprozesses werden Sie ähnliche Nachrichten wie diese sehen:

```bash
Unpacking openitcockpit-module-distribute (4.0.4-20200721154853bionic) over (3.7.3-1ubuntu16.04) ...
dpkg: warning: unable to delete old directory '/etc/openitcockpit/app/Plugin/DistributeModule/Config/Schema': Directory not empty
dpkg: warning: unable to delete old directory '/etc/openitcockpit/app/Plugin/DistributeModule/Config': Directory not empty
dpkg: warning: unable to delete old directory '/etc/openitcockpit/app/Plugin/DistributeModule': Directory not empty
dpkg: warning: unable to delete old directory '/usr/share/openitcockpit/app/Plugin/DistributeModule': Directory not empty
```

oder:

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

Diese Nachrichten können Sie ignorieren.

##### Keine Satelliten Check Ergebnisse auf dem Master Server

Sollte der Master Server keine Check-Ergebnisse von seinen Satellitensystemen erhalten, wird eine [Aktualisierung der Überwachungskonfiguration](../../monitoring/basic-principles/#export)
und ein Neustart des NSTA möglicherweise beheben.

```bash
systemctl restart nsta
```

##### Checkmk
`Filesystem checks: UNKN - check failed - please submit a crash report!`

Editieren Sie die Servicevorlage `CHECK_MK_DF` und setzen Sie für ARG1 folgenden Wert:

```
{'levels': (80.0, 90.0)}
```

![checkmk df template](/images/edit_checkmk_df_servicetemplate.png)

![checkmk df template arg1](/images/new_checkmk_df_arg1.png)


### Troubleshooting

#### Netzwerk fehler

Sollten Sie Verbindungsfehler mit ihrem System haben, können Sie versuchen die Installation zu reparieren. Nutzen Sie
dazu folgendes Kommando:

```bash
apt-get install -f
```

#### Ihre openITCOCKPIT Version ist < 3.7.3
Der Aktualisierungsprozess benötigt openITCOCKPIT mindestens in der Version 3.7.3. Bitte beachten Sie unsere [Blogposts]((https://openitcockpit.io/blog/#blog)
falls Sie von einer älteren Version 3 aktualisieren möchten - speziell von Version 3.5 oder älter. Manuelle änderungen
sind nötig, falls Sie ihre Performance Graphen in der neueren Version nutzen möchten.

#### Table nagios servicechecks is 36626 MB but /var/lib/mysql only has 16316 MB free disk space

Während des Aktualisierungsprozess werden alle MySQL Tabellen von UTF8 auf UTF8mb4 konvertiert. Dieser Prozess benötigt einigen Festplattenspeicherplatz. Bitte Ignorieren Sie diese Fehler nicht.

#### openITCOCKPIT v4 Aktualisierung von Ubuntu Xenial 16.04 auf Bionic 18.04 schlägt fehl durch lxd Paket

Wenn die Aktualisierung von Ubuntu Xenial fehlschlägt durch das `lxd` Paket und folgender Fehler erscheint: 

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
 
Fehler traten auf beim Bearbeiten von:
 lxd
E: Sub-process /usr/bin/dpkg returned an error code (1)
```

Ist die Weboberfläche von openITCOCKPIT im Browser nicht sichtbar.

Es müssen die folgenden Kommandos ausgeführt werden: 

```bash
apt-get install -f
apt-get remove lxd
apt-get autoremove
reboot
 
#after reboot you need to trigger the UPGRADE script from itcockpit which was not triggered during the upgrade
/opt/openitc/frontend/bin/scripts/UPGRADE.sh
```

Danach sollte die Weboberfläche sichtbar und die Distributionsaktualisierung abgeschlossen sein. 

#### Ich nutze Ubuntu Trusty oder Debian Jessie

Bitte Kontaktieren Sie uns über unser [Sales Kontaktformular](https://www.allgeier-its.com/unternehmen/#kontakt)

