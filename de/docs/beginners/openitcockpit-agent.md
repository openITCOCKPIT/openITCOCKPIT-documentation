# Monitoring mit dem openITCOCKPIT Agent

Überwachen von grundlegenden Parametern eines Hosts sollte keine schwierige oder lästige Aufgabe sein.
Der [openITCOCKPIT Monitoring Agent](https://openitcockpit.io/download_agent/) ist für Windows, Linux und macOS
verfügbar und in der Lage Metriken wie CPU, Arbeitsspeicher, Festplattenauslastung, Netzwerkstatus, Temperaturen etc.
Out-of-the-box zu sammeln.

Damit der openITCOCKPIT Monitoring Agent anpassbar sowie erweiterbar ist, ist er zu 100 % mit der Nagios Plugin API
kompatibel. Daher ist keine zusätzliche Software wie NRPE oder check_by_ssh nötig, um Plugins auf dem Zielsystem
auszuführen.

Die Kommunikation ist standardmäßig verschlüsselt durch HTTPS.

## Herunterladen und Installieren des openITCOCKPIT Monitoring Agent

Bevor Sie anfangen, installieren Sie den openITCOCKPIT Monitoring Agenten auf dem gewünschten Zielsystem, dass Sie
überwachen möchten.

Um den Agenten herunterzuladen empfehlen wir Ihnen
die [offizielle Download Seite](https://openitcockpit.io/download_agent/)

Der Quellcode ist über das GitHub Repository verfügbar: :fontawesome-brands-github: [https://github.com/openITCOCKPIT/openitcockpit-agent-go](https://github.com/openITCOCKPIT/openitcockpit-agent-go)

## Überwachen eines Hosts mit dem openITCOCKPIT Monitoring Agent

Im Kontextmenü der Hosts wählen Sie die Option:fontawesome-solid-user-secret: openITCOCKPIT Agent Entdeckung

![select agent discovery](/images/select-agent-discovery.png)

Ein Wizard basierender Konfigurationsprozess wird Sie durch alle Schritte begleiten.

### Hauptunterschiede zwischen Pull und Push Modus

Im ersten Schritt müssen Sie entscheiden, ob Sie Ihren Host im Push oder Pull Modus überwachen möchten.

- Im **Pull** Modus verbindet sich der openITCOCKPIT **Server** regelmäßig via HTTPS auf dem Port `3333` **zu dem
  Agenten** und holt die Überprüfungsergebnisse ab
- im **Push** Modus verbindet sich der openITCOCKPIT Monitoring **Agent** regelmäßig und "Schiebt" seine
  Überprüfungsergebnisse via HTTPS auf dem Port 443 **zu dem** openITCOCKPIT **Server**. Perfekt, wenn Ihr Zielsystem
  hinter einer NAT ist.

## Pull Modus

Beide Modi sind einfach einzurichten. Für dieses Tutorial nutzen wir den **Pull Modus**. Klicken Sie hier für
den [Push Modus](#push-modus)

![push or pull](/images/agent-push-or-pull.png)

Der zweite Schritt ist grundsätzlich ein grafischer Konfigurationsgenerator, um die Konfigurationsdatei des
openITCOCKPIT Monitoring Agent zu modifizieren. Sie müssen nur das Betriebssystem auswählen, welches Sie überwachen
möchten und klicken auf die Schaltfläche "Weiter".

!!! info "Verbindungstyp: Auto-TLS"
    Es wird nachdrücklich empfohlen, Auto-TLS als Verbindungstyp auszuwählen. Dies sichert und verschlüsselt die Verbindung
    zwischen dem openITCOCKPIT Server und dem openITCOCKPIT Monitoring Agent automatisch. Mehr Informationen über die
    Sicherheit des openITCOCKPIT Monitoring Agent finden Sie in
    der [Dokumentation](https://github.com/openITCOCKPIT/openitcockpit-agent-go/wiki/Agent-Overview)

![pull config](/images/agent-basic-pull-configuration.png)

Im dritten Schritt wird Ihnen gezeigt, wo Sie den openITCOCKPIT Monitoring
Agent [herunterladen](https://openitcockpit.io/download_agent/) und die Konfigurationsdatei ablegen können.

Für dieses Tutorial können Sie mit der Standardkonfiguration fortfahren. Zum nächsten Schritt klicken Sie auf die
Schaltfläche "Weiter".

![agent install config](/images/agent-install-config.png)

Der openITCOCKPIT Server wird sich zu dem openITCOCKPIT Monitoring Agent auf dem Zielsystem verbinden und ein TLS
Zertifikatsaustausch vollziehen. Für jeden openITCOCKPIT Monitoring Agenten wird ein einzigartiges Zertifikat generiert.
Dieses Zertifikat wird für Authentifizierungs und Verschlüsselungszwecke benötigt.

Klicken Sie auf "Weiter" um fortzufahren.

![cert exchange](/images/certificate-exchange.png)

Das System wird grundlegende Health Metriken wie CPU, Arbeitsspeicher und SWAP standardmäßig sammeln. Zusätzlich dazu
können Sie weitere Prozesse und Dienste auswählen, die Sie überwachen möchten. Haben Sie die gewünschten Services
ausgewählt, klicken Sie auf "Fertig" um das openITCOCKPIT Monitoring Agent Setup abzuschließen.

![create services](/images/agent-create-services.png)

Der letzte Schritt erinnert Sie daran die Monitoring-Konfiguration zu aktualisieren. Bitte klicken
auf [Aktualisieren der Überwachungskonfiguration](../create-first-host/#aktualisieren-der-uberwachungskonfiguration)

![services create successfully](/images/agent-services-created-successfully.png)

Ein paar Sekunden später wird das Monitoring System die ausgewählten Services überwachen und Graphen generieren, wann
immer es möglich ist.

![agent services monitored](/images/agent-services-monitored.png)

## Bestimmen des Hoststatus (optional)

Standardmäßig wird openITCOCKPIT einen Ping zum Zielsystem senden, um den Hoststatus zu bestimmen. Anstelle eines Pings
ist es möglich die Ergebnisse des openITCOCKPIT Monitoring Agenten zum Bestimmen des Hoststatus zu verwenden. Für
weitere Informationen können Sie die Dokumentation
nutzen [https://github.com/openITCOCKPIT/openitcockpit-agent-go/wiki/Determining-the-host-status](https://github.com/openITCOCKPIT/openitcockpit-agent-go/wiki/Determining-the-host-status)

## Push Modus

Wählen Sie den Push Modus, um fortzufahren.

![agent push or pull use push](/images/agent-push-or-pull-use-push.png)

Der zweite Schritt ist grundsätzlich ein grafischer Konfigurationsgenerator, um die Konfigurationsdatei des
openITCOCKPIT Monitoring Agenten zu modifizieren. Sie müssen nur das Betriebssystem auswählen, welches Sie überwachen
möchten und klicken auf die Schaltfläche "Weiter".

Setzen Sie die öffentliche IP-Adresse oder FQDN Ihres openITCOCKPIT Servers im Feld `openITCOCKPIT Server Adresse` und
tragen den API-Key, welchen der Agent nutzen soll in das Feld `openITCOCKPIT API Schlüssel`.

Klicken Sie auf die Schaltfläche `Nächster`, um fortzufahren.

!!! danger "Sicherheitshinweis!"
    Es wird dringend empfohlen einen neuen Benutzer mit sehr wenigen Berechtigungen zu erstellen und einen API-Key für
    unprivilegierte Benutzer zu verwenden. Um Check Ergebnisse zu übertragen sind keine speziellen Berechtigungen über
    Benutzerrollen nötig.

![agent push config](/images/agent-basic-push-configuration.png)

Im dritten Schritt wird Ihnen gezeigt, wo Sie den openITCOCKPIT Monitoring
Agenten [herunterladen](https://openitcockpit.io/download_agent/) und die Konfigurationsdatei ablegen können.

Kopieren Sie die angezeigte Konfigurationsdatei an den angegebenen Pfad und starten Sie den openITCOCKPIT Monitoring
Agent Dienst neu. Die Kommandos und Dateipfade hängen vom genutzten Betriebssystem ab. Klicken Sie auf `Nächster`, um
fortzufahren.

![agent config push](/images/agent-install-config-push.png)

Jeder Agent sendet eine eindeutige Kennung an den openITCOCKPIT Server. Um unautorisierte Agenten daran zu hindern Check
Ergebnisse zu übertragen, müssen alle im Push Modus arbeitenden Agenten manuell zu einem Host zugewiesen werden. Klicken
Sie auf `Nächster`, um fortzufahren.

![host to agent mapping](/images/map-host-to-agent.png)

Das System wird grundlegende Health Metriken wie CPU, Arbeitsspeicher und SWAP standardmäßig sammeln. Zusätzlich dazu
können Sie weitere Prozesse und Dienste auswählen, die Sie überwachen möchten. Haben Sie die gewünschten Services
ausgewählt, klicken Sie auf "Fertig", um das openITCOCKPIT Monitoring Agent Setup abzuschließen.

!!! Info 
    Da der Agent im Push Modus arbeitet, ist es möglich, dass openITCOCKPIT bisher noch keine
    Daten empfangen hat und daher keine Services anzeigen kann. Sollte dies der Fall sein, so klicken Sie auf 
    :fontawesome-solid-arrow-left:, um auf den vorhergehenden Schritt zurückzukehren, warten 30 Sekunden und klicken
    anschließend wieder auf die Schaltfläche `Nächster`.

![create services push](/images/agent-create-services-push.png)

Der letzte Schritt erinnert Sie daran die Monitoring-Konfiguration zu aktualisieren. Bitte klicken Sie auf [Aktualisieren der Überwachungskonfiguration](../create-first-host/#aktualisieren-der-uberwachungskonfiguration)

![services created push export](/images/agent-services-created-successfully-push.png)

Ein paar Sekunden später wird das Monitoring System die ausgewählten Services überwachen und Graphen generieren, wann
immer es möglich ist.

![agent services monitored push](/images/agent-services-monitored-push.png)

## Bestimmen des Hoststatus (optional, aber empfohlen)

Standardmäßig wird openITCOCKPIT einen Ping zum Zielsystem senden, um den Hoststatus zu bestimmen. In den meisten Fällen
ist es nicht möglich einen Ping zum Zielsystem zu senden, wenn der Push Modus genutzt wird.

Bearbeiten Sie den Host und wählen die Hostvorlage `openITCOCKPIT Agent - Push` aus und speichern diesen ab. Vergessen
Sie nicht anschließend die Monitoring Engine Konfiguration zu aktualisieren (Export).

openITCOCKPIT wird nun den Timestamp der zuletzt empfangenen Nachricht des openITCOCKPIT Monitoring Agents auswerten, um
zu bestimmen, ob der Host verfügbar ist oder nicht.

Für weitere Informationen können Sie die Dokumentation
nutzen [https://github.com/openITCOCKPIT/openitcockpit-agent-go/wiki/Determining-the-host-status](https://github.com/openITCOCKPIT/openitcockpit-agent-go/wiki/Determining-the-host-status)

![agent push host status](/images/agent-push-host-status.png)
