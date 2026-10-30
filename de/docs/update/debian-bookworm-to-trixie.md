# Update von Debian Bookworm (12) auf Debian Trixie (13)

!!! danger "Backup"
    Bevor Sie beginnen, stellen Sie sicher, dass Sie ein **funktionierendes Backup** Ihres Systems erstellt haben!
    Auf virtuellen Maschinen legen Sie zusätzlich einen Snapshot an, um das komplette Upgrade zurückrollen zu können.

Führen Sie alle Kommandos als `root` Benutzer aus.

Um immer die aktuelle Version von openITCOCKPIT verwenden zu können, ist es wichtig, das zugrundeliegende Betriebssystem aktuell zu halten.  
Mit dieser Anleitung können Sie Ihr Debian Bookworm System auf Debian Trixie aktualisieren.

!!! info "openITCOCKPIT Version"
    Das Upgrade installiert die aktuellste openITCOCKPIT Version, die für Debian Trixie verfügbar ist.
    Es ist nicht möglich, während des Betriebssystem-Upgrades auf der bisherigen openITCOCKPIT Version zu bleiben.

---

## Voraussetzungen
- openITCOCKPIT in der Version 5.x
- Keine Pakete, die `lxd` beinhalten
- Internetzugang für den Download von Docker-Repository-Schlüsseln
- Mindestens 5 GB freier Speicherplatz auf `/` - während des Upgrades werden etwa 2 GB Pakete heruntergeladen

Prüfen Sie vor dem Start den freien Speicherplatz:

```bash
df -h /
```

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
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
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

Falls Sie eine andere PHP Version einsetzen, stoppen Sie den entsprechenden `phpX.Y-fpm.service`.

---

## Alte systemd Units entfernen
openITCOCKPIT 5.9 ersetzt Statusengine 3 durch Statusengine 4. Der Cleanup Dienst startet jetzt
`/opt/openitc/statusengine4/worker/bin/db_cleanup`, ältere Installationen nutzten
`/opt/openitc/statusengine3/worker/bin/Console.php`.

Units unter `/etc/systemd/system` haben Vorrang vor den Units aus `/usr/lib/systemd/system`.
Eine zurückgebliebene Unit aus Statusengine 3 Zeiten überdeckt daher die neue Unit und der Dienst
scheitert mit `status=203/EXEC`.

Prüfen Sie, welche Unit aktuell verwendet wird:

```bash
systemctl cat statusengine_cleanup.service statusengine_cleanup.timer
ls -l /etc/systemd/system/statusengine_cleanup.*
```

Existiert eine Unit unter `/etc/systemd/system`, deaktivieren Sie diese, verschieben Sie sie und aktivieren
Sie sie anschließend erneut:

```bash
systemctl disable statusengine_cleanup.timer
mkdir -p /root/backup_units
mv /etc/systemd/system/statusengine_cleanup.* /root/backup_units/
systemctl daemon-reload
systemctl enable --now statusengine_cleanup.timer
```

Nach diesem Schritt müssen beide Units aus `/usr/lib/systemd/system` geladen werden.

---

## openITCOCKPIT Pakete ermitteln
Nun werden zuerst alle installierten Pakete von openITCOCKPIT ermittelt und in einer Variablen gespeichert:

```bash
openitcockpit_upd=$(apt-mark showmanual | grep openitcockpit | grep -v '^openitcockpit-statusengine3-worker$' | xargs echo)" "$(apt-mark showauto | grep openitcockpit | grep -v '^openitcockpit-statusengine3-worker$' | xargs echo)
```

!!! warning "openitcockpit-statusengine3-worker nicht pinnen"
    Seit openITCOCKPIT 5.9 wird das Paket `openitcockpit-statusengine3-worker` durch
    `openitcockpit-statusengine4-worker` ersetzt. Wird das alte Paket explizit angefordert, bricht apt mit
    `openitcockpit-statusengine4-worker : Conflicts: openitcockpit-statusengine3-worker` ab.

---

## Paketquellen ändern
Die Debian-Paketquellen müssen nun auf den neuen Release Trixie angepasst werden:

```bash
# sources.list und alle *.list Dateien (z. B. docker.list)
sed -i 's/bookworm/trixie/g' /etc/apt/sources.list /etc/apt/sources.list.d/*.list

# deb822 Quellen - seit Debian 13 Standard, auf Bookworm oft nicht vorhanden
if [ -f /etc/apt/sources.list.d/debian.sources ]; then
    sed -ri 's/\bbookworm-security\b/trixie-security/g; s/\bbookworm-updates\b/trixie-updates/g; s/\bbookworm\b/trixie/g' /etc/apt/sources.list.d/debian.sources
fi
```

Prüfen Sie, dass keine Bookworm-Quelle übrig ist:

```bash
grep -rn bookworm /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null
```

Der `grep` Befehl darf keine Zeile mehr ausgeben.

---

## Upgrade durchführen
Nun wird das eigentliche Upgrade gestartet:

```bash
apt update

# Simulation (nur prüfen) - darf keine unerfüllten Abhängigkeiten melden
apt -s full-upgrade $openitcockpit_upd

# Upgrade wirklich ausführen
apt -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" full-upgrade $openitcockpit_upd
```

Die `Dpkg::Options` behalten bestehende Konfigurationsdateien ohne Rückfrage bei. Konfigurationsdateien,
die von openITCOCKPIT verwaltet werden, werden im letzten Schritt durch das Update-Skript neu geschrieben.

Bei Fehler:

```bash
dpkg --configure -a
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

---

## Neustart durchführen
Ein Neustart des Systems ist erforderlich, um den neuen Kernel zu aktivieren:

```bash
reboot
```

---

## Verifikation
Prüfen Sie nach dem Neustart, ob das Upgrade erfolgreich abgeschlossen wurde:

```bash
grep PRETTY_NAME /etc/os-release
systemctl --failed
systemctl status php8.4-fpm.service
systemctl status statusengine_cleanup.timer
```

`systemctl --failed` darf keine Unit auflisten und der Cleanup Timer muss aus
`/usr/lib/systemd/system/statusengine_cleanup.timer` geladen werden.
