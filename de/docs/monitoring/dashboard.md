# Dashboard

Das Dashboard ist die Startseite in openITCOCKPIT.

Das Dashboard ist die Startseite von openITCOCKPIT und besteht im Standard aus nur einem <span class="badge badge-default">Default</span> Tab.

### Dashboard hinzufügen

Um neue Tabs hinzuzufügen, klickt man auf das <span class="badge badge-success">+</span> Symbol im oberen rechten Rand des Dashboards

![](/images/dashboards-newdashboard.png)

Dies öffnet folgendes Fenster:

![](/images/dashboards-newdashboardpopup.png)

Zum Erstellen eines leeren, neuen Tabs muss im oberen Bereich ein Name für den Tab angegeben werden und anschließend auf den <span class="badge badge-primary">Erstellen neuen Tab</span> Button geklickt werden.

Zum Erstellen eines Tabs aus einer Vorlage wählt man einen freigegebenen Tab aus der Liste und klickt anschließend auf <span class="badge badge-primary">Erstelle von geteiltem Tab</span>.

Erstellt man einen Tab aus einer Vorlage und an dieser Vorlage ändert sich etwas, erscheint beim nächsten Aufruf des Tabs folgender Dialog.

![](/images/dashboards-sharing-update.png)

Man kann nun auswählen, ob man seinen Tab aktualisieren möchte, oder auch nicht.

### Dashboard teilen

Es gibt in openITCOCKPIT die möglichkeit Tabs zu teilen. Dazu klickt man zuerst auf den nach unten zeigenden Pfeil (1) an einem Dashboard Tab und danach auf <span class="badge badge-default">Starte Teilen</span>.

Die geteilten Dashboards stehen dann anderen Benutzern in openITCOCKPIT zur Verfügung.

![](/images/dashboards-sharing.png)

Wenn ein Dashboard bereits geteilt ist, dann steht in der Auswahlliste <span class="badge badge-default">Stoppe Teilen</span>. Darüber kann das Teilen des Dashboard-Tabs wieder gestoppt werden.

### Dashboard Rotation

Eine Dashboard-Rotation bewirkt, dass alle vorhandenen Dashboard Tabs in einem vom Benutzer, zwischen 10 Sekunden und 15 minuten, festgelegten Intervall nacheinander angezeigt werden.

Im Zusammenspiel mit der Vollbildansicht der Dashboards kann dies nützlich sein, um openITCOCKPIT beispielsweise auf einem TV anzuzeigen.

### Dashboard löschen

Um ein Dashboard zu löschen, klicken Sie zuerst auf den nach unten zeigenden Pfeil (1) an einem Dashboard Tab und danach auf <span class="badge badge-danger">Löschen</span> (2).

![](/images/dashboards-delete.png)

### Widget hinzufügen

Um ein neues Widget auf einem Dashboard hinzuzufügen, klicken Sie auf die Schaltfläche <span class="badge badge-success">Widget hinzufügen</span>

![](/images/dashboards-addwidget.png)

Anschließend öffnet sich eine Auswahlliste mit allen verfügbaren Widgets.

Nach dem man das entsprechende Widget hinzugefügt hat, muss dies gegebenenfalls noch konfiguriert werden.

![](/images/dashboard-widgetconfig.png)

Nach dem Speichern der Widget-Konfiguration wird das Widget mit Inhalt angezeigt.

#### Widgets

##### Willkommen
![welcome widget](/images/dashboard-welcomewidget.png)

Zeigt eine die Gesamtanzahl, der für einen Benutzer sichtbaren, überwachten Hosts und Services an. Zudem wird die Benutzerzeitzone, openITCOCKPIT Version und die Edition angezeigt.

##### Übergeordnete Ausfälle
![parent outages widget](/images/dashboard-parentoutageswidget.png)

Zeigt eine Liste aller nicht erreichbaren verknüpften Eltern Objekte.

##### Host/Service Kreisdiagramm (180)
![hosts services piecharts](/images/dashboard-host-services-piecharts.png)

Zeigt (je nach Auswahl) halbes oder ganzes Tortendiagramm aller Hosts oder Services und deren Status. Beim Klick auf die Statusfarbe unter dem Diagramm öffnet sich eine Liste mit den Hosts oder Services im ausgewählten Status.

##### Ampel
![traffic light widget](/images/dashboard-trafficlightwidget.png)

Zeigt die Statusfarbe eines Services an

###### Konfiguration

Es muss ein Service ausgewählt werden, dessen Status angezeigt werden soll. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Geschwindigkeitsmesser (Tacho Widget)
![Tacho widget](/images/dashboard-tachowidget.png)

Zeigt den wert eines Performance-Datensatzes eines Services an. Schwellwerte werden zusätzlich farblich markiert.

###### Konfiguration

Es muss ein Service, sowie ein Performance-Datensatz ausgewählt werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.


##### Notiz
![notice widget](/images/dashboard-noticewidget.png)

Das Notiz-Widget kann Text, HTML oder Markdown anzeigen.

###### Konfiguration

Es kann Text, HTML oder Markdown in das Textfeld eingefügt werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Host/Service in Wartungszeit
![host service downtime widget](/images/dashboard-hostservicedowntimewidget.png)


Das Host bzw. Service in Wartungszeit Widget zeigt Host bzw. Services an, die sich in einer Wartungszeit befinden. 

###### Konfiguration

Über die Konfiguration besteht die möglichkeit nach Hosts bzw. Services und dem Wartungszeitkommentar zu filtern. Darüber hinaus können die anzuzeigenden Wartungszeiten über verschiedene Optionen ein- oder ausgeblendet werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.


##### Hoststatus/Servicestatus Liste
![host service status lists](/images/dashboard-hostservicestatuslists.png)

Zeigt eine filterbare Liste mit Hosts bzw. Services an. Diese Listen enthalten den Status, aktuelle Wartungszeiten, Bestätigungen, sowie seit wann der Status eingetreten ist und den Host- bzw. Serviceoutput. Die Liste kann in einem benutzerdefinierten Intervall automatisch scrollen.

###### Konfiguration

Host bzw. Service Status Listen können nach Hostname bzw Host und Servicename sowie nach Output gefiltert werden. Darüber hinaus stehen verschiedene Optionen, beispielsweise um nach dem Status, Wartungszeiten oder Statusbestätigungen zu filtern, zur Verfügung. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Hoststatus/Servicestatus Übersicht
![host servicestatus overview](/images/dashboard-hostservicestatusoverview.png)

Das Host- bzw. Servicestatusübersicht-Widget zeigt die Anzahl der Hosts bzw. Services in einem bestimmten Status (beispielsweise UP/OK) an.

###### Konfiguration

Die Host bzw. Servicestatus Übersicht zeigt immer nur die Anzahl der Hosts bzw. Services in dem gewählten Status an. Diese auswahl kann über die Konfiguration des Widgets getroffen werden. Zudem kann auch nach dem Host bzw. Host und Servicenamen gefiltert werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Host/Service Top Alerts
![host service top alerts](/images/server-Top-alerts.png)

Die Host bzw. Service Top Alerts Widgets zeigen die Benachrichtigungsalarme zu dem konfigurierten Status innerhalb des rückwirkenden konfiguriertem Zeitraums.
Es wird nach Anzahl und aktuellstem Datum gruppiert. Mit Anzahl ist hier die Anzahl der Alarme selbst und nicht die Anzahl verschickten Benachrichtigungen gemeint. Also wenn bei einem Alarm 20 Personen benachrichtigt wurden, wird nur 1 Alarm gezählt. Sonst verfälscht es die Anzeige der tatsächlichen Alarme.

###### Konfiguration  
Die Widgets können nach Status und zu betrachtrendem Zeitraum konfiguriert werden. 

##### Automatische Karte
![automap widget](/images/dashboard-automapwidget.png)

Das Widget zeigt [Automatischen Karte](../maps/#automatische-karte) an

###### Konfiguration

Die automatische Karte muss vorher über die [Automatischen Karten](../maps/#automatische-karte) erstellt werden. Danach kann eine Karte in der Widget Konfiguration ausgewählt werden. Zusätzlich hat man die Möglichkeit auszuwählen, wie viele Elemente auf einer `Seite im Widget dargestellt werden sollen. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Autoreport Übersicht
![Autoreport overview widget](/images/dashboard-autoreportoverviewwidget.png)

Das Widget zeigt eine Verfügbarkeitsanzeige eines zuvor erstellen [Autoreports](../../reporting/reporting/#autoreports-ce) an. 

###### Konfiguration

Das Widget setzt einen zuvor erstellten [Autoreports](../../reporting/reporting/#autoreports-ce) voraus. Dieser Report kann anschließend in der Konfigurationsoberfläche des Widgets ausgewählt werden. Zudem sind Optionen zur Anzeige der Verfügbarkeit, Logdaten sowie die dynamische Farbgestaltung verfügbar. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Grafana (automatisch generiert)

Das Widget zeigt automatisch generierte Grafana Dashboards an.

###### Konfiguration

Automatisch generierte Grafana Dashboards können über den Hostnamen in der Konfigurationsfläche des Widgets ausgewählt werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Grafana (benutzerdefiniert)
![grafana userdefined](/images/dashboard-grafanauserdefinedwidget.png)

Das Widget zeigt benutzerdefinierte [Grafana Dashboards](../graphing/#grafana) an.

###### Konfiguration

Benutzerdefinierte Grafana Dashboards müssen vorher über das [Grafana Modul](../graphing/#grafana) erstellt werden. Anschließend kann ein Dashboard über die Widget-Konfigurationsoberfläche ausgewählt werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Karte (MapModul)
![Map module widget](/images/dashboard-mapmodulewidget.png)

Das Karten Widget zeigt eine Karte, die über das [MapModul](../maps/#map-modul-ce) erstellt wurde, an. 

###### Konfiguration

Eine Karte muss vorher über das [MapModul](../maps/#map-modul-ce) erstellt werden. Anschließend kann die Karte über die Konfigurationsoberfläche des Widgets ausgewählt werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

##### Ereigniskorrelation
![evk widget](/images/dashboard-evkwidget.png)

Das Widget zeigt eine zuvor erstelle [Ereigniskorrelation](../eventcorrelation/#ereigniskorrelation-eventcorrelation-ce) an.

###### Konfiguration

Eine Ereigniskorrelation muss vorher über das [EventcorrelationModule](../eventcorrelation/#ereigniskorrelation-eventcorrelation-ce) erstellt werden. Anschließend kann die Ereigniskorrelation über die Konfigurationsoberfläche des Widgets ausgewählt werden. Zur Konfigurationsoberfläche des Widgets gelangt man über das Zahnradsymbol im oberen rechten Bereich des Widgets.

### Widget löschen

Um ein Widget zu löschen, klicken Sie einfach auf das <span class="badge badge-danger">x</span> Symbol des entsprechenden Widgets.

![delete widget](/images/dashboards-widgetdelete.png)


### Standard wiederherstellen

Um den Standard eines Dashboard Tabs wiederherzustellen, klicken Sie in der Liste zum Hinzufügen von Dashboard Widgets auf die Schaltfläche <span class="badge badge-default">Standard wiederherstellen</span>.

![restore default](/images/dashboard-restoredefault.png)
