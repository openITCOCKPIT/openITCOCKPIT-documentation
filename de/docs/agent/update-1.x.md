# Update von Agent 1.x auf 3.x

Diese Dokumentation beschreibt das empfohlene Vorgehen, um den openITCOCKPIT Monitoring Agent von Version 1.x (Python-Agent, EOL) auf Version 3.x (Go-Agent) zu aktualisieren.

Aufgrund umfangreicher technischer Änderungen und Verbesserungen verläuft das Update von Version 1.x auf 3.x nicht so nahtlos, wie Sie es aus dem openITCOCKPIT-Ökosystem gewohnt sind. Die meisten Dienste von Agenten, die im _Pull-Modus_ laufen, sollten weiterhin funktionieren. Einige Dienste wie die QEMU-Überwachung wurden ersetzt. Andere, wie die Unterstützung für Lüfter, wurden entfernt.

Agenten, die im _Push-Modus_ laufen, müssen dem entsprechenden Host manuell erneut zugewiesen werden.

Wir bitten um Ihr Verständnis.


## Voraussetzungen
- openITCOCKPIT >= 4.2

## Erforderliche Konfigurationsänderungen
Kommentieren Sie alle leeren Werte wie `certfile =`, `autossl-csr-file =`, `auth =` und so weiter in `config.cnf` und `customchecks.cnf` aus.

Benennen Sie außerdem `customchecks.cfg` in `customchecks.ini` um oder kommentieren Sie die Zeile aus, damit der Agent den plattformspezifischen Standardpfad verwendet.
```ini
customchecks = /etc/openitcockpit-agent/customchecks.ini
```

## Pull-Modus
openITCOCKPIT aktualisiert Ihre bestehende Konfiguration für den openITCOCKPIT Monitoring Agent 3.x automatisch. Da einige Checks geändert oder entfernt wurden, sollten Sie nach Diensten im Status Unknown Ausschau halten.

1. Stellen Sie sicher, dass auf Ihrem openITCOCKPIT Monitoring Server openITCOCKPIT in Version 4.2 oder neuer läuft
2. Aktualisieren Sie den openITCOCKPIT Monitoring Agent anhand der [Update-Anleitung](#update-anleitung)
3. Aktualisieren Sie die Monitoring-Konfiguration

![Monitoring-Konfiguration aktualisieren](/images/openITCOCKPIT-Refresh-Monitoring-Config.png)

### Dienste im Status Unknown beheben

Werfen Sie zunächst einen Blick auf die [Breaking Changes](#breaking-changes). Einige Dienste müssen nur leicht angepasst werden. Andere müssen möglicherweise neu erstellt werden:
1. Öffnen Sie das Dropdown-Menü des Hosts und klicken Sie auf "openITCOCKPIT Agent discovery", um den Assistenten zu starten
2. Folgen Sie den Schritten und fügen Sie alle Ihre Dienste erneut hinzu.


## Push-Modus
Für die Identifizierung und Autorisierung von Agenten, die im Push-Modus laufen, wurde eine neue Authentifizierungsmethode eingeführt. Diese Änderung erfordert, dass Agenten ihren entsprechenden Hosts erneut zugewiesen werden.

1. Stellen Sie sicher, dass auf Ihrem openITCOCKPIT Monitoring Server openITCOCKPIT in Version 4.2 oder neuer läuft
2. Aktualisieren Sie den openITCOCKPIT Monitoring Agent anhand der [Update-Anleitung](#update-anleitung)
3. Starten Sie den openITCOCKPIT Monitoring Agent auf dem Zielsystem.

Die Logdatei des Agenten sollte nun regelmäßig die folgende Zeile wiederholen:
```
time="2021-02-26T08:29:03Z" level=error msg="Push Client: could not send state to server:  Invalid credentials or host not found"
```

Das bedeutet, dass der Agent einem Host zugewiesen werden muss. (In Agent 1.x wurde dieser Vorgang als _trusted_ bezeichnet)

4. Agent einem Host zuweisen
Öffnen Sie die openITCOCKPIT Weboberfläche und navigieren Sie zu `openITCOCKPIT Agent -> Agents Overview -> Push`. Sie erhalten eine Liste aller Agenten im Push-Modus, die Ihren openITCOCKPIT Server kontaktiert haben.

Wählen Sie den Agenten aus und wählen Sie `Assign to host` aus dem Dropdown-Menü.
![Agent einem Host zuweisen](/images/agent/assign_to_host.jpg)

5. Wählen Sie den entsprechenden Host aus der Dropdown-Liste und fahren Sie fort
![Host auswählen](/images/agent/select_host.jpg)

Es wird außerdem empfohlen, die Agent-Konfiguration zu aktualisieren, während Sie den Assistenten durchlaufen.

6. Prüfen Sie, ob Sie den richtigen Agenten ausgewählt haben. Sie können ihn bei Bedarf ändern.
![Auf korrekten Agenten prüfen](/images/agent/select_agent.jpg)

7. Aktualisieren Sie die Monitoring-Konfiguration, um die Änderungen anzuwenden.

![Monitoring-Konfiguration aktualisieren](/images/agent/refresh_config.jpg)


8. Die meisten Dienste sollten nun wieder funktionieren. Werfen Sie einen Blick auf die [Breaking Changes](#breaking-changes). Einige Dienste müssen nur leicht angepasst werden. Andere müssen möglicherweise neu erstellt werden

![Dienste mit neuen Ergebnissen](/images/agent/push_agent_services.png)


## Update-Anleitung
Der Update-Prozess unterscheidet sich je nach Betriebssystem und von Linux-Distribution zu Linux-Distribution. Bitte folgen Sie den Anweisungen sorgfältig.

### Debian und Ubuntu
Laden Sie das aktuelle Paket `openitcockpit-agent_3.x.x_amd64.deb` von der [Releases-Seite](https://github.com/openITCOCKPIT/openitcockpit-agent-go/releases) herunter und installieren Sie das Paket mit apt.
```
apt-get install ./openitcockpit-agent_3.x.x_amd64.deb
```

apt fragt Sie, ob Ihre aktuellen Konfigurationsdateien `/etc/openitcockpit-agent/config.ini` und `/etc/openitcockpit-agent/customchecks.ini` beibehalten werden sollen. Bestätigen Sie mit `N` oder `O`, um Ihre aktuelle Konfiguration zu behalten.

Denken Sie daran, die [erforderlichen Konfigurationsänderungen](#erforderliche-konfigurationsanderungen) anzuwenden. Starten Sie anschließend den Agenten neu
```
systemctl restart openitcockpit-agent
```

### Red Hat Linux / CentOS / openSUSE
Laden Sie das aktuelle Paket `openitcockpit-agent-3.x.x-1.x86_64.rpm` von der [Releases-Seite](https://github.com/openITCOCKPIT/openitcockpit-agent-go/releases) herunter.

#### Alten Agenten deinstallieren
```
cp /etc/openitcockpit-agent/config.cnf /etc/openitcockpit-agent/config.cnf.save
cp /etc/openitcockpit-agent/customchecks.cnf /etc/openitcockpit-agent/customchecks.cnf.save

rpm -e openitcockpit-agent
```

#### Neuen Agenten installieren
```
rpm -i openitcockpit-agent-3.x.x-x.x86_64.rpm

mv /etc/openitcockpit-agent/config.cnf.save /etc/openitcockpit-agent/config.ini
mv /etc/openitcockpit-agent/customchecks.cnf.save /etc/openitcockpit-agent/customchecks.ini

systemctl restart openitcockpit-agent
```

Denken Sie daran, die [erforderlichen Konfigurationsänderungen](#erforderliche-konfigurationsanderungen) anzuwenden.

### Arch Linux
Laden Sie das aktuelle Paket `openitcockpit-agent-3.x.x-1-x86_64.pkg.tar.zst` von der [Releases-Seite](https://github.com/openITCOCKPIT/openitcockpit-agent-go/releases) herunter.

#### Alten Agenten deinstallieren
```
cp /etc/openitcockpit-agent/config.cnf /etc/openitcockpit-agent/config.cnf.save
cp /etc/openitcockpit-agent/customchecks.cnf /etc/openitcockpit-agent/customchecks.cnf.save

pacman -R openitcockpit-agent
```

#### Neuen Agenten installieren
```
pacman -U openitcockpit-agent-3.x.x-x-x86_64.pkg.tar.zst

mv /etc/openitcockpit-agent/config.cnf.save /etc/openitcockpit-agent/config.ini
mv /etc/openitcockpit-agent/customchecks.cnf.save /etc/openitcockpit-agent/customchecks.ini

systemctl restart openitcockpit-agent
```

Denken Sie daran, die [erforderlichen Konfigurationsänderungen](#erforderliche-konfigurationsanderungen) anzuwenden.

### Windows
Laden Sie das aktuelle Paket `openitcockpit-agent-3.x.x-amd64.msi` von der [Releases-Seite](https://github.com/openITCOCKPIT/openitcockpit-agent-go/releases) herunter.

Führen Sie einen Doppelklick auf die Datei aus, um den grafischen Installer zu starten. Das MSI deinstalliert automatisch alle älteren Versionen.

Alte Konfiguration übernehmen

1. Stoppen Sie den Dienst `openITCOCKPITAgent`
2. Öffnen Sie `C:\Program Files\it-novum\openitcockpit-agent` mit dem Windows Explorer
3. Löschen Sie die Standarddateien `config.ini` und `customchecks.ini`
4. Benennen Sie die Datei `config.cnf` in `config.ini` und `customchecks.cnf` in `customchecks.ini` um.
5. Denken Sie daran, die [erforderlichen Konfigurationsänderungen](#erforderliche-konfigurationsanderungen) anzuwenden.
6. Starten Sie den Dienst `openITCOCKPITAgent`


### macOS

#### Alten Agenten deinstallieren

Laden Sie das aktuelle Paket `openitcockpit-agent-uninstaller-3.x.x-darwin-amd64.pkg` von der [Releases-Seite](https://github.com/openITCOCKPIT/openitcockpit-agent-go/releases) herunter.

Führen Sie einen Doppelklick auf die Datei aus, um den grafischen Deinstaller zu starten.

Wenn Sie es bevorzugen, können Sie auch die CLI verwenden:
```
sudo installer -pkg openitcockpit-agent-uninstaller-3.x.x-darwin-amd64.pkg -target / -verbose
```

#### Neuen Agenten installieren

Laden Sie das aktuelle Paket `openitcockpit-agent-3.x.x-darwin-amd64.pkg` von der [Releases-Seite](https://github.com/openITCOCKPIT/openitcockpit-agent-go/releases) herunter.

Führen Sie einen Doppelklick auf die Datei aus, um den grafischen Installer zu starten.

Wenn Sie es bevorzugen, können Sie auch die CLI verwenden:
```
sudo installer -pkg openitcockpit-agent-3.x.x-darwin-amd64.pkg -target / -verbose
```

Denken Sie daran, die [erforderlichen Konfigurationsänderungen](#erforderliche-konfigurationsanderungen) anzuwenden und den Agenten anschließend neu zu starten.
```
sudo su
/bin/launchctl stop com.it-novum.openitcockpit.agent

/bin/launchctl start com.it-novum.openitcockpit.agent
```


### Breaking Changes

* Die Standard-Dateiendung der Konfigurationsdateien wurde von `.cnf` auf `.ini` geändert, um eine Syntaxhervorhebung in den meisten Editoren zu ermöglichen und das Bearbeiten per Doppelklick unter Windows zu unterstützen.


#### Breaking Checks

Die folgenden Checks weisen Breaking Changes auf und müssen manuell angepasst oder mit dem neuen Assistenten neu erstellt werden.


##### Linux / macOS
* Sensoren-bezogene Checks wurden neu implementiert.
  - Es wird empfohlen, die alten Sensoren-bezogenen Dienste zu löschen und sie über den Assistenten neu zu erstellen
  - Die Unterstützung für Lüfter wurde entfernt
* QEMU wurde durch _libvirt_ ersetzt. Alle QEMU-bezogenen Dienste müssen gelöscht werden. Lesen Sie dazu [wie Sie die Libvirt-Unterstützung aktivieren](../build-binary/#libvirt-unterstutzung-aktivieren-nur-linux) und erstellen Sie die Dienste über den Assistenten neu
* Die Docker-Checks verwenden nun die Docker-API und müssen daher über den Assistenten neu erstellt werden. Außerdem ist Docker jetzt auch für Windows verfügbar.

##### Windows
* System Load / CPU Load wurde unter Windows entfernt
* Laufwerksbuchstaben ohne abschließenden Backslash [#1062](https://github.com/openITCOCKPIT/openITCOCKPIT/issues/1062)
  - Um das Problem zu beheben, bearbeiten Sie den Dienst und entfernen Sie den abschließenden Backslash aus dem Argument `Mountpoint`. Beispiel: `C:\` zu `C:`
* Windows Event Log Checks
  - Das Windows Event Log wurde neu implementiert. Es wird empfohlen, die alten Windows Event Log-bezogenen Dienste zu löschen und sie über den Assistenten neu zu erstellen
* Windows Services - Der eindeutige `Service name` wird nun verwendet, um zu ermitteln, ob ein Dienst läuft oder nicht. Agent 1.x verwendete den `Path to executable`.
  - Um das Problem zu beheben, bearbeiten Sie den Dienst und setzen Sie den _Service name_ für das Argument `Match`.
![Windows Service Name](/images/agent/windows_service_name.png)
