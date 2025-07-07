# Benutzerdefinierte Checks definieren

Der openITCOCKPIT Monitoring Agent ist zu 100% kompatibel mit den
[Monitoring Plugins Development Guidelines](https://www.monitoring-plugins.org/doc/guidelines.html).
Daher können Sie alle Monitoring-Plugins verwenden, die mit Naemon, Nagios, Shinken, Icinga 1 und Sensu funktionieren.

Die Idee hinter benutzerdefinierten Checks ist es, eine einfache Methode bereitzustellen, um eine tiefere Überwachung spezialisierter Dienste wie Datenbankserver usw. zu ermöglichen.

## Pfad zur customchecks.ini festlegen
Standardmäßig sucht der Agent nach einer Datei `customchecks.ini` im [Standardverzeichnis](/agent/debugging/#paths).

Sie können den Speicherort in der `config.ini` ändern:

```ini
# Remote Plugin Execution
# Pfad zur Konfigurationsdatei, in der benutzerdefinierte Checks definiert werden können
# Kommentar, um den Standardwert zu verwenden
#
# Linux: /etc/openitcockpit-agent/customchecks.ini
# Windows: C:\Program Files\it-novum\openitcockpit-agent\customchecks.ini
# macOS: /Applications/openitcockpit-agent/customchecks.ini
customchecks = /etc/openitcockpit-agent/customchecks.ini
```

## Benutzerdefinierte Checks definieren
Die [Standard-customchecks.ini](https://github.com/openITCOCKPIT/openitcockpit-agent-go/blob/main/example/customchecks_example.ini) bietet eine große Vielfalt an Beispielen, wie benutzerdefinierte Checks unter Linux, macOS und Windows definiert werden können. Sie deckt Bash-Skripte, Powershell-Skripte und Binärdateien ab.

## Benutzerdefinierte Checks zur Überwachung hinzufügen
Öffnen Sie die openITCOCKPIT-Weboberfläche und navigieren Sie zu `openITCOCKPIT Agent -> Agents Overview -> Pull / Push` und wählen Sie `Edit` aus dem Dropdown-Menü. Befolgen Sie die Anweisungen und wählen Sie alle benutzerdefinierten Checks im Schritt `Create services` aus.
