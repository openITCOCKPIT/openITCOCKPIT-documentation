
# Software-Inventar und Patch-Management <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

Das Software-Inventar und Patch-Management von openITCOCKPIT ermöglicht es Ihnen, installierte Software und verfügbare Updates auf Ihren überwachten Systemen im Blick zu behalten.
So stellen Sie sicher, dass Ihre Systeme aktuell und sicher sind.

Die Informationen werden vom [openITCOCKPIT Agent](https://openitcockpit.io/download_agent/) gesammelt und können über die openITCOCKPIT-Weboberfläche eingesehen und verwaltet werden.

Der Agent kann je nach Netzwerk-Setup und Anforderungen im Pull- oder Push-Modus betrieben werden.
Weitere Details zur Installation und Konfiguration finden Sie in der [Agenten-Dokumentation](/agent/overview/).

## Unterstützte Betriebssysteme

Die Software-Inventar-Funktion unterstützt eine Vielzahl von Betriebssystemen, darunter:

- **Linux**: Verschiedene Distributionen wie Ubuntu, Debian, Red Hat, AlmaLinux, Rocky Linux, SUSE, Arch Linux und mehr.
- **Windows**: Alle aktuellen Windows-Versionen, einschließlich Windows Server Editionen.
- **macOS**: Unterstützte Versionen von macOS.

Für detaillierte Informationen darüber, wie der Agent Software-Inventardaten oder verfügbare Updates sammelt, siehe die folgenden Abschnitte.

## Installiert der Agent Updates?
**Nein, der openITCOCKPIT Agent installiert keine Updates auf überwachten Systemen.**

Er sammelt lediglich Informationen über installierte Software und verfügbare Updates.
Die eigentliche Installation von Updates muss manuell oder über eine separate Patch-Management-Lösung erfolgen.

## Überwachung auf Updates
openITCOCKPIT bietet den Check `System Updates`, der Sie benachrichtigt, wenn Updates verfügbar sind.
Sicherheitsupdates führen immer zu einem Status `CRITICAL`, während reguläre Updates zu einem Status `WARNING` führen.

Je nach Anforderung können Sie den Check so konfigurieren, dass nur für Sicherheitsupdates oder für alle verfügbaren Updates gewarnt wird.

![Überwachung auf System-Updates](/images/software_inventory/openitcockpit_agent_software_updates_check.png)

## Software-Inventar-Ansicht

### Pro Host

Die Host-Detailansicht in openITCOCKPIT verfügt über einen eigenen Reiter "Software-Inventar", in dem Sie die installierte Software auf dem überwachten System einsehen können.

Für Linux-Systeme sehen Sie eine Liste aller installierten Pakete mit Version, Beschreibung und verfügbaren Updates.
![Linux Software-Inventar-Tab](/images/software_inventory/linux_details_view.png)

Bei Windows- und macOS-Systemen werden verfügbare Systemupdates und installierte Software (Apps) in zwei separaten Ansichten dargestellt.

![Windows Software-Inventar-Tab für Updates](/images/software_inventory/windows_updates_details_view.png)

![Windows Software-Inventar-Tab für Apps](/images/software_inventory/windows_apps_details_view.png)


### Patch-Status-Übersicht
Die Patch-Status-Übersicht bietet eine schnelle Zusammenfassung des Updatestatus aller überwachten Systeme.

Die Tabelle zeigt den Betriebssystemtyp, die Anzahl verfügbarer Updates, die Uptime und ob ein Neustart erforderlich ist.
Sie können außerdem auf die Anzahl der verfügbaren (Sicherheits-)Updates klicken, um eine Liste der betroffenen Pakete oder Updates zu erhalten.

![Patch-Status-Übersicht](/images/software_inventory/patch_status_overview.png)

### Paketübersicht

Für Linux-Systeme zeigt openITCOCKPIT eine Liste aller Pakete, die auf Ihren überwachten Systemen installiert sind.
So sehen Sie schnell, welche Pakete am häufigsten verwendet werden und können veraltete oder verwundbare Pakete identifizieren.

Durch Klicken auf den Paketnamen sehen Sie eine Liste aller Systeme, auf denen das Paket installiert ist, inklusive Version und verfügbarer Versionen.
Durch Klicken auf die Zahl in der Spalte `Installiert auf` erhalten Sie eine Liste aller Systeme, auf denen das Paket installiert ist.

![Paketübersicht für Linux-Systeme](/images/software_inventory/packages_overview_linux.png)

Für Windows- und macOS-Systeme gibt es eine ähnliche Übersicht für Systemupdates und installierte Software (Apps).
Die Tabelle enthält den Namen, die Microsoft Knowledge Base (KB) ID, die eindeutige Update-ID und ob es sich um ein Sicherheitsupdate handelt.
Durch Klicken auf die Zahl in der Spalte `Verfügbar auf` erhalten Sie eine Liste aller Systeme, die das Update benötigen.

![Update-Übersicht für Windows-Systeme](/images/software_inventory/windows_updates_overview.png)

Windows- und macOS-Apps werden in einer separaten Übersicht gelistet.
![App-Übersicht für macOS-Systeme](/images/software_inventory/macos_apps_overview.png)

## Agenten-Funktionen

Der openITCOCKPIT Agent sammelt detaillierte Informationen über installierte Pakete, installierte Software und verfügbare Sicherheitsupdates auf allen gängigen Betriebssystemen. Außerdem erkennt er, wenn ein Systemneustart erforderlich ist – ein wichtiger Schritt, um sicherzustellen, dass die neuesten Sicherheitsupdates vollständig installiert wurden.

### Linux


Auf Linux-Systemen sammelt der Agent eine vollständige Liste installierter Pakete, erkennt verfügbare Updates und hebt – sofern unterstützt – Sicherheitsupdates hervor.

| Paketmanager | Installierte Pakete | Verfügbare Updates | Sicherheitsupdates | Neustart erforderlich                                                                                                     |
|--------------|---------------------|--------------------|--------------------|--------------------------------------------------------------------------------------------------------------------------|
| `apt`        | ✅                  | ✅                 | ✅                 | ✅ [Methode](https://www.debian.org/doc/debian-policy/ch-opersys.html#signaling-that-a-reboot-is-required)                |
| `dnf`        | ✅                  | ✅                 | ✅                 | ✅ [Methode](https://dnf-plugins-core.readthedocs.io/en/latest/needs_restarting.html)                                     |
| `yum`        | ✅                  | ✅                 | ✅                 | ✅ [Methode](https://man7.org/linux/man-pages/man1/needs-restarting.1.html)                                               |
| `zypper`     | ✅                  | ✅                 | ✅                 | ✅ [Methode](https://support.scc.suse.com/s/kb/How-to-check-if-system-reboot-is-needed-after-patching?language=de_DE)     |
| `pacman`     | ✅                  | ✅                 | -                  | _Nicht unterstützt_                                                                                                      |
| `rpm`        | ✅                  | -                  | -                  | -                                                                                                                        |


### Windows

Auf Windows-Systemen werden nur Betriebssystem-Updates gemeldet, da es keinen einheitlichen Paketmanager gibt. Der Agent ermittelt Informationen über installierte Software und ob ein Neustart benötigt wird über die Windows-Registry.

| Verfügbare Windows-Updates                | Installierte Software | Neustart erforderlich |
|-------------------------------------------|----------------------|----------------------|
| Über PowerShell `Microsoft.Update.Session`| über Registry        | über Registry        |


### macOS

Auf macOS-Systemen werden nur Betriebssystem-Updates gemeldet, da es keinen Paketmanager gibt. Informationen über installierte Software werden mit `system_profiler` gesammelt. Die Erkennung eines benötigten Neustarts wird auf macOS nicht unterstützt.

| Verfügbare macOS-Updates | Installierte Software    | Neustart erforderlich |
|-------------------------|--------------------------|----------------------|
| ✅                      | über `system_profiler`   | _Nicht unterstützt_  |

## Datenerfassung

Die Daten werden vom openITCOCKPIT Agent gesammelt.
Die Konfigurationsoptionen für die Software-Inventar-Funktion finden Sie im Abschnitt `packagemanager` der Konfigurationsdatei des Agenten.

Standardmäßig wird das Erfassen des Software-Inventars alle 60 Minuten durchgeführt.

- Bei im Pull-Modus laufenden Agenten zieht der openITCOCKPIT Server die Daten per Cronjob vom Agenten ab.
- Bei im Push-Modus laufenden Agenten sendet der Agent die Daten in dem konfigurierten Intervall an den Server.

Beispielkonfiguration:

```ini

#########################
#   Software-Inventar   #
#########################

[packagemanager]

# Software-Inventar-Erfassung aktivieren
enabled = True

# Intervall in Minuten, wie oft das Software-Inventar erfasst werden soll
check-interval = 60

# Überprüfung auf verfügbare Paketupdates aktivieren
# Diese Option aktualisiert die Metadaten des Paketmanagers (z.B. apt-get update) und
# prüft, ob Updates für installierte Pakete verfügbar sind.
# Es werden KEINE UPDATES INSTALLIERT!
# Diese Option setzt voraus, dass der Paketmanager funktionsfähig ist.
# Das bedeutet, dass der Befehl apt-get update oder dnf --refresh fehlerfrei funktionieren muss.
# Hinweis: Wenn Ihr System einen Proxy-Server für den Internetzugang benötigt, stellen Sie sicher,
# dass die Proxy-Einstellungen für den verwendeten Paketmanager korrekt konfiguriert sind.
enable-update-check = True

# Maximale Länge der Paketbeschreibungen
# -1 = keine Begrenzung (vollständige Beschreibung, nicht empfohlen)
#  0 = Beschreibungen deaktivieren
# >0 = Länge auf angegebene Zeichenanzahl begrenzen
limit-description-length = 80
```

## Bekannte Einschränkungen

Das Sammeln von Software-Inventar-Informationen über openITCOCKPIT Satellitensysteme
wird derzeit nicht unterstützt. Bitte stellen Sie sicher, dass die überwachten Systeme direkt mit dem openITCOCKPIT Zentralsystem verbunden sind.
