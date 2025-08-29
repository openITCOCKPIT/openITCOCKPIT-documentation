# Hosts und Services

## Hostvorlagen

Hostvorlagen bilden die Grundvoraussetzung für Hosts. Wird ein Host erstellt, so muss dort eine Hostvorlage
angegeben werden. Alle Werte, die in der Hostvorlage definiert werden, werden dann automatisch an den Host vererbt,
können aber bei Bedarf einzeln überschrieben werden.

### Hostvorlage erstellen

Um eine Hostvorlage zu erstellen, klicken Sie in der Hostvorlagen Übersicht auf die Schaltfläche "Neu".

| Feld | Erforderlich | Beschreibung |
|---|---|---|
|Basiskonfiguration|
| Container | :fontawesome-solid-xmark: | [Container](../container/#container) in dem die Vorlage erstellt werden soll |
| Vorlagenname | :fontawesome-solid-xmark: | Name der Vorlage |
| Vorlagentyp | :fontawesome-solid-xmark: | Bestimmt den [Typ](#vorlagentypen) der Vorlage |
| Beschreibung |  | Beschreibung der Hostvorlage. Wird als Beschreibung des Hosts weitervererbt |
| Hostgruppen |  | Zuweisung ein oder mehrerer [Hostgruppen](#hostgruppen) |
| Stichworte |  | Tags |
| Priorität |  | Priorität zum filtern in Listen |
| Prüfungskonfiguration |
| Prüfungszeitraum | :fontawesome-solid-xmark: | Definition, in welchem [Zeitraum](../timeperiods/) Prüfungen stattfinden sollen |
| Aktiviere aktive Prüfungen |  | Bestimmt ob ein Host Aktiv oder Passiv geprüft werden soll |
| Prüfungskommando | :fontawesome-solid-xmark: | Das [Kommando](../commands/), welches zur Überprüfung des Hosts ausgeführt werden soll |
| Prüfungsintervall | :fontawesome-solid-xmark: | Definiert in welchem Intervall Prüfungen stattfinden sollen |
| Wiederholungsintervall | :fontawesome-solid-xmark: | Definiert den Wartezeitraum bevor eine neue Prüfung stattfindet, nachdem ein nicht UP status erreicht wurde |
| Max. Anzahl der Prüfversuche | :fontawesome-solid-xmark: | Bestimmt die Anzahl der Prüfversuche, bevor ein Host in einen Hard State über geht |
| Benachrichtigungskonfiguration |
| Benachrichtigungszeitraum | :fontawesome-solid-xmark: | Bestimmt den Zeitraum in dem für einen Host Benachrichtigungen versendet werden. |
| Benachrichtigungsintervall | :fontawesome-solid-xmark: | Definiert den Zeitlichen Abstand von Benachrichtigungen, die zu diesem Host versendet werden |
| Kontakte | :fontawesome-solid-xmark: | Ein oder mehrere Kontakte die Benachrichtigungen zu diesem Host erhalten |
| Kontaktgruppen | :fontawesome-solid-xmark: | Ein oder mehrere Kontaktgruppen die Benachrichtigungen zu diesem Host erhalten |
| Optionen zu Hostbenachrichtigungen |  | Definiert die Status die Erreicht werden müssen, damit benachrichtigt wird |
| Diverse Konfiguration |
| Host URL |  | Host URL |
| Notizen |  | Notizen zur Hostvorlage |
| Flattererkennung aktiviert |  | ([Flap detection](#flap-detection)) Erkennung ob sich ein Host status in kurzer Zeit oft ändert |
| Host-Makro-Konfiguration | | |
| Prometheus-Exporters |
| Exporters | | [Prometheus Exporter](#prometheus-exporters) |

#### Vorlagentypen

Es gibt in openITCOCKPIT mehrere Hostvorlagen typen. Diese unterscheiden eine Vorlage, ob sie entweder für einen 
generischen Host oder zum Beispiel für einen Ereigniskorrelations-Host sind.

Ein normaler Host wird i.d.R. immer als generischer Host angelegt.

Ein Prüfzeitraum ist ebenfalls eine Pflichtangabe ebenso wie ein Prüfungskommando. Ein Standardprüfungskommando für 
einen Host ist beispielsweise "check-host-alive". Für dieses Kommando können hier auch direkt Argumente übergeben 
werden.

anschließend werden verschiedene Prüfungsintervalle gesetzt.

#### Intervalle

Damit Benachrichtigung zu einem Host status gesendet werden können, wird in der Host-Konfiguration mit einem 
Prüfungs-und-Wiederholungsintervall sowie einer maximalen Anzahl an Prüfversuchen gearbeitet. Diese Einstellungen 
beeinflussen die Zeit, wann eine Benachrichtigung gesendet wird. Beispielsweise ist als Standardwert ein 
Prüfungsintervall von 1 Stunden, ein Wiederholungsintervall von 1 Minute und eine maximale Anzahl von Prüfversuchen von 
3 angegeben. Dies kann im schlimmsten fall dazu führen, dass erst nach 1 Stunden und 2 Minuten eine Benachrichtigung 
gesendet wird.

Ebenso wie bei dem Prüfungszeitraum muss auch ein Benachrichtigungszeitraum angegeben werden sowie mindestens ein 
Kontakt oder mindestens eine Kontaktgruppe.

#### Flap detection

Flapping ("flattern") tritt auf, wenn sich ein Host oder Service status in kurzer Zeit oft ändert. Dies kann 
verschiedene Gründe haben wie Beispielsweise Netzwerkprobleme, problematische Services oder Konfigurationsprobleme. 
Ist diese Option aktiviert, so wird, wenn ein Flapping des Status erkannt wurde, eine "flapping start" Benachrichtigung
versendet und weitere Benachrichtigungen unterdrückt. Ist kein Flapping des Status mehr vorhanden, wird eine 
"flapping stop" Benachrichtigung versendet und weitere Benachrichtigungen zu dem Host werden wieder normal versendet.

#### Prometheus Exporters

Zur [Überwachung des Hosts mit Prometheus](../../monitoring/prometheus/#uberwachen-eines-hosts-mit-prometheus-in-openitcockpit), 
wählen Sie hier Ihren Prometheus Exporter aus.

## Servicevorlagen

Servicevorlagen bilden die Grundvoraussetzung für Services. Wird ein Service erstellt, so muss dort eine Servicevorlage
angegeben werden. Alle Werte, die in der Servicevorlage definiert werden, werden dann automatisch an den Service vererbt,
können aber bei Bedarf einzeln überschrieben werden.

### Servicevorlage erstellen

Um eine Servicevorlage zu erstellen, klicken Sie in der Servicevorlagen Übersicht auf die Schaltfläche "Neu".

| Feld | Erforderlich | Beschreibung |
|---|---|---|
|Basiskonfiguration|
| Container | :fontawesome-solid-xmark: | [Container](../container/#container) in dem die Vorlage erstellt werden soll |
| Vorlagenname | :fontawesome-solid-xmark: | Name der Vorlage |
| Vorlagentyp | :fontawesome-solid-xmark: | Bestimmt den [Typ](#vorlagentypen) der Vorlage |
| Servicename | :fontawesome-solid-xmark: | Standardname des Services wenn aus der Vorlage ein Service erstellt wird |
| Beschreibung |  | Beschreibung der Servicevorlage. Wird als Beschreibung des Services weitervererbt |
| Servicegruppen |  | Zuweisung ein oder mehrerer [Servicegruppen](#servicegruppen) |
| Stichworte |  | Tags |
| Priorität |  | Priorität zum filtern in Listen |
| Prüfungskonfiguration |
| Prüfungszeitraum | :fontawesome-solid-xmark: | Definition, in welchem [Zeitraum](../timeperiods/) Prüfungen stattfinden sollen |
| Aktiviere aktive Prüfungen |  | Bestimmt ob der Service Aktiv oder Passiv geprüft werden soll |
| Prüfungskommando | :fontawesome-solid-xmark: | Das [Kommando](../commands/), welches zur Überprüfung des Services ausgeführt werden soll |
| Prüfungsintervall | :fontawesome-solid-xmark: | Definiert in welchem Intervall Prüfungen stattfinden sollen |
| Wiederholungsintervall | :fontawesome-solid-xmark: | Definiert den Wartezeitraum bevor eine neue Prüfung stattfindet, nachdem ein nicht UP status erreicht wurde |
| Max. Anzahl der Prüfversuche | :fontawesome-solid-xmark: | Bestimmt die Anzahl der Prüfversuche, bevor ein Service in einen Hard State über geht |
| Benachrichtigungskonfiguration |
| Benachrichtigungszeitraum | :fontawesome-solid-xmark: | Bestimmt den Zeitraum in dem für einen Service Benachrichtigungen versendet werden. |
| Benachrichtigungsintervall | :fontawesome-solid-xmark: | Definiert den Zeitlichen Abstand von Benachrichtigungen, die zu diesem Service versendet werden |
| Kontakte | :fontawesome-solid-xmark: | Ein oder mehrere Kontakte die Benachrichtigungen zu diesem Service erhalten |
| Kontaktgruppen | :fontawesome-solid-xmark: | Ein oder mehrere Kontaktgruppen die Benachrichtigungen zu diesem Service erhalten |
| Optionen zu Servicebenachrichtigungen |  | Definiert die Status die Erreicht werden müssen, damit benachrichtigt wird |
| Diverse Konfiguration |
| Service URL |  | Service URL |
| Notizen |  | Notizen zur Servicevorlage |
| Flattererkennung aktiviert |  | ([Flap detection](#flap-detection)) Erkennung ob sich ein Service status in kurzer Zeit oft ändert |
| Status flüchtig |  | Erzwingt Benachrichtigungen für jedes Nicht-OK Prüfergebnis |
| Event Handler Konfiguration |
| Ereignishandler | | Eventhandler Konfiguration des Service |
| Service-Makro-Konfiguration | | |

#### Vorlagentypen

Es gibt in openITCOCKPIT mehrere Servicevorlagen typen. Diese unterscheiden eine Vorlage, ob sie entweder für einen 
generischen Service, Ereigniskorrelationen, Checkmk, Prometheus oder den openITCOCKPIT Agenten sind.

Services, welche über ein Modul oder den Agenten erzeugt werden, sind immer von dem entsprechendem Vorlagentyp.

##### Generische Vorlagen

Vorlage für einen normalen Service. Dies ist der Standard Service typ in openITCOCKPIT

##### EVK Vorlagen

Vorlage für einen Service der Ereigniskorrelation. Verfügbar über EventcorrelationModule

##### Checkmk Vorlagen

Vorlage für einen Checkmk Service. Verfügbar über CheckmkModule

##### Prometheus Vorlagen

Vorlage für einen Prometheus Service. Verfügbar über PrometheusModule

##### Agent Vorlagen

Vorlage für einen openITCOCKPIT Agent Service.

Ein Prüfzeitraum ist ebenfalls eine Pflichtangabe ebenso wie ein Prüfungskommando.

anschließend werden verschiedene Prüfungsintervalle gesetzt.

#### Intervalle

Damit Benachrichtigung zu einem Service status gesendet werden können, wird in der Servicekonfiguration mit einem 
Prüfung-und-Wiederholungsintervall sowie einer maximalen Anzahl an Prüfversuchen gearbeitet. Diese Einstellungen 
beeinflussen die Zeit, wann eine Benachrichtigung gesendet wird. Beispielsweise ist als Standardwert ein 
Prüfungsintervall von 1 Minute, ein Wiederholungsintervall von 1 Minute und eine maximale Anzahl von Prüfversuchen von 3
angegeben. Dies kann im schlimmsten fall dazu führen, dass nach 3 Minuten eine Benachrichtigung gesendet wird.

Ebenso wie bei dem Püfungszeitraum muss auch ein Benachrichtigungszeitraum angegeben werden. Im gegensatz zu den 
Hostvorlagen muss hier kein Kontakt oder Kontaktgruppe hinterlegt werden.

## Servicevorlagengruppen

Servicevorlagengruppen sind Sammlungen von Servicevorlagen, die entweder selbst erstellt werden können oder aber über 
installierbare Module verfügbar sind. Über Module verfügbare Servicevorlagengruppen sind zum jeweiligen Themengebiet 
passend zusammengefasste Servicevorlagen.

Servicevorlagengruppen können zu einem Host oder einer Hostgruppe zugewiesen werden. Das bedeutet, dass für alle 
Servicevorlagen einer Servicevorlagengruppe die entsprechenden Services auf dem zugewiesenen Host oder Hostgruppe 
rstellt wird.

### Servicevorlagengruppe erstellen

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | [Container](../container/#container) in dem die Servicevorlagengruppe erstellt werden soll  |
| Name | :fontawesome-solid-xmark: | Name der Servicevorlagengruppe |
| Beschreibung |  | Beschreibung der Servicevorlagengruppe |
| Servicevorlage | :fontawesome-solid-xmark: | Die [Servicevorlagen](#servicevorlagen) die zur Servicevorlagengruppe hinzugefügt werden sollen |

### Servicevorlagengruppen zuweisen

Es gibt in openITCOCKPIT drei verschiedene Möglichkeiten Servicevorlagengruppen zuzuweisen.

![](/images/servicetemplategroups-allocate.png)

#### Zuweisen zu Host

Hier wird die aktuelle Servicevorlagengruppe zu einem einzelnen Host zugewiesen. Beim Auswählen des Hosts werden alle zu
erstellenden Services aufgelistet und können auch über die Auswahlbox abgewählt werden.

Sollte ein Service dieser Servicevorlagengruppe bereits auf dem Zielhost existieren, so wird dieser standardmäßig nicht 
zusätzlich erstellt, es sei denn man markiert diesen wieder in der Liste.

![](/images/servicetemplategroups-allocatetohost.png)

#### Einer Hostgruppe zuweisen

Hier wird die aktuelle Servicevorlage zu den Hosts einer Hostgruppe zugewiesen. Beim Auswählen der Hostgruppe werden 
alle zugehörigen Hosts sowie die zu erstellenden Services für jeden einzelnen Host aufgelistet. Es besteht ebenso die 
möglichkeit einzelnen Services abzuwählen.

Sollte ein Service dieser Servicevorlagengruppe bereits auf einem der Hosts existieren, so wird dieser standardmäßig
nicht zusätzlich erstellt, es sei denn man markiert diesen wieder in der Liste.

#### Zuordnen zur passenden Hostgruppe

"Zuordnen zur passenden Hostgruppe" erstellt Services auf den Hosts einer Hostgruppe die denselben Namen trägt. Der 
Name der Hostgruppe muss gleich der Name der Servicevorlagengruppe sein. Hier hat man nicht mehr die Möglichkeit die 
Services an und abzuwählen wie bei den anderen zwei Methoden.


## Hosts

### Host erstellen

Um einen Host zu erstellen, klicken Sie in der Hostübersicht zunächst auf die Schaltfläche "Neu". Im Sich öffnenden
Formular wählen Sie zunächst einen Container und eine Hostvorlage, von dem der neue Host abgeleitet werden soll, aus. 
Danach erscheinen alle weiteren Felder, die für den Host relevant sind. 

!!! danger
    Bitte beachten Sie, dass ein nachträgliches Ändern des Containers für einen Host **nicht möglich** ist!

Sie können anschließend einen Host Namen und eine Host-Adresse vergeben, oder aber Sie vergeben eine Host-Adresse und 
lassen den Hostnamen über die DNS-Suche automatisch vervollständigen.

Alle von der Hostvorlage vererbten Werte können bei Bedarf für den zu erstellenden Host überschrieben werden.
Möchten Sie die Werte der vorlage wiederherstellen, siehe
[Host oder Service Feld auf Standardwert zurücksetzen](#host-oder-service-feld-auf-standardwert-zurucksetzen)

Beim Abspeichern haben Sie die möglichkeit direkt neue Services zum Host anzulegen. Diese können entweder über den 
openITCOCKPIT Agent, Checkmk oder den Klassischen weg des Manuellen erstellens erzeugt werden.


| Feld | Erforderlich | Beschreibung |
|---|---|---|
|Basiskonfiguration|
| Container | :fontawesome-solid-xmark: | [Container](../container/#container) in dem der Host erstellt werden soll |
| Geteilte Container |  | [Container](../container/#container) in dem der Host zusätzlich sichtbar sein soll |
| Hostvorlage | :fontawesome-solid-xmark: | [Hostvorlage](#hostvorlagen) von der der Host abgeleitet werden soll |
| Host Name | :fontawesome-solid-xmark: | Name des Hosts |
| DNS-Suche |  | Falls aktiviert, wird versucht den Host Namen oder Host Adresse aufzulösen |
| Host Adresse | :fontawesome-solid-xmark: | IP Adresse oder FQDN des Hosts |
| Beschreibung |  | Beschreibung der Hostvorlage. Wird als Beschreibung des Hosts weitervererbt |
| Hostgruppen |  | Zuweisung ein oder mehrerer [Hostgruppen](#hostgruppen) |
| Eltern-Host |  | Parent Host Beziehung |
| Stichworte |  | Tags |
| Priorität |  | Priorität zum filtern in Listen |
| Satellit |  | Verfügbar wenn DistributeModule installiert ist. Auswahl des Satelliten |
| Prüfungskonfiguration |
| Prüfungszeitraum | :fontawesome-solid-xmark: | Definition, in welchem [Zeitraum](../timeperiods/) Prüfungen stattfinden sollen |
| Aktiviere aktive Prüfungen |  | Bestimmt ob ein Host Aktiv oder Passiv geprüft werden soll |
| Prüfungskommando | :fontawesome-solid-xmark: | Das [Kommando](../commands/), welches zur Überprüfung des Hosts ausgeführt werden soll |
| Prüfungsintervall | :fontawesome-solid-xmark: | Definiert in welchem Intervall Prüfungen stattfinden sollen. Siehe [Intervalle](#intervalle) |
| Wiederholungsintervall | :fontawesome-solid-xmark: | Definiert den Wartezeitraum bevor eine neue Prüfung stattfindet, nachdem ein nicht UP status erreicht wurde. Siehe [Intervalle](#intervalle) |
| Max. Anzahl der Prüfversuche | :fontawesome-solid-xmark: | Bestimmt die Anzahl der Prüfversuche, bevor ein Host in einen Hard State über geht. Siehe [Intervalle](#intervalle) |
| Benachrichtigungskonfiguration |
| Benachrichtigungszeitraum | :fontawesome-solid-xmark: | Bestimmt den Zeitraum in dem für einen Host Benachrichtigungen versendet werden. |
| Benachrichtigungsintervall | :fontawesome-solid-xmark: | Definiert den Zeitlichen Abstand von Benachrichtigungen, die zu diesem Host versendet werden |
| Kontakte | :fontawesome-solid-xmark: | Ein oder mehrere Kontakte die Benachrichtigungen zu diesem Host erhalten |
| Kontaktgruppen | :fontawesome-solid-xmark: | Ein oder mehrere Kontaktgruppen die Benachrichtigungen zu diesem Host erhalten |
| Optionen zu Hostbenachrichtigungen |  | Definiert die Status die Erreicht werden müssen, damit benachrichtigt wird |
| Diverse Konfiguration |
| Host URL |  | Host URL |
| Notizen |  | Notizen zur Hostvorlage |
| Flattererkennung aktiviert |  | ([Flap detection](#flap-detection)) Erkennung ob sich ein Host status in kurzer Zeit oft ändert |
| Host-Makro-Konfiguration | | |
| Prometheus-Exporters |
| Exporters | | [Prometheus Exporter](#prometheus-exporters) |


#### Geteilte Container

Über die geteilten Container ist es möglich Hosts in anderen Containern "sichtbar" zu machen. Dies ist nützlich um 
Benutzern welche keine Berechtigung auf den ursprünglichen Container des Hosts haben, trotzdem zugang zum Host zu geben.
Diese Option steht zudem auch in der Host-Übersicht unter der Host bearbeitungsoption "Teilen" zur verfügung.

#### Intervalle

Damit eine Benachrichtigung zu einem Host status gesendet werden kann, wird in der Host-Konfiguration mit einem 
Prüfung-und-Wiederholungsintervall sowie einer maximalen Anzahl an Prüfversuchen gearbeitet. Diese Einstellungen 
beeinflussen die Zeit, wann eine Benachrichtigung gesendet wird. Beispielsweise ist bei der default host vorlage ein 
Prüfungsintervall von 2 Stunden, ein Wiederholungsintervall von 1 Minute und eine maximale Anzahl von Prüfversuchen von 
3 angegeben. Dies kann im schlimmsten fall dazu führen, dass erst nach 2 Stunden und 2 Minuten eine Benachrichtigung 
gesendet wird.


#### Flap detection

Flapping ("flattern") tritt auf, wenn sich ein Host oder Service status in kurzer Zeit oft ändert. Dies kann 
verschiedene Gründe haben wie Beispielsweise Netzwerkprobleme, problematische Services oder Konfigurationsprobleme. Ist 
diese Option aktiviert, so wird, wenn ein Flapping des Status erkannt wurde, eine "flapping start" Benachrichtigung 
versendet und weitere Benachrichtigungen unterdrückt. Ist kein Flapping des Status mehr vorhanden, wird eine 
"flapping stop" Benachrichtigung versendet und weitere Benachrichtigungen zu dem Host werden wieder normal versendet.


#### Prometheus Exporters

Zur [Überwachung des Hosts mit Prometheus](../../monitoring/prometheus/#uberwachen-eines-hosts-mit-prometheus-in-openitcockpit), wählen Sie hier Ihren Prometheus Exporter aus.



## Services

### Service erstellen

Um einen Service zu erstellen, klicken Sie in der Serviceübersicht zunächst auf die Schaltfläche "Neu". Im sich 
öffnenden Formular wählen Sie als Erstes den Ziel-Host aus, auf dem der Service erstellt werden soll. Anschließend 
wählen Sie eine Servicevorlage aus. Danach erscheinen alle weiteren Felder, die für den Service relevant sind.  

Alle von der Servicevorlage vererbten Werte können bei Bedarf für den zu erstellenden Service überschrieben werden.
Möchten Sie die Werte der vorlage wiederherstellen, siehe 
[Host oder Service Feld auf Standardwert zurücksetzen](#host-oder-service-feld-auf-standardwert-zurucksetzen)  


| Feld | Erforderlich | Beschreibung |
|---|---|---|
|Basiskonfiguration|
| Host | :fontawesome-solid-xmark: | Der [Host](#hosts) auf dem der Service angelegt werden soll |
| Servicevorlage | :fontawesome-solid-xmark: | Die [Servicevorlage](#servicevorlagen) von dem der Service abgeleitet werden soll |
| Servicename | :fontawesome-solid-xmark: | Name des anzulegenden Service |
| Beschreibung |  | Beschreibung des Services |
| Servicegruppen |  | Zuweisung ein oder mehrerer [Servicegruppen](#servicegruppen) |
| Stichworte |  | Tags |
| Priorität |  | Priorität zum filtern in Listen |
| Prüfungskonfiguration |
| Prüfungszeitraum | :fontawesome-solid-xmark: | Definition, in welchem [Zeitraum](../timeperiods/) Prüfungen stattfinden sollen |
| Aktiviere aktive Prüfungen |  | Bestimmt ob der Service Aktiv oder Passiv geprüft werden soll |
| Prüfungskommando | :fontawesome-solid-xmark: | Das [Kommando](../commands/), welches zur Überprüfung des Services ausgeführt werden soll |
| Prüfungsintervall | :fontawesome-solid-xmark: | Definiert in welchem Intervall Prüfungen stattfinden sollen. Siehe [Intervalle](#intervalle) |
| Wiederholungsintervall | :fontawesome-solid-xmark: | Definiert den Wartezeitraum bevor eine neue Prüfung stattfindet, nachdem ein nicht UP status erreicht wurde. Siehe [Intervalle](#intervalle) |
| Max. Anzahl der Prüfversuche | :fontawesome-solid-xmark: | Bestimmt die Anzahl der Prüfversuche, bevor ein Service in einen Hard State über geht. Siehe [Intervalle](#intervalle) |
| Benachrichtigungskonfiguration |
| Benachrichtigungszeitraum | :fontawesome-solid-xmark: | Bestimmt den [Zeitraum](../timeperiods/) in dem für einen Service Benachrichtigungen versendet werden. |
| Benachrichtigungsintervall | :fontawesome-solid-xmark: | Definiert den Zeitlichen Abstand von Benachrichtigungen, die zu diesem Service versendet werden |
| Vererbung deaktivieren |  | Deaktiviert die vererbung von Kontakten und Kontaktgruppen. Diese können dann für diesen Service einzeln gesetzt werden |
| Kontakte | :fontawesome-solid-xmark: | Ein oder mehrere Kontakte die Benachrichtigungen zu diesem Service erhalten |
| Kontaktgruppen | :fontawesome-solid-xmark: | Ein oder mehrere Kontaktgruppen die Benachrichtigungen zu diesem Service erhalten |
| Optionen zu Servicebenachrichtigungen |  | Definiert die Status die Erreicht werden müssen, damit benachrichtigt wird |
| Diverse Konfiguration |
| Service URL |  | Service URL |
| Notizen |  | Notizen zur Servicevorlage |
| Flattererkennung aktiviert |  | ([Flap detection](#flap-detection)) Erkennung ob sich ein Service status in kurzer Zeit oft ändert |
| Status flüchtig |  | Erzwingt Benachrichtigungen für jedes Nicht-OK Prüfergebnis |
| Event Handler Konfiguration |
| Ereignishandler | | Eventhandler Konfiguration des Service |
| Service-Makro-Konfiguration | | |

#### Intervalle

Damit eine Benachrichtigung zu einem Service status gesendet werden kann, wird in der Servicekonfiguration mit einem Prüfung-und-Wiederholungsintervall sowie einer maximalen Anzahl an Prüfversuchen gearbeitet. Diese Einstellungen beeinflussen die Zeit, wann eine Benachrichtigung gesendet wird. Beispielsweise ist bei der `CHECK_PING` vorlage ein Prüfungsintervall von 5 Minuten, ein Wiederholungsintervall von 1 Minute und eine maximale Anzahl von Prüfversuchen von 3 angegeben. Dies kann im schlimmsten fall dazu führen, dass erst nach 7 Minuten eine Benachrichtigung gesendet wird.

#### Benachrichtigungen

Die Benachrichtigungen für einen Service verhalten sich genau wie die Benachrichtigungen für einen Host


#### Flap detection

Flapping ("flattern") tritt auf, wenn sich ein Host oder Service status in kurzer Zeit oft ändert. Dies kann verschiedene Gründe haben wie Beispielsweise Netzwerkprobleme, problematische Services oder Konfigurationsprobleme. Ist diese Option aktiviert, so wird, wenn ein Flapping des Status erkannt wurde, eine "flapping start" Benachrichtigung versendet und weitere Benachrichtigungen unterdrückt. Ist kein Flapping des Status mehr vorhanden, wird eine "flapping stop" Benachrichtigung versendet und weitere Benachrichtigungen zu dem Host werden wieder normal versendet.

## Host oder Service Feld auf Standardwert zurücksetzen
Hosts und Services erben Ihre werte immer von einer Host-oder-Servicevorlage. All diese Werte können im Host oder 
Service Formular überschrieben werden.

Von der Host-oder-Servicevorlage geerbte werte werden mit einer grünen Schaltfläche hinter dem Eingabefeld dargestellt.
In diesem Fall stimmen die werte mit dem der Vorlage überein. 

Ist der ein vererbter Wert überschrieben worden, wird die Schaltfläche rot dargestellt. Eine wiederherstellung mit dem
Wert der Vorlage ist möglich, indem Sie auf die rote Schaltfläche (1) hinter dem Eingabefeld klicken.

![restore value from template](/images/restorevaluefromtemplate.png)

## Host und Service erstellung über Import Modul

### Host-Standardeinstellungen

Host Standardeinstellungen definieren beispielsweise welcher Container und Dienste den importierten Hosts zugewiesen werden sollen. Dies ist abhängig von der Import-Quelle.

![](/images/importmodule-hostdefaults.png)

Zunächst muss ein Container ausgewählt werden, in den die Daten importiert werden sollen und vergeben einen Namen für die Standardeinstellung.

Anschließend setzen Sie die Einstellungen, die den importierten Hosts automatisch zugewiesen werden sollen.

Dies betrifft die Hostvorlage, geteilte Container und ob die Hosts auf dem Mastersystem oder auf einem Satelliten erstellt werden sollen.

Zusätzlich haben Sie die Möglichkeit Servicevorlagengruppen-Übereinstimmungen zu tätigen.

Dazu wählen Sie zuerst das Feld zu Übereinstimmung aus. Dort können Sie zwischen Host Name, Beschreibung, Adresse und Software auswählen.

Danach geben Sie den regulären Ausdruck an, der mit dem Zuvor ausgewählten Feld übereinstimmen muss.

Anschließend geben Sie die gewünschte Servicevorlagengruppe an.

### Importer

Ein Importer stellt die Grundlage für das Importieren von Hosts. Hier wird die Datenquelle sowie die Konfiguration der 
Datenquellenzuordnung definiert. Die Voraussetzung für einen Importer sind Host-Standardeinstellungen. Diese müssen vor 
dem Erstellen des Importers erstellt werden.

Als Datenquelle folgende zur verfügung:

###### CSV mit Header

Hier hat die CSV Datei, die man Importieren möchte einen Header. Das bedeutet, dass die Spalten in der Tabelle mit 
Überschriften gekennzeichnet ist. Pflichtvoraussetzung für den Import ist hier ein Trennzeichen, eindeutige Kennung, 
Hostname und Host Adresse.

![](/images/importmopdule-csvwithheader.png)

###### CSV ohne Header

Der Unterschied zwischen einer CSV mit Header und einer ohne Header besteht darin, dass die Spalten bei einer CSV ohne 
Header nicht mit überschriften versehen sind. Hier muss also mit der Nummerierung der Spalten gearbeitet werden.

![](/images/importmodule-csvwithoutheader.png)

A = 0, B = 1, C = 2, D = 3

##### Zuweisung von Host-Standardeinstellungen

Die Host-Standardeinstellungen müssen bei der Erstellung des Importers gesetzt werden. Dies Sorgt dafür, dass den 
importierten Hosts Standardeinstellungen zugewiesen werden.

![](/images/importmodule-editimporter.png)

### Importierte Host

![](/images/importmodule-importhostoverview.png)

In der Liste werden alle neuen oder bereits in das Monitoring aufgenommenen Host angezeigt. 
Alle bevorstehende Änderungen für Services, falls welche vorhanden sind, werden entsprechend angezeigt. 
Die Vollständigkeit der Einträge werden mit verschiedenen Wettersymbolen angezeigt. 
Die Daten können über das Editieren des zu importierenden Hosts können jederzeit ergänzt werden. 
Falls bestimmt Host nicht in das Monitoring aufgenommen werden sollen, können manuell gelöscht werden. 
Bei der Synchronisierung mit dem Monitoring werden alle Host, die alle benötigen Felder besitzen, inklusive 
dazugehörigen Services in die Konfigurationstabelle aufgenommen. Nun muss nur noch exportiert werden und alle
Konfigurationsobjekte werden überwacht.

Im oberen Bereich unter dem Punkt "Import Starten" werden alle auf dem System verfügbaren Importer aufgelistet. Nach dem
Klicken auf einen dieser Importers öffnet sich das passende Modal. Im unteren Beispiel ist das ein CSV Importer.

![](/images/importmodule-uploadcsv.png)


## Hostgruppen

### Hostgruppe erstellen

Um eine Hostgruppe zu erstellen, klicken Sie zunächst auf die Schaltfläche "Neu" in der Hostgruppen Übersicht.

Dort wählen Sie einen Container aus und vergeben einen Namen für die Hostgruppe.

Um Hosts einer Hostgruppe hinzuzufügen, haben Sie in diesem Formular zwei möglichkeiten.

Die erste ist das gezielte hinzufügen von einzelnen Hosts. Dazu wählen Sie die entsprechenden Hosts aus der Liste 
"Hosts" aus.

Die zweite möglichkeit besteht darin, Hosts über ihr Hostvorlage hinzuzufügen. Dabei werden alle Hosts die von den 
gewählten Hostvorlagen abgeleitet sind automatisch in die Hostgruppe hinzugefügt.

Danach Speichert man und die Hostgruppe ist fertig erstellt.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | [Container](../container/#container) in dem die Hostgruppe erstellt werden soll  |
| Name | :fontawesome-solid-xmark: | Name der Hostgruppe |
| Beschreibung |  | Beschreibung der Hostgruppe |
| Hostgruppen URL |  | URL der Hostgruppe |
| Stichworte |  | Tags |
| Hosts |  | [Hosts](#hosts) die zur Hostgruppe hinzugefügt werden sollen |
| Hostvorlagen |  | Die [Hostvorlagen](#hostvorlagen) die zur Hostgruppe hinzugefügt werden sollen |

### Erweiterte Ansicht

Um zur erweiterten Ansicht einer Hostgruppe zu kommen, klicken Sie in der Host-Übersicht auf den Pfeil nach unten neben dem Zahnradsymbol. Dort wählen Sie die "Erweiterte Ansicht".

Danach erscheint eine Übersichtsseite, die alle Hosts der gewählten Hostgruppe enthält.

Sie haben dort die möglichkeit verschiedene Aktionen zu tätigen wie zum beispiel die Prüfzeit zurückzusetzen, geplante Wartungszeiten zu erstellen, Hoststatus zu bestätigen oder Benachrichtigungen zu aktivieren / deaktivieren.

Beim klick auf das "+" Symbol eines Hosts in der Liste öffnet sich eine erweitere Ansicht, die die Services des Hosts, sowie die Gesamtstatus derer enthält.

Wenn das SLA Modul installiert ist, dann wird ein weiterer Tab namens "SLA Hosts Status" angezeigt, welcher eine [Übersichtsseite](/reporting/sla/#sla-host-status-ubersicht-fur-hostgruppen) anzeigt, die alle Hosts der Hostgruppe mit ihrem aktuellen SLA-Verfügbarkeitsstatus in Form einer Heatmap anzeigt. 


## Servicegruppen

### Servicegruppe erstellen

Analog zu den Hostgruppen werden Servicegruppen über die Schaltfläche "Neu" in der Servicegruppen übersicht erstellt.

Dort wählt man einen Container aus und vergibt einen Namen für die Servicegruppe.

Um Services einer Servicegruppe hinzuzufügen, haben Sie in diesem Formular zwei möglichkeiten:

Die erste ist das gezielte hinzufügen von einzelnen Services. Dazu wählen Sie die entsprechenden Hosts aus der Liste "Services" aus.

Die zweite Möglichkeit besteht darin, Services über ihr Servicevorlage hinzuzufügen. Dabei werden alle Services die von den gewählten Servicevorlagen abgeleitet sind automatisch in die Servicegruppe hinzugefügt.

Danach Speichert man und die Servicegruppe ist fertig erstellt.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | [Container](../container/#container) in dem die Servicegruppe erstellt werden soll  |
| Name | :fontawesome-solid-xmark: | Name der Servicegruppe |
| Beschreibung |  | Beschreibung der Servicegruppe |
| Servicegruppen URL |  | URL der Servicegruppe |
| Stichworte |  | Tags |
| Services |  | [Services](#services) die zur Hostgruppe hinzugefügt werden sollen |
| Servicevorlage |  | Die [Servicevorlagen](#servicevorlagen) die zur Servicegruppe hinzugefügt werden sollen |

### Erweiterte Ansicht

Um zur erweiterten Ansicht einer Servicegruppe zu kommen, klicken Sie in der Serviceübersicht auf den Pfeil nach unten 
neben dem Zahnradsymbol. Dort wählen Sie die "Erweiterte Ansicht".

Danach erscheint eine Übersichtsseite, die alle Hosts der gewählten Hostgruppe enthält.

Sie haben dort die möglichkeit verschiedene Aktionen zu tätigen wie zum beispiel die Prüfzeit zurückzusetzen, geplante
Wartungszeiten zu erstellen, Servicestatus zu bestätigen oder Benachrichtigungen zu aktivieren / deaktivieren.


## Parent-Child Beziehungen

Die Monitoring Engine ist in der Lage zu bestimmen, ob ein Host in einem NICHT VERFÜGBAR (DOWN) oder NICHT ERREICHBAR 
(UNREACHABLE) Status ist.
Diese Status sind sehr verschieden und können dabei helfen, einer schnellen bestimmung des (Netzwerk-)Problems 
beizutragen.

### Parent-Child Beziehungen definieren

Damit die Monitoring Engine in der Lage ist zwischen NICHT VERFÜGBAR und NICHT ERREICHBAR zu unterscheiden, muss 
definiert werden, wie die Hosts untereinander verbunden sind. Dazu muss der Pfad, den die Datenpakete, von der 
Monitoring Engine ausgehend nehmen, verfolgt werden. Jedes Switch, Router oder Server, den das Datenpaket dabei 
passiert, wird dabei als "Hop" bezeichnet. Jeder "Hop" muss als Parent-Child Beziehung definiert werden.


Eine Parent-Child beziehung in openITCOCKPIT zu definieren ist dabei sehr einfach. Ausgehend davon, dass alle Hosts 
(Switche, Router, Server etc.), die auf dem Weg zum Zielhost dazwischen sind, bereits im Monitoring aufgenommen worden 
sind, wird die Beziehung in der Host Konfiguration eingetragen. Dazu editieren Sie ihren gewünschten Host und tragen den
Entsprechenden Parent Host im Feld `Eltern-Host` ein. 

![parent host definition](/images/hosts-parenthost.png)


Beispiel:

![parent-child-allup](/images/parent-child-all-up.png)

Die Webserver 01-03 stehen hinter einem Switch. Fällt der Switch aus bedeutet dies nicht, dass die Webserver auch ausgefallen 
sind. Ohne Parent-Child Beziehung sind alle Webserver nun in einem NICHT VERFÜGBAR Status, da der Weg zu diesen Hosts 
durch das ausgefallenen Switch (NICHT VERFÜGBAR) blockiert ist.

Ohne Parent-Child Beziehung:
![no parent child relation](/images/no-parent-child-all-down.png)

Bei einer Parent-Child Beziehung werden die Webserver nun als NICHT ERREICHBAR angezeigt, da die Monitoring Engine die
Webserver nicht erreichen kann. Das Switch hingegen verbleibt im Status NICHT VERFÜGBAR.

Mit Parent-Child Beziehung:
![with parent child relation](/images/with-parent-child-unreachable.png)

 
