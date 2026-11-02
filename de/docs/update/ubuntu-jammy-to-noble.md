# Update von Ubuntu Jammy (22.04) auf Ubuntu Noble (24.04)

!!! danger "Backup"
    Bevor Sie beginnen, stellen Sie sicher, dass Sie ein **funktionierendes Backup** Ihres Systems erstellt haben!
    Auf virtuellen Maschinen legen Sie zusätzlich einen Snapshot an, um das komplette Upgrade zurückrollen zu können.

Führen Sie alle Kommandos als `root` Benutzer aus.

Um immer die aktuelle Version von openITCOCKPIT verwenden zu können, ist es wichtig, das zugrundeliegende Betriebssystem aktuell zu halten.
Mit dieser Anleitung können Sie Ihr Ubuntu Jammy System auf Ubuntu Noble aktualisieren.

!!! info "openITCOCKPIT Version"
    Das Upgrade installiert die aktuellste openITCOCKPIT Version, die für Ubuntu Noble verfügbar ist.
    Es ist nicht möglich, während des Betriebssystem-Upgrades auf der bisherigen openITCOCKPIT Version zu bleiben.

!!! info "Dauer und Erreichbarkeit"
    Rechnen Sie mit 15 bis 60 Minuten, abhängig von der Anzahl der Pakete und der Leistung des Systems.
    Ab dem Stoppen von PHP-FPM ist die openITCOCKPIT Weboberfläche nicht mehr erreichbar, bis die Konfiguration
    am Ende dieser Anleitung neu geschrieben wurde.

---

## Voraussetzungen
- openITCOCKPIT in der Version 4.x oder 5.x
- Mindestens 5 GB freier Speicherplatz auf `/` - während des Upgrades werden etwa 2 GB Pakete heruntergeladen

Prüfen Sie vor dem Start den freien Speicherplatz:

```bash
df -h /
```

---

## Installation aller Updates
Bevor Sie mit dem Upgrade von Ubuntu beginnen, stellen Sie bitte sicher, dass alle verfügbaren Updates installiert wurden.

```bash
apt update && apt -y full-upgrade
```

---

## PHP-FPM stoppen
Vor dem Upgrade sollte PHP-FPM 8.1 angehalten werden, um Konflikte zu vermeiden:

```bash
systemctl stop php8.1-fpm.service
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
Nun werden zuerst alle installierten Pakete von openITCOCKPIT ermittelt und in der Variable `openitcockpit_upd` gespeichert:

```bash
openitcockpit_upd=$(apt-mark showmanual | grep openitcockpit | grep -v '^openitcockpit-statusengine3-worker$' | xargs echo)" "$(apt-mark showauto | grep openitcockpit | grep -v '^openitcockpit-statusengine3-worker$' | xargs echo)
```

!!! warning "openitcockpit-statusengine3-worker nicht pinnen"
    Seit openITCOCKPIT 5.9 wird das Paket `openitcockpit-statusengine3-worker` durch
    `openitcockpit-statusengine4-worker` ersetzt. Wird das alte Paket explizit angefordert, bricht apt mit
    `openitcockpit-statusengine4-worker : Conflicts: openitcockpit-statusengine3-worker` ab.

---

## Paketquellen ändern
Die Ubuntu-Paketquellen müssen nun auf den neuen Release Noble angepasst werden:

```bash
for f in /etc/apt/sources.list /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources; do
    [ -f "$f" ] && sed -i 's/jammy/noble/g' "$f"
done
```

Damit werden sowohl `/etc/apt/sources.list` als auch deb822-Quellen wie `/etc/apt/sources.list.d/ubuntu.sources` umgestellt.

Prüfen Sie, dass keine Jammy-Quelle übrig ist:

```bash
grep -rn jammy /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null
```

Der `grep` Befehl darf keine Zeile mehr ausgeben.

---

## Upgrade durchführen
Nun wird das eigentliche Upgrade von Ubuntu 22.04 auf 24.04 gestartet:

```bash
apt update

# Simulation (nur prüfen) - darf keine unerfüllten Abhängigkeiten melden
apt -s full-upgrade $openitcockpit_upd apache2-

# Upgrade wirklich ausführen
apt -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" full-upgrade $openitcockpit_upd apache2-
```

Die `Dpkg::Options` behalten bestehende Konfigurationsdateien ohne Rückfrage bei. Konfigurationsdateien,
die von openITCOCKPIT verwaltet werden, werden im letzten Schritt durch das Update-Skript neu geschrieben.

Schlägt das Upgrade fehl, setzen Sie es so fort:

```bash
dpkg --configure -a
```

---

## Nicht mehr benötigte Pakete löschen
```bash
apt -y autoremove
```

---

## PHP nach Upgrade starten
```bash
systemctl restart php8.3-fpm.service
```

---

## Konfiguration aktualisieren
Im letzten Schritt werden alle Konfigurationsdateien aktualisiert und bei Bedarf neu generiert.

### openITCOCKPIT Master
Wenn Sie das Update auf einem openITCOCKPIT Master System ausführen, nutzen Sie den folgenden Befehl:

```bash
openitcockpit-update --cc
```

### openITCOCKPIT Satellit
Auf einem openITCOCKPIT Satellit nutzen Sie den folgenden Befehl:

```bash
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
systemctl status php8.3-fpm.service
systemctl status statusengine_cleanup.timer
```

`systemctl --failed` darf keine Unit auflisten und der Cleanup Timer muss aus
`/usr/lib/systemd/system/statusengine_cleanup.timer` geladen werden.
