# Update von Ubuntu Focal (20.04) auf Ubuntu Jammy (22.04)

!!! danger "Backup"
    Bevor Sie beginnen, stellen Sie sicher ein **funktionierendes Backup** Ihres Systems gemacht zu haben!

Führen Sie alle Kommandos als `root` Benutzer aus.

Um immer die aktuelle Version von openITCOCKPIT verwenden zu können, ist es wichtig, dass zugrundeliegende Betriebssystem aktuell zu halten.
Mit dieser Anleitung können Sie Ihr Ubuntu Focal System auf Ubuntu Jammy aktualisieren.

!!! warning "End of Life"
    Ubuntu 20.04 (Focal) hat im Mai 2025 das Ende seiner Lebenszeit erreicht und erhält keine
    Sicherheitsupdates mehr. Nutzen Sie diese Anleitung nur, um eine bestehende Installation zu migrieren -
    eine Neuinstallation auf einem unterstützten Release ist in der Regel die bessere Wahl.

##  Voraussetzungen
 -  openITCOCKPIT in der Version 4.x
 -  Keine Pakete die `lxd` beinhalten.

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

## Stoppen Sie den PHP-FPM Dienst
```
systemctl stop php7.4-fpm.service
```

## openITCOCKPIT Pakete ermitteln
Nun werden zuerst alle installierten Pakete von openITCOCKPIT ermittelt und in der Variable `openitcockpit_upd` gespeichert.
```
openitcockpit_upd=$(apt-mark showmanual | grep openitcockpit | xargs echo)" "$(apt-mark showauto | grep openitcockpit | xargs echo)
```

## Paketquellen ändern
Nun können die Paketquellen auf den nächsten Ubuntu-Release geändert werden
```
sed -i 's/focal/jammy/g' /etc/apt/*.list
sed -i 's/focal/jammy/g' /etc/apt/*/*.list
```

## Upgrade durchführen
Jetzt wird das eigentliche Upgrade von Ubuntu 20.04 auf 22.04 durchgeführt.
```
apt update && apt -y full-upgrade $openitcockpit_upd php-json php-curl php-gearman php-xml apache2-
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
