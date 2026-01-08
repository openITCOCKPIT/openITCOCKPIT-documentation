# Verteiltes Monitoring und Satelliten <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

Das Distribute Modul ermöglicht ein verteiltes Monitoring mit Satellitensystemen, welche als autarke Einheit entferne Standorte überwachen können.
Dies erleichtert das Pflegen von Firewall-Regeln, da nur noch eine Verbindung zwischen dem openITCOCKPIT Monitoring Server
und den Satelliten bestehen muss, nicht jedoch zu den zu überwachenden Systemen.
Zusätzlich kann das verteilte Monitoring auch zur Lastverteilung genutzt werden.

Die Verwaltung der Satelliten Systeme und der zu überwachenden Hosts erfolgt zentral vom openITCOCKPIT Server.

Im Falle eines Verbindungsabbruches zwischen Satellite und openITCOCKPIT Server speichern die Satelliten die Prüfergebnisse zwischen.
Sobald die Verbindung wiederhergestellt ist, verarbeitet der openITCOCKPIT Server die gespeicherten Daten, um eine konsistente Historie
sicherzustellen.

openITCOCKPIT bietet eine spezielle und optionale Weboberfläche für Satelliten Systeme an.
Somit haben Administrator und Benutzer an entfernte Standorten ihre lokale IT immer im Blick, auch wenn die Verbindung
zum zentralen openITCOCKPIT Server unterbrochen ist.

Die Satellitensysteme werden über spezielle Pakete installiert und
überwachen ihre Systeme eigenständig. Je nach Synchronisationseinstellungen, werden die Ergebnisse an das Mastersystem (openITCOCKPIT) geschickt oder von diesem abgeholt.

![openITCOCKPIT Satellite Web Interface](/images/openitcockpit-sattelite-interface.png)

## Voraussetzung

Für die Nutzung des Distribute Modul ist eine Enterprise Lizenz nötig.

## Satelliten in openITCOCKPIT anlegen

Um einen Satelliten in openITCOCKPIT anzulegen, klicken Sie im Hauptmenü auf
<kbd><kbd>System</kbd> <i class="fa fa-arrow-right"></i> <kbd>Satelliten</kbd></kbd>
in der Satelliten Übersicht klicken Sie anschließend auf die Schaltfläche "Neu".

Anschließend wählen Sie einen Container aus, vergeben einen Namen für den Satelliten und tragen die IP-Adresse oder Hostname in das Feld "IP-Adresse" ein.

Satelliten können in drei verschiedenen Synchronisationsmethoden betrieben werden.

## NSTA

Für die Kommunikation zwischen Master und Satellite ist der Dienst `nsta` verantwortlich. Der Verbindungsstatus kann unter
<kbd><kbd>System</kbd> <i class="fa fa-arrow-right"></i> <kbd>Satelliten Status</kbd></kbd>
eingesehen werden.


![openITCOCKPIT Satellite Status](/images/openitcockpit-sattelite-status.png)

Das Logfile des NSTA kann über den Befehl `journalctl --follow -u nsta` eingesehen werden.

### Synchronisationsmethoden

#### HTTPS-Pull

Das Mastersystem ruft regelmäßig Prüfergebnisse vom Satelliten ab und pusht Konfigurationsänderungen.

Kommunikationsweg ausgehend: openITCOCKPIT Server stellt eine Verbindung zum Satelliten her.

Hier muss die IP-Adresse des Satelliten, sowie die weiteren Parameter des HTTPS Aufrufs angegeben werden. Zudem kann ausgewählt werden, ob das SSL Zertifikat überprüft wird und ob ein HTTP-Proxy genutzt werden soll.
Der Angezeigte API Schlüssel wir vom Mastersystem genutzt, um sich am Satellitensystem zu authentifizieren.

![openITCOCKPIT Satellite via HTTPS Pull](/images/satellites-https-pull.png)


Auf dem Satellitensystem wird die Kommunikation vom NSTA verwaltet.
Deshalb muss dort die Konfiguration `/opt/openitc/etc/nsta/nsta.ini` angepasst werden:
```ini
[nsta]
satellite-id=ADD_YOUR_SATELLITE_ID_HERE
api-key=ADD_YOUR_API_KEY_HERE
mode=https_pull
```

Um die Änderungen zu übernehmen, muss der NSTA Dienst neu gestartet werden.
```
systemctl restart nsta
```

Anschließend findet die Kommunikation über eine verschlüsselte HTTPS Verbindung statt.


#### HTTPS-Push

Das Satellitensystem überträgt die Prüfergebnisse an das Mastersystem und sucht regelmäßig nach Konfigurationsänderungen.

Kommunikationsweg eingehend: Satelliten stellt eine Verbindung zum openITCOCKPIT Server her.

Bei der Konfiguration muss hierfür lediglich ein API Schlüssel eingetragen werden.
Dieser wird vom Satellitensystem genutzt, um sich am Mastersystem zu authentifizieren.

![openITCOCKPIT Satellite via HTTPS Push](/images/satellites-https-push.png)


Auf dem Satellitensystem wird die Kommunikation vom NSTA verwaltet.
Deshalb muss dort die Konfiguration `/opt/openitc/etc/nsta/nsta.ini` angepasst werden:
```ini
[nsta]
mode=https_push
satellite-id=ADD_YOUR_SATELLITE_ID_HERE
api-key=ADD_YOUR_API_KEY_HERE
endpoint=https://demo.openitcockpit.io
insecure-https=true
system-metrics-interval=15
```

Um die Änderungen zu übernehmen, muss der NSTA Dienst neu gestartet werden.
```
systemctl restart nsta
```

Anschließend findet die Kommunikation über eine verschlüsselte HTTPS Verbindung statt.


#### SSH

Das Mastersystem erstellt einen SSH-Tunnel zum Satellitensystem, ruft die Prüfergebnisse ab und überträgt Konfigurationsänderungen.

Kommunikationsweg ausgehend: openITCOCKPIT Server stellt eine Verbindung zum Satelliten her.

Im SSH Modus wird ein Benutzername, Port sowie der Private Key Path für die Verbindung benötigt.
Der Austausch der SSH-Keys für den angegebenen Benutzer vom Mastersystem zum Satelliten muss im Vorfeld durchgeführt werden.

Zudem kann noch der Remote Port des auf dem Satelliten laufenden Gearman angegeben werden.

![openITCOCKPIT Satellite via SSH](/images/satellites-ssh.png)


Anschließend findet die Kommunikation über eine verschlüsselte SSH Verbindung statt.

Für alle Synchronisationsmethoden steht im letzten Schritt der Erstellung noch
die Möglichkeit zum Einstellen der Zeitzone sowie die Synchronisation der Systemzeit zur verfügung.

Wenn SSH zur Übertragung genutzt wird, wird der NSTA auf dem Satellitensystem nicht benötigt.


#### Alle Optionen

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | [Container](../container/) in dem der Satellit erstellt werden soll  |
| Satellitenname | :fontawesome-solid-xmark: | Name des zu erstellenden Satelliten |
| IP-Adresse | :fontawesome-solid-xmark: | IP-Adresse oder Hostname des Satelliten. Diese Adresse wird für die gesamte Kommunikation zwischen der Master-Instanz und dem Satellitensystem verwendet |
| Synchronisationsmethode | :fontawesome-solid-xmark: | [Synchronisationsmethode](#synchronisationsmethoden) die die Art der Datenübertragung bestimmt |
| Zeitzone | :fontawesome-solid-xmark: | Zeitzone des Satelliten |
| Zeitsynchronisation |  |  Legt fest, ob Sie die Systemuhr des Master-Servers mit dem Satellitensystem synchronisieren möchten. Hinweis: Es wird nicht empfohlen, diese Option zu aktivieren. Bitte verwenden Sie nach Möglichkeit einen NTP-Server.  |
| HTTPS PULL-Modus |
| URL | :fontawesome-solid-xmark: | Satellit URL |
| Überprüfe das Zertifikat |  | nur valide Zertifikate werden akzeptiert |
| Aktiviere Proxy |  | Bestimmt ob der weiter unten eingetragene Proxy für die verbindung mit dem Satellitensystem genutzt werden soll |
| Proxy URL |  | Proxy Server URL |
| API Schlüssel | :fontawesome-solid-xmark: | API Key Authentifizierung für den Satellit |
| Intervall |  | Zeitintervall in Sekunden, in welchem das Mastersystem die Prüfergebnisse aufnimmt |
| Timeout |  | Zeitlimit in Sekunden, das definiert, wann der Satellit als OFFLINE markiert werden soll. |
| HTTPS PUSH-Modus |
| API Schlüssel | :fontawesome-solid-xmark: | API Key Authentifizierung für den Satellit |
| Timeout |  | Zeitlimit in Sekunden, das definiert, wann der Satellit als OFFLINE markiert werden soll. |
| SSH |
| Anmelden | :fontawesome-solid-xmark: | Benutzer mit dem sich über SSH auf dem Satellitensystem angemeldet werden soll |
| Port | :fontawesome-solid-xmark: | SSH-Port des Remote-Computers. |
| PrivateKeyPath | :fontawesome-solid-xmark: | Wir verwenden einen Standardpfad zum privaten Schlüssel, wenn dieses Feld leer bleibt |
| RemotePort |  | Gearman-Port der Remote-Maschine. |

## Host auf einem Satelliten erstellen
Bei der Erstellung eines Hosts kann das Satellitensystem, welches die Prüfungen ausführen soll, aus einer Dropdown-Liste ausgewählt werden.
openITCOCKPIt verwaltet im Hintergrund alle nötigen Konfigurationsänderungen selbstständig.

Hosts können zu jedem Zeitpunkt vom Mastersystem auf einen Satelliten und zurück verschoben werden.


![](/images/host-satellite.png)

## State is no longer current

Das openITCOCKPIT Mastersystem führt in regelmäßigen Abständen einen sogenannten Freshness Check durch. Dabei prüft das System, ob alle
Satellitensysteme ihre Prüfergebnisse zu den erwarteten Zeitpunkten übermittelt haben.

Der Status "State is no longer current" ist in der Regel auf einen der folgenden Punkte zurückzuführen:
- Unterschiedliche Systemzeiten von Mastersystem und Satellit. NTP-Server nutzen oder Synchronisation der Systemzeit über NSTA aktivieren.
- Die Verbindung zwischen Mastersystem und Satellit ist unterbrochen
- Satellitensystem ist überlastet

## Satelliten Frontend aktivieren

Die Weboberfläche der Satellitensysteme ist optional und im standard nicht aktiviert. Zum Aktivieren müssen die folgenden zwei
Befehle auf dem Satelliten ausgeführt werden:
```
touch /opt/openitc/etc/frontend/enable_web_interface
/opt/openitc/frontend/UPDATE.sh
```

Im Anschluss kann der erste Benutzer erstellt werden.
```
sudo -u www-data /opt/openitc/frontend/bin/cake user --username admin --password admin1234
```

Alle weiteren Benutzer können dann über die Weboberfläche erstellt und verwaltet werden.

## Einstellungen

Einstellungen für den Satellit können in der Datei `/opt/openitc/frontend/config/interface.yml` vorgenommen werden. 

Hier finden sich Einstellungen zu dem Interface, Aufbewahrungsdauer, Perfdata und Docker.

Beispiel:

- Deaktivieren der Socal-Buttons auf der Login-Seite
```
show_link_in_login: 0
```
- Aufbewahrungsdauer Host Statehistory
```
age_host_statehistory: 90
```
