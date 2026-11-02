# openITCOCKPIT aktualisieren

Updates von openITCOCKPIT werden über den Paketmanager der jeweiligen Distribution eingespielt.

Diese Seite beschreibt das Aktualisieren von openITCOCKPIT selbst - also zum Beispiel von Version 5.8 auf 5.9.
Für das Upgrade des Betriebssystems nutzen Sie die Anleitungen unter "Update", zum Beispiel
[Update von Debian Bookworm (12) auf Debian Trixie (13)](debian-bookworm-to-trixie.md).

!!! danger "Backup"
    Bevor Sie beginnen, stellen Sie sicher, dass Sie ein **funktionierendes Backup** Ihres Systems erstellt haben!

!!! warning "E-Mail Konfiguration"
    Sofern Änderungen an der E-Mail-Konfiguration vorgenommen wurden, sollte die Datei **/opt/openitc/frontend/config/email.php** vor einem Backup gesichert und danach wiederhergestellt werden.

Führen Sie alle Kommandos als `root` Benutzer aus.

## Ubuntu / Debian

Paketquellen aktualisieren

```bash
apt update
```

Update durchführen

```bash
apt -y full-upgrade
```

## Red Hat Enterprise Linux

!!! danger
    openITCOCKPIT erwartet, dass die Linux-Standard-Umask auf `022` eingestellt ist (Standard für die meisten Linux-Distributionen).
    Wenn Sie unsicher sind, ändern Sie die Umask auf `022`, bevor Sie mit dem Update fortfahren.

    ```bash
    umask 0022
    ```

Paketquellen aktualisieren

```bash
dnf --refresh check-update
```

Update durchführen

```bash
dnf update
```
