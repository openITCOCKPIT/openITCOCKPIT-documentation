# Update von Ubuntu Bionic (18.04) auf Ubuntu Focal (20.04)

!!! danger "Backup"
    Bevor Sie beginnen, stellen Sie sicher ein **funktionierendes Backup** Ihres Systems gemacht zu haben!

Führen Sie alle Kommandos als `root` Benutzer aus.

Um immer die aktuelle Version von openITCOCKPIT verwenden zu können, ist es wichtig, dass zugrundeliegende Betriebssystem aktuell zu halten.
Mit dieser Anleitung können Sie Ihr Ubuntu Bionic System auf Ubuntu Focal aktualisieren.

!!! warning "End of Life"
    Ubuntu 18.04 (Bionic) hat im Mai 2023 das Ende seiner Lebenszeit erreicht, Ubuntu 20.04 (Focal) im Mai 2025.
    Beide Releases erhalten keine Sicherheitsupdates mehr. Nutzen Sie diese Anleitung nur, um eine bestehende
    Installation zu migrieren - eine Neuinstallation auf einem unterstützten Release ist in der Regel die bessere Wahl.

##  Voraussetzungen
 -  openITCOCKPIT in der Version 4.x
 -  Keine Pakete die `lxd` beinhalten

## Entfernen aller `lxd` Pakete
Sollten auf Ihrem System `lxd` Pakete installiert sein, müssen diese zuerst entfernt werden. Prüfen können Sie dies mit dem Befehl
```
apt list --installed | grep lxd
```

Sollten Pakete installiert sein, müssen diese zuerst entfernt werden
```
apt -y remove lxd*
```

## Installation aller Updates
Bevor Sie mit dem Update von Ubuntu beginnen, stellen Sie bitte sicher, dass alle verfügbaren Updates installiert wurden.

```
apt update && apt -y full-upgrade
```

## Deaktivieren Sie MySQL Query Cache
Der MySQL Query Cache wurde mit [MySQL 8.0](https://dev.mysql.com/blog-archive/mysql-8-0-retiring-support-for-the-query-cache/) entfernt.
Stellen Sie daher sicher, dass der Query Cache in Ihrer MySQL-Konfiguration deaktiviert ist.
```
sed -i 's/^[ ]*query_cache/#query_cache/g' /etc/mysql/mysql.conf.d/*.cnf
```

## Stoppen Sie den PHP-FPM Dienst
```
systemctl stop php7.2-fpm.service
```

## Paketquellen ändern
Nun können die Paketquellen auf den nächsten Ubuntu-Release geändert werden
```
sed -i 's/bionic/focal/g' /etc/apt/*.list
sed -i 's/bionic/focal/g' /etc/apt/*/*.list
```

## Upgrade durchführen
Jetzt wird das eigentliche Upgrade von Ubuntu 18.04 auf 20.04 durchgeführt.
```
apt update && apt -y full-upgrade
```

Während des Upgrades, werden vom System eventuell verschiedene Nachfragen gestellt. Diese sollten Sie wie folgt beantworten.

### libc6
Eventuelle Nachfragen bezüglich `libc6` müssen mit `Yes` beantwortet werden.
![libc6 configure](/images/updates/ubuntu-bionic/libc6.png){ align=center }

### MySQL
Sehr wahrscheinlich wird der Neustart des MySQL Servers fehlgeschlagen. Dies kann ignoriert werden.

![mysql restart will fail](/images/updates/ubuntu-bionic/mysql.png){ align=center }

### openssh-server
Behalten Sie die aktuelle Konfiguration Ihres OpenSSH Servers

### phpMyAdmin
Sollten Sie phpMyAdmin auf Ihrem System installiert haben, beantworten Sie auch diese Nachfrage mit `Yes`

![configure phpMyAdmin](/images/updates/ubuntu-bionic/mysql.png){ align=center }

### Sub-process error
Es kann passieren, dass die Installation dem Fehler `E: Sub-process /usr/bin/dpkg returned an exit code (1)` abbricht.
Dies kann ignoriert werden.

![E: Sub-process error](/images/updates/ubuntu-bionic/fehler.png){ align=center }

### Update von PHP
Nun werden alle PHP Pakete aktualisiert.

```
systemctl stop php7.2-fpm.service
```

```
dpkg -l | awk '/php7.2/ { print $2}' | sed 's/php7.2/php7.4/' | xargs apt-get install -y
dpkg -l | awk '/php7.2/ { print $2}' | xargs apt-get purge -y
```

### Konfiguration aktualisieren
Im letzten Schritt werden alle Konfigurationsdateien aktualisiert und bei Bedarf neu generiert.

#### openITCOCKPIT Master
Wenn Sie das Update auf einem openITCOCKPIT Master System ausführen, nutzen Sie den folgenden Befehl
```
openitcockpit-update --cc
```

#### openITCOCKPIT Satellit
Auf einem openITCOCKPIT Satellit nutzen Sie den folgenden Befehl
```
/opt/openitc/frontend/UPDATE.sh
```

Um das Update abzuschließen, wird ein Neustart empfohlen
```
reboot
```
