# Update von Debian Bullseye (11) auf Debian Bookworm (12)

!!! danger "Backup"
    Bevor Sie beginnen, stellen Sie sicher ein **funktionierendes Backup** Ihres Systems gemacht zu haben!

Führen Sie alle Kommandos als `root` Benutzer aus.

Um immer die aktuelle Version von openITCOCKPIT verwenden zu können, ist es wichtig, das zugrundeliegende Betriebssystem aktuell zu halten.
Mit dieser Anleitung können Sie Ihr Debian Bullseye System auf Debian Bookworm aktualisieren.

!!! warning "End of Life"
    Debian 11 (Bullseye) hat im August 2026 das Ende seiner Lebenszeit erreicht und erhält keine
    Sicherheitsupdates mehr. Nutzen Sie diese Anleitung nur, um eine bestehende Installation zu migrieren -
    eine Neuinstallation auf einem unterstützten Release ist in der Regel die bessere Wahl.

##  Voraussetzungen
 -  openITCOCKPIT in der Version 4.x oder 5.x
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
Bevor Sie mit dem Update von Debian beginnen, stellen Sie bitte sicher, dass alle verfügbaren Updates installiert wurden.

```
apt update
apt -y full-upgrade
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
Nun müssen die Paketquellen auf den nächsten Debian-Release geändert werden. Überschreiben Sie
`/etc/apt/sources.list` nicht - dort kann eine Mirror- oder Proxy-Konfiguration stehen, und das
openITCOCKPIT Repository liegt in `/etc/apt/sources.list.d/openitcockpit.sources`.

Ersetzen Sie den Release-Namen in allen Quelldateien - das schließt die `*.sources` Dateien im
deb822-Format mit ein:

```bash
for f in /etc/apt/sources.list /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources; do
    [ -f "$f" ] && sed -i 's/bullseye/bookworm/g' "$f"
done
```

Debian 12 hat die Komponente `non-free-firmware` eingeführt. Ergänzen Sie diese, falls sie fehlt:

```bash
sed -i 's/ main contrib non-free$/ main contrib non-free non-free-firmware/' /etc/apt/sources.list
```

Prüfen Sie, dass keine Bullseye-Quelle übrig ist:

```bash
grep -rn bullseye /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null
```

Der `grep` Befehl darf keine Zeile mehr ausgeben.

## Upgrade durchführen
Jetzt wird das eigentliche Upgrade von Debian 11 auf 12 durchgeführt.
```bash
apt update

# Simulation (nur prüfen) - darf keine unerfüllten Abhängigkeiten melden
apt -s full-upgrade $openitcockpit_upd php-json php-curl php-gearman php-xml

# Upgrade wirklich ausführen
apt -y full-upgrade $openitcockpit_upd php-json php-curl php-gearman php-xml
```

### Update von PHP
Nun werden alle PHP Pakete aktualisiert. Debian 12 bringt PHP 8.2 mit, die alten 7.4 Pakete müssen
entfernt werden.

```bash
dpkg -l | awk '/^ii +php7\.4/ { print $2 }' | xargs -r apt-get purge -y
rm -rf /etc/php/7.4/
```

### Zeitzone in php.ini anpassen (optional)

openITCOCKPIT verwendet die Zeitzone aus der PHP-Konfiguration. Prüfen Sie den aktuellen Wert in
`/etc/php/8.2/fpm/php.ini`:

```bash
grep '^;\?date.timezone' /etc/php/8.2/fpm/php.ini
```

Ist der Wert leer oder passt nicht zur Zeitzone des Systems, setzen Sie ihn auf die Systemzeitzone:

```bash
timezone=$(timedatectl show -p Timezone --value)
sed -i "s|^;\?date.timezone =.*|date.timezone = ${timezone}|" /etc/php/8.2/fpm/php.ini
```

### PHP FPM (neu-)starten

```
systemctl restart php8.2-fpm.service
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
