# Update von Debian Bookworm (12) auf Debian Trixie (13)

!!! danger "Backup"
    Bevor Sie beginnen, stellen Sie sicher, dass Sie ein **funktionierendes Backup** Ihres Systems erstellt haben!

Führen Sie alle Kommandos als `root` Benutzer aus.

Um immer die aktuelle Version von openITCOCKPIT verwenden zu können, ist es wichtig, das zugrundeliegende Betriebssystem aktuell zu halten.  
Mit dieser Anleitung können Sie Ihr Debian Bookworm System auf Debian Trixie aktualisieren.

---

## Voraussetzungen
- openITCOCKPIT in der Version 5.x
- Keine Pakete, die `lxd` beinhalten
- Internetzugang für den Download von Docker-Repository-Schlüsseln

---

## Entfernen aller `lxd` Pakete
Sollten auf Ihrem System `lxd` Pakete installiert sein, müssen diese zuerst entfernt werden. Prüfen können Sie dies mit:

```bash
apt list --installed | grep lxd
```

Falls Pakete installiert sind, entfernen Sie diese mit:

```bash
apt -y remove lxd*
```

---

## Docker-Repository hinzufügen
Damit Docker aus den offiziellen Quellen installiert werden kann, muss das Repository hinzugefügt werden:

```bash
# Keyring-Verzeichnis anlegen
install -d -m 0755 /etc/apt/keyrings

# Docker GPG-Key speichern
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc

# Repository hinzufügen
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \\
https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \\
| tee /etc/apt/sources.list.d/docker.list > /dev/null
```

---

## Installation aller Updates (noch auf Bookworm)
Bevor Sie mit dem Upgrade auf Debian Trixie beginnen, stellen Sie bitte sicher, dass alle verfügbaren Updates installiert wurden:

```bash
apt update
apt -y full-upgrade
```

---

## Stoppen Sie den PHP-FPM Dienst
Vor dem Upgrade sollte PHP-FPM 8.2 angehalten werden, um Konflikte zu vermeiden:

```bash
systemctl stop php8.2-fpm.service
```

---

## openITCOCKPIT Pakete ermitteln
Nun werden zuerst alle installierten Pakete von openITCOCKPIT ermittelt und in einer Variablen gespeichert:

```bash
openitcockpit_upd=$(apt-mark showmanual | grep openitcockpit | xargs echo)" "$(apt-mark showauto | grep openitcockpit | xargs echo)
```

---

## Paketquellen ändern
Die Debian-Paketquellen müssen nun auf den neuen Release Trixie angepasst werden:

```bash
sed -i 's/bookworm/trixie/g' /etc/apt/sources.list /etc/apt/sources.list.d/*.list
sed -ri 's/\bbookworm-security\b/trixie-security/g; s/\bbookworm-updates\b/trixie-updates/g; s/\bbookworm\b/trixie/g' /etc/apt/sources.list.d/debian.sources
```

---

## Upgrade durchführen
Nun wird das eigentliche Upgrade gestartet:

```bash
apt update

# Simulation (nur prüfen)
apt -s full-upgrade $openitcockpit_upd

# Upgrade wirklich ausführen
apt -y full-upgrade $openitcockpit_upd
```

---

## Nicht mehr benötigte Pakete löschen
```bash
apt autoremove
```

---

## PHP nach Upgrade starten
```bash
systemctl restart php8.4-fpm.service
```

---

## Konfiguration aktualisieren
Im letzten Schritt werden alle Konfigurationsdateien aktualisiert und bei Bedarf neu generiert.

### openITCOCKPIT Master
Wenn Sie das Update auf einem openITCOCKPIT Master System ausführen, nutzen Sie den folgenden Befehl
```
openitcockpit-update --cc
```

### openITCOCKPIT Satellit
Auf einem openITCOCKPIT Satellit nutzen Sie den folgenden Befehl
```
/opt/openitc/frontend/UPDATE.sh
```

## Neustart durchführen
Um das Update abzuschließen, wird ein Neustart empfohlen
```bash
reboot
```
