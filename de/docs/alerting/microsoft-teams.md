# Microsoft Teams <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## Was kann ich mit dem Microsoft Teams Modul tun?

Ähnlich zum [Slack module](/alerting/slack), wird diese Integration es ermöglichen, Benachrichtigungen aus openITCOCKPIT
an einen Kanal in Microsoft Teams zu schicken.

![](/images/microsoft-teams/title.png)

## Was kann ich konfigurieren?

Die Einstellungen für dieses Modul können unter "Systemkonfiguration → APIs → Teams" gefunden werden.

| Feld Name        | Erforderliches Feld | Beschreibung                                                                                                                                                                           |
|------------------|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Webhook URL      | :warning:           | Legt die Webhook-URL fest, die openITCOCKPIT verwendet, um Benachrichtigungen zu senden. <br/>Wird angezeigt, wenn man in Microsoft Teams den Connector "Incoming Webhook" einrichtet. |
| Use Proxy Server |                     | Gibt an, ob der konfigurierte Proxy verwendet werden soll                                                                                                                              |

## Abhängigkeiten

Um die Teams-Integration von openITCOCKPIT zu nutzen, brauchen Sie mindestens das kostenlose Paket von [Microsoft Power Automate](https://make.powerautomate.com).
Außerdem, falls in einen privaten Channel gepostet werden soll, brauchen Sie einen weiteren (eigenen) Nutzer mit den entsprechenden Berechtigungen.
Falls Sie in einen regulären Kanal posten wollen, brauchen Sie keinen eigenen Nutzer dafür.

## Microsoft Power Automate Flow einrichten
openITCOCKPIT nutzt die API von Microsoft Power Automate, um Nachrichten an Teams zu schicken. Um zu beginnen, loggen Sie sich bei [Microsoft Power Automate](https://make.powerautomate.com) ein.

1. Einen "Automatischen Cloud flow" erstellen.
   - ![](/images/microsoft-teams/create-flow.png)
   - ![](/images/microsoft-teams/create-flow-2.png)
   - Vergeben Sie einen passendenen Namen, überspringen aber die Auswahl des Triggers.
2. Trigger
   - ![](/images/microsoft-teams/trigger.png)
3. Aktion 1 "Compose"
   - Legen Sie die erste Aktion an. Suchen Sie dafür nach "Verfassen" nutzen die gleichnamige Aktion aus der Gruppe "Datenvorgang".
   - ![](/images/microsoft-teams/compose.png)
   - Klicken Sie in das Feld "Eingaben" und dann auf den "fx", um einen Ausdruck einzufügen.
   - ![](/images/microsoft-teams/compose-2.png)
   - Kopieren Sie ``first(triggerBody()?['attachments'])?['content']`` in das große Input-Feld und klicken Sie dann auf "Hinzufügen".
   - ![](/images/microsoft-teams/compose-3.png)
4. Aktion "Karte in einem Chat oder Kanal veröffentlichen".
   - ![](/images/microsoft-teams/post-1.png)
   - Erstellen Sie die Aktion "Karte in einem Chat oder Kanal veröffentlichen" aus der Gruppe "Microsoft Teams".
   - ![](/images/microsoft-teams/post-2.png)
   - Wählen Sie "Veröffentlichen als" "Flow-Bot", "Veröffentlichen in" "Kanal". Wählen Sie anschließend sowohl Teams als auch Kanal aus.
   - ![](/images/microsoft-teams/post-3.png)
   - Zuletzt wählen Sie das Feld "Adapitve Karte" an und klicken auf das Blitz-Icon. Hier können Sie "Ausgaben" von "Verfassen" wählen.
5. Save & Copy Webhook URL
   - Speichern Sie ihren Flow ab.
   - Wenn Sie ihn wieder öffnen, können Sie aus dem Trigger Ihre Webhook URL für openITCOCKPIT kopieren:
   - ![](/images/microsoft-teams/copy-1.png)
   - ![](/images/microsoft-teams/copy-2.png)

Once this has been done, the alerts will be sent using MS Teams.

## Commands

## Kommandos

Für die Benachrichtigung müssen die folgenden Kommandos genutzt werden.

Host:

**Host Notification Command - openITCOCKPIT Version 4.7**

```plaintext
/opt/openitc/frontend/bin/cake MSTeamsModule.teams_notification --type Host --notificationtype $NOTIFICATIONTYPE$ --hostuuid "$HOSTNAME$" --state "$HOSTSTATEID$" --output "$HOSTOUTPUT$"
```

Service:

**Service Notification Command - openITCOCKPIT Version 4.7**

```plaintext
/opt/openitc/frontend/bin/cake MSTeamsModule.teams_notification --type Service --notificationtype $NOTIFICATIONTYPE$ --hostuuid "$HOSTNAME$" --serviceuuid "$SERVICEDESC$" --state "$SERVICESTATEID$" --output "$SERVICEOUTPUT$"
```
