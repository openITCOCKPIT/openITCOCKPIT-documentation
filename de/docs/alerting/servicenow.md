# ServiceNow <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## Voraussetzungen

- openitcockpit-module-servicenow
- ServiceNow Instanz (London)

## Einrichtung

### ServiceNow Benutzer anlegen

Um das ServiceNow Modul mit einer ServiceNow (London) Instanz zu verbinden, muss ein ServiceNow Benutzer angelegt
werden.

![Screenshot: ServiceNow Benutzer anlegen](/images/servicenow-usersmenu.png)

Die Angabe folgender Parameter ist nötig:

- User ID: openitcockpit
- First Name: openITCOCKPIT
- Time zone: (wie im openITCOCKPIT System)
- Active: (true)
- Passwort

Der Benutzer sollte **keinen Nachnamen** haben und die User ID sowie der Vorname sollten keine Leerzeichen 
(Sonderzeichen) enthalten!

Nachdem der Benutzer gespeichert wurde, muss dieser erneut editiert werden.

Dem Benutzer muss (am Ende der Seite) über Roles → Edit die neue Role 'incident\_manager' hinzugefügt werden.

Danach muss die Role über **Save** gespeichert und der Benutzer über **Update** aktualisiert werden.

![Screenshot: ServiceNow Benutzer anlegen](/images/servicenow-userrolesedit.png)

![Screenshot: ServiceNow Benutzer anlegen](/images/servicenow-userrolesedit2.png)

### ServiceNow Benutzerdefinierte Incident Übersicht konfigurieren

Um URLs zu Hosts und Services aus openITCOCKPIT im ServiceNow Incident anzeigen zu können, muss eine eigene Incident
View erstellt werden.

Dazu öffnet man zuerst ein beliebiges Incident (Menü → Incidents → All → Klick auf Incident ID), drückt auf den
Menübutton oben links und navigiert zu dem Punkt Configure → Form Design.

Auf dieser Seite sollten oben links die Tabelle 'Incident' und die Ansicht 'Default view' ausgewählt sein.

![Screenshot: ServiceNow Benutzerdefinierte Incident Übersicht konfigurieren](/images/servicenow-incidentfields.png)

Um die ausgewählte Ansicht zu klonen, öffnet man das Dropdown Menü, welches aktuell 'Default view' anzeigt und klickt
auf '**New...**'

![Screenshot: ServiceNow Benutzerdefinierte Incident Übersicht konfigurieren](/images/servicenow-incidentnew.png)

Auch hier sollte der Name 'openITCOCKPIT' gewählt und mit OK bestätigt werden.

![Screenshot: ServiceNow Benutzerdefinierte Incident Übersicht konfigurieren](/images/servicenow-createview.png)

Nun sollte im Dropdown die neue View ausgewählt sein.

Auf der linken Seite gibt man im Tab 'Field Types' den Filter 'URL' ein. Es sollte ein Objekt für ein neues URL-Feld
erscheinen.

![Screenshot: ServiceNow Benutzerdefinierte Incident Übersicht konfigurieren](/images/servicenow-newurlfield.png)

**Das URL-Objekt** wird per Drag-and-drop auf die rechte Seite an die gewünschte Stelle in die Boxen gezogen.

Dies muss 2x zum Erstellen der Felder 'Host URL' und 'Service URL' getan werden.

Empfohlene Konfiguration:

(Die Objekte für die Felder 'Host URL' und 'Service URL' in der zweiten Box unter dem Objekt 'Description' anordnen)

![Screenshot: ServiceNow Benutzerdefinierte Incident Übersicht konfigurieren](/images/servicenow-incidentfieldtype.png)

Nach dem Hinzufügen der zwei URL Objekte müssen diese über das Zahnrad auf der rechten Seite editiert werden.

Für das Label 'Host URL' muss der Name 'u\_host\_url' und für das Label 'Service URL' der Name 'u\_service\_url' gewählt
werden.

![Screenshot: ServiceNow Benutzerdefinierte Incident Übersicht konfigurieren](/images/servicenow-hosturlproperties.png)

![Screenshot: ServiceNow Benutzerdefinierte Incident Übersicht konfigurieren](/images/servicenow-serviceurlproperties.png)

Danach kann die Konfiguration oben rechts mit 'Save' gespeichert und der Tab geschlossen werden.

Damit die eben angelegte Incident View automatisch für von openITCOCKPIT angelegte Incidents ausgewählt wird, muss
eine 'View Rule' erstellt werden.

![Screenshot: ServiceNow Benutzerdefinierte Incident Übersicht konfigurieren](/images/servicenow-viewrules.png)

Die View Rule sollte wie folgt definiert werden:

Als Table muss 'Incident' ausgewählt werden.

Der Wert für View entspricht dem Names der eben selbst definierten Incident View.

Als Condition sollte 'Caller' → 'is' → 'openITCOCKPIT' definiert werden.

Der Wert für Caller entspricht dem Names des für openITCOCKPIT angelegten ServiceNow Benutzers.

Gespeichert wird die Rule mit 'Submit'

![Screenshot: ServiceNow Benutzerdefinierte Incident Übersicht konfigurieren](/images/servicenow-newviewrole.png)

### Modul Konfiguration speichern

Im openITCOCKPIT den Menüpunkt Systemkonfiguration → APIs → ServiceNow öffnen und User ID / Password des eben erstellten
Benutzers eintragen.

Die eigene ServiceNow URL nach dem angegebenen Schema eintragen.

Sollte ein Host/Service den Up/Ok State verlassen, wird ein ServiceNow Incident erstellt.

Soll diesem Incident eine 'Assignment Group' oder ein 'Assigned To' - Benutzer zugeordnet werden, so muss der Name der
Gruppe / des Benutzers hier angegeben werden.

Für 'Impact' und 'Urgency' gibt es jeweils 3 verfügbare Optionen (High, Medium, Low) aus denen sich die Incident
Priorität zusammensetzt, die in der ServiceNow Incident Liste angezeigt wird.

Details zur Prioritätsberechnung gibt es in der
offiziellen [ServiceNow Dokumentation](https://docs.servicenow.com/bundle/london-it-service-management/page/product/incident-management/reference/r_PrioritizationOfIncidents.html?cshalt=yes)
.

![Screenshot: Modul Konfiguration speichern](/images/servicenow-config.png)

### Benachrichtigung aktivieren

Den Kontakten, über die ServiceNow benachrichtigt werden soll, muss der Command 'host-notify-by-servicenow' / '
service-notify-by-servicenow' hinzugefügt werden.

Es können auch mehrere Commands oder eine andere Time period ausgewählt sein.

Zur korrekten Funktionsweise muss immer die Benachrichtigung bei Auftreten des 'Recovery' States aktiviert sein!

Da es sich hierbei um Änderungen an der Nagios Konfiguration handelt, muss nach diesem Schritt ein [Export](../../monitoring/basic-principles/#wie-fuhre-ich-einen-export-aus) durchgeführt
werden.

![Screenshot: Benachrichtigung aktivieren](/images/contacts-servicenownotifications.png)

## Zwei-Wege-Integration Einrichten

Um Acknowledgements für Hosts und Services über die ServiceNow Incidents durchführen zu können, aktiviere "Two-Way
Integration" im openITCOCKPIT Systemkonfiguration → APIs → ServiceNow.

Der openITCOCKPIT Server muss in diesem Fall von extern über http oder https mit einem gültigen und verifizierten SSL
Zertifikat erreichbar sein.

**Wichtig: Wenn vorhanden, muss das "full chained" Zertifikat genutzt werden.** (Wird mit LetsEncrypt automatisch
erstellt)

Damit Incident Updates automatisch an openITCOCKPIT gesendet werden können, muss eine ServiceNow 'Business Rule'
angelegt werden.

Dazu navigiert man im Menü zu 'System Definition' → 'Business Rule'.

Als Name wird 'openITCOCKPIT' empfohlen, dies ist jedoch nicht essenziell.

Es muss für die Rule die Table 'Incident' ausgewählt, sowie die Optionen 'Active' und 'Advanced' aktiviert werden.

Im Tab '**When to run**' müssen folgende Einstellungen getroffen werden:

(Die angegebenen 'Filter Conditions' sind über 'AND' verknüpft)

Der 'Caller' und 'Updated by' Wert entspricht dem Namen des angelegten Benutzers (hier 'openITCOCKPIT').

![Screenshot: Zwei-Wege-Integration Einrichten](/images/servicenow-businessrule.png)

Im Tab '**Advanced**' muss folgender Quellcode in das 'Script' Feld eingefügt werden (es wird an dieser Stelle keine 
'Condition' benötigt):

Der Wert der Variable 'openITCOCKPIT\_url' muss der extern erreichbaren eigenen openITCOCKPIT URL entsprechen.

Der Wert der Variable 'openITCOCKPIT\_apikey' muss einem selbst generierten, gültigen openITCOCKPIT Api Key entsprechen.

**Business Rule Script (Vorlage)**

```plaintext
(function executeRule(current, previous /*null when async*/) {

    try {

        var openITCOCKPIT_url = "https://demo.openitcockpit.io";
        var openITCOCKPIT_apikey = "551ad76bcdb0.....";

        var openITCOCKPIT_servicenow_path = "/servicenow_module/servicenow_acknowledge/submit.json";
        var request = new sn_ws.RESTMessageV2();
        request.setEndpoint(openITCOCKPIT_url + openITCOCKPIT_servicenow_path);
        request.setRequestHeader("Accept","application/json");
        request.setRequestHeader('Content-Type','application/json;charset=UTF-8');
        request.setHttpMethod('POST');
        request.setQueryParameter('apikey', openITCOCKPIT_apikey);

        var data = {};
        data.short_description = current.getValue('short_description');
        data.impact = current.getValue('impact');
        data.urgency = current.getValue('urgency');
        data.state = current.getValue('state');
        data.incident_id = current.getValue('number');
        data.close_notes = current.getValue('close_notes');
        data.close_code = current.getValue('close_code');
        data.sys_resolved_by = current.getValue('resolved_by');
        data.updated_by = current.getValue('sys_updated_by');

        var myJSON = JSON.stringify(data);
        request.setRequestBody(myJSON);

        var response = request.execute();
        gs.log(myJSON);
        gs.log('openITCOCKPIT HTTP Status Code: '+response.getStatusCode());
        gs.log('openITCOCKPIT Error Message:');
        gs.log(response.getErrorMessage());
        gs.log('openITCOCKPIT Response Body:');
        gs.log(response.getBody());

    }catch(err){
        gs.log('openITCOCKPIT Rule Error: '+err);
    }

})(current, previous);
```

## Kommandos

Für die Benachrichtigung müssen die folgenden Kommandos genutzt werden.

Beim Installieren des Moduls sollten diese automatisch angelegt werden.

**Host Notification Command**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake ServicenowModule.ServicenowNotification --type Host --hostname "$HOSTNAME$" --hostaddress "$HOSTADDRESS$" --hoststate "$HOSTSTATEID$" --output "$HOSTOUTPUT$"
```

**Service Notification Command**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake ServicenowModule.ServicenowNotification --type Service --hostname "$HOSTNAME$" --hostaddress "$HOSTADDRESS$" --hoststate "$HOSTSTATEID$" --servicedesc "$SERVICEDESC$" --servicestate "$SERVICESTATEID$" --output "$SERVICEOUTPUT$"
```

## Debugging

Sollte die Two-Way Integration nicht funktionieren, sollte überprüft werden, ob das sog. **"full chained" Zertifikat**
genutzt wird. (Wird mit LetsEncrypt automatisch erstellt)

Um in ServiceNow den Debug Output des Business Rule Aufrufs zu erhalten, Beispielsweise beim Ändern von Incidents, muss
im Menü zu 'System Diagnostics' → 'Debug Business Rule' navigiert werden.

Zum Aktivieren des Debug Modus muss auf den Link 'available here' und im sich darauf hin öffnenden Tab auf den Button 
'Update' geklickt werden.

![Screenshot: Debugging](/images/servicenow-debugbusinessrule.png)

![Screenshot: Debugging](/images/servicenow-scriptexecutionhistory.png)

Danach kann wieder zum Incident navigiert und dieses aktualisiert werden.

Die Debug Ausgabe sollte nun am Ende der Seite erscheinen.

## Benutzung

Um Hosts / Services an ServiceNow anzubinden, muss dem jeweiligen 'Contact' der Hostcommand 'host-notify-by-servicenow'
und der Servicecommand 'service-notify-by-servicenow' hinzugefügt werden.

Alles Hosts / Services mit diesem Kontakt werden bei einer neuen Benachrichtigung als Incident an ServiceNow angebunden.

Beim Update des Incidents durch einen beliebigen Benutzer, der nicht openITCOCKPIT ist, wird ein Acknowledgement für den
Host / Service erstellt, solange dieser noch nicht wieder im Up / Ok State ist.

Hierbei wird in der Acknowledgement Nachricht die ServiceNow Incident Nummer (mit Verlinkung) angezeigt.

Schematische Darstellung möglicher Interaktionen mit ServiceNow:

![Abbildung: Benutzung](/images/servicenow-schema.png)

Im Hosts - und Services Browser erscheint bei Aktivierung des ServiceNow Moduls der Tab 'ServiceNow'. Dort können von
der globalen Konfiguration abweichende Host- bzw. Service-Spezifische Incident Einstellungen getroffen werden.

An dieser Stelle können die globalen Parameter 'Incident', 'Urgency', 'Assignment Group', 'Assigned To' und 'Business
Service' überschrieben werden.

Updates eines von openITCOCKPIT erstellten Incidents (über ServiceNow) bewirken bei korrekt konfigurierter Two-Way
Integration ein Acknowledgement des Host / Service.

Dabei werden die Incident Felder 'State' und 'Updated By' neben der Incident 'Number' übermittelt.

Beim Ändern des Incident State auf 'Closed' oder 'Resolved' wird zusätzlich der 'Resolution Code', die 'Resolution
Notes', sowie die System-ID des 'Resolved By' Benutzers an openITCOCKPIT übertragen.

![Abbildung: Benutzung](/images/servicenow-schema2.png)