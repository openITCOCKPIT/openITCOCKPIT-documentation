# PagerDuty <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## Was kann ich mit dem PagerDuty Modul tun?

Mithilfe des PagerDuty Moduls kannst du Host- und Service-Benachrichtigungen von openITCOCKPIT direkt in einen PagerDuty
Account bekommen.

Im Gegensatz zu unserer E-Mail-Integration kann PagerDuty Tickets verschiedener Quellen strukturiert anzeigen und
verwalten.

Sobald auf einem Host oder Service ein Fehler auftritt, wird ein PagerDuty Ticket erstellt.

Bei Verwendung der PagerDuty App können die Benachrichtigungen auch auf dem Smartphone empfangen werden. Mehrere
Benachrichtigungen zu einem Host oder Service werden in einem Ticket zusammengefasst.

Nach Konfiguration der Zwei-Wege Integration werden Ticket Acknowledgements(Bestätigungen) auch wieder zurück ins
openITCOCKPIT übertragen.

Der Autor und ein Link zum Ticket werden in der Host / Service Acknowledgement Nachricht im openITCOCKPIT angezeigt.

Wenn der Host oder Service den Status Up oder Ok wiedererlangt, wird das PagerDuty Ticket automatisch geschlossen,
sofern es noch geöffnet war.

![Screenshot: Was kann ich mit dem PagerDuty Modul tun?](/images/pagerduty-incidents.png)

### Was kann ich konfigurieren?

Unter "Configuration / PagerDuty" sind die Einstellungen für das PagerDuty Modul zu finden.

| Feld Name | Erforderliches Feld | Beschreibung |
| --- | --- | --- |
| Api key | :warning: | API Key von PagerDuty |
| Integration Key | :warning: | Der Integration Key, den du nach dem Erstellen eines Service auf PagerDuty bekommen hast |
| API URL | :warning: | API URL des PagerDuty Service. |
| Enable Two-Way Integration |     | Über die Zwei-Wege Integration ist es Slack möglich Acknowledgements für Host und Services an openITCOCKPIT zu senden Für diese Option ist es erforderlich, dass der openITCOCKPIT Server über das Internet erreichbar ist |
| Webhook URL |     | Wird von openITCOCKPIT generiert und gibt die Webhook URL für PagerDuty an Zuerst muss ein benutzerdefinierter API-Key mit openITCOCKPIT erstellt werden |
| Use Proxy Server |     | Gibt an, ob der konfigurierte Proxy verwendet werden soll |

## Installation

### Einfache Integration

Mit der einfachen Integration kann openITCOCKPIT Tickets in PagerDuty öffnen, eine Acknowledgments erstellen und Tickets
schließen. Acknowledgments die in PagerDuty erstellt werden, können jedoch nicht ans openITCOCKPIT übertragen werden.

openITCOCKPIT kommuniziert mit PagerDuty über die API Version 2.

Um dies zu tun, musst du zuerst einen API Key erstellen. Dazu navigierst du im PagerDuty Menü zum Punkt Configuration →
Api Access.

Klicke auf den "**Create New Api Key**" Button, gib eine Beschreibung ein, wähle API version 2 aus und bestätige mit "**
Create Key**".

![Screenshot: Einfache Integration](/images/pagerduty-createapikey.png)

Kopiere im nächsten Dialog den API Key im openITCOCKPIT auf die Seite PagerDuty settings.

![Screenshot: Einfache Integration](/images/pagerduty-getapikey.png)

Da der API Key nicht erneut angezeigt werden kann, sollte dieser sofort gespeichert werden.

Anschließend muss ein neuer Service angelegt werden.

Navigiere zum Menüpunkt Configuration → Services und klicke auf "**\+ New Service**".

Hier ist es wichtig, dass als "Integration Type" aus der Auswahlbox ("Select a tool") "**openITCOCKPIT**" ausgewählt
wird.

![Screenshot: Einfache Integration](/images/pagerduty-addservice.png)

Die Option Incident Behavior muss auf "*Create incidents*" eingestellt werden!

Klicke auf "**Add Service**" und kopiere den angezeigten "Integration Key".

### Zwei-Wege Integration

Mit unserer Zwei-Wege Integration werden in PagerDuty erstellte Acknowledgements auch in dein openITCOCKPIT übertragen.

Für die bidirektionale Integration muss ein Webhook erstellt werden.

Navigiere zum Menüpunkt Configuration →Extensions.

Klicke auf "**\+ New Extension**" und wähle "*Generic V2 Webhook*" aus.

Kopiere die Webhook URL aus den openITCOCKPIT PagerDuty Einstellungen in das URL-Feld und ersetze "*
YOUR\_API\_KEY\_HERE*" mit einem neuen API Key.

Wenn dein System hinter einem Proxy ist, musst du den Hostnamen eventuell manuell anpassen.

Um einen openITCOCKPIT API Key zu erstellen, klicke auf dein Benutzerprofil in der linken oberen Ecke im openITCOCKPIT
und scrolle bis zum Ende der Seite. Dort kannst du einen neuen API Key erstellen.

![Screenshot: Zwei-Wege Integration](/images/pagerduty-serviceextensions.png)

Klicke auf "**Save**", um die Erweiterung zu speichern.

### Aktualisieren der openITCOCKPIT Konfiguration

Schließlich müssen alle noch nicht kopierten Parameter in die Konfiguration des openITCOCKPIT PagerDuty Moduls
übertragen werden.

Vergiss nicht deine Änderungen zu speichern.

![Screenshot: Aktualisieren der openITCOCKPIT Konfiguration](/images/pagerduty-config.png)

Um nach dem Auftreten eines Problems benachrichtigt zu werden, benötigt der Host- / Servicekontakt die PagerDuty
Benachrichtigungsbefehle.

Suche im openITCOCKPIT Menü nach "Contacts" oder gehe direkt zu "Monitoring→ Objects → Contacts".

Klicke auf der Kontaktseite auf das Zahnrad auf der rechten Seite.

![Screenshot: Aktualisieren der openITCOCKPIT Konfiguration](/images/menu-contacts.png)

![Screenshot: Aktualisieren der openITCOCKPIT Konfiguration](/images/contacts-editcontact.png)

Bearbeite den Kontakt, über den PagerDuty benachrichtigt werden soll, füge den Befehl "*host-notify-by-pagerduty*" zu
den Host Commands hinzu und "*service-notify-by-pagerduty*" zu den Service Commands.

![Screenshot: Aktualisieren der openITCOCKPIT Konfiguration](/images/contacts-pagerdutynotifications.png)

**Fertig. Die Konfiguration ist abgeschlossen.**  
