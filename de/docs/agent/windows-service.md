# Windows-Dienstkonfiguration

Einige Einstellungen können nicht über `config.ini` konfiguriert werden, sondern müssen als CLI-Parameter übergeben werden. Unter Windows läuft der Agent normalerweise als Windows-Dienst. Sie können die folgenden Parameter über die Windows-Registrierung festlegen.

Pfad: `HKEY_LOCAL_MACHINE\SOFTWARE\it-novum\InstalledProducts\openitcockpit-agent`

Dort können Sie die folgenden zusätzlichen Konfigurationsschlüssel hinzufügen. Alle Schlüssel müssen vom Typ Zeichenfolge (`String Value` / `Zeichenfolge`) sein, auch wenn die Werte numerisch sind!

| Schlüssel         | Standardwert               | Mögliche Werte            |
|-------------------|----------------------------|---------------------------|
| InstallLocation   |                            | **Niemals ändern**        |
| ConfigurationPath | InstallLocation/config.cnf | Jeder gültige Pfad        |
| LogPath           | InstallLocation/agent.log  | Jeder gültige Pfad        |
| LogRotate         | 3                          | 0 - N (0 == deaktivieren) |
| Verbose           | 0                          | 0 oder 1                  |
| Debug             | 0                          | 0 oder 1                  |

openITCOCKPIT-Agenten, die vor Version 3.6.0 installiert wurden, verwenden den Registrierungspfad `HKEY_LOCAL_MACHINE\SOFTWARE\it-novum\InstalledProducts\openitcockpit-agent`.