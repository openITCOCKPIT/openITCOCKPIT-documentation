# Slack <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## Was kann ich mit dem Slack Modul tun?

Mithilfe des Slack Moduls kannst du Benachrichtigungen von openITCOCKPIT direkt in einen Channel deines Slack Workspace
bekommen.

![](/images/slack-chatnotification.png)

## Was kann ich konfigurieren?

Unter "Systemkonfiguration → APIs → Slack" sind die Einstellungen für das Slack Modul zu finden.

| Feld Name | Erforderliches Feld | Beschreibung |
| --- | --- | --- |
| Webhook URL | :warning:  | Definiert die Adresse des Slack-Servers, an den das Modul die Benachrichtigungen senden soll **
Example**:[https://hooks.slack.com/services/](https://hooks.slack.com/services/)[...](http://10.10.10.20/osm_tiles/%7Bz%7D/%7Bx%7D/%7By%7D.png) |
| OAuth Access Token | :warning: | Das Token erhält man von Slack für seinen Workspace Wird nur benötigt, wenn die Zwei-Wege Integration aktiviert ist |
| Enable Two-Way Integration |     | Über die Zwei-Wege Integration ist es Slack möglich Acknowledgements für Host und Services an openITCOCKPIT zu senden Für diese Option ist es erforderlich, dass der openITCOCKPIT Server über das Internet erreichbar ist |
| Request URL |     | Wird von openITCOCKPIT generiert und gibt die Webhook URL für Slack an. Zuerst muss ein benutzerdefinierter API-Key mit openITCOCKPIT erstellt werden. |
| Use Proxy Server |     | Gibt an, ob der konfigurierte Proxy verwendet werden soll |

## Einrichtung

openITCOCKPIT kommuniziert mit Slack über die Slack WebAPI und sendet als App Nachrichten in einen bestimmten Channel.

Gehe zum Erstellen der App auf die
Webseite [https://api.slack.com/apps?new\_app=1](https://api.slack.com/apps?new_app=1)

Bestimme eine eigene App Name und wähle deinen eigenen Slack Workspace aus.

![](/images/slack-createapp.png)

Wähle im linken Menü "Incoming Webhooks", aktiviere die Option oben rechts und füge deinem Workspace den Webhook mit
Klick auf den unten stehenden Button hinzu.

![](/images/slack-webhooks.png)

Wähle einen Channel, in welchen die Nachrichten von openITCOCKPIT gepostet werden sollen.

![](/images/slack-identity.png)

Kopiere die eben erstellte Webhook URL und füge diese im `openITCOCKPIT -> Administration -> Slack` ein.

![](/images/slack-copywebhookurl.png)

![](/images/slack-configempty.png)

### **Zwei-Wege-Integration**

Um Acknowledgements für Hosts und Services im Slack durchführen zu können, aktiviere die "Two-Way Integration".

openITCOCKPIT muss in diesem Fall von extern erreichbar sein.

Gehe dazu auf der Webseite der Slack API links im Menü auf "OAuth & Permissions", füge unten auf der Seite das Recht 
"users:read" hinzu und speichere die Änderungen.

Gegebenenfalls muss der Webhook neu installiert werden. Folge dazu den Anweisungen am oberen Rand der Slack API
Webseite.

Ist dies der Fall, muss ebenfalls die neue Webhook URL im openITCOCKPIT aktualisiert werden.

![](/images/slack-scopes.png)

Kopiere danach das generierte OAuth Access Token und füge es im openITCOCKPIT ein.

![](/images/slack-oauth.png)

Um die "Two-Way-Integration" zu aktivieren sollten die Slack Einstellungen wie folgt aussehen.

Optional kann die ausgehende Verbindung über den eingestellten Proxy aufgebaut werden.

Speichere deine Einstellungen und kopiere im nächsten Schritt die "Request URL".

![](/images/slack-configfilled.png)

Aktiviere "Interactive Messages" und füge die zuvor kopierte "Request URL" ein.

![](/images/slack-interactivemessages.png)

![](/images/slack-interactivemessages2.png)

### **Aktiviere Slack Benachrichtigung**

Füge deinem Kontakt, die bei der Modulinstallation automatisch erstellten Kommandos hinzu, oder ersetze die Alten.

Danach speichern und [exportieren](../../monitoring/basic-principles/#wie-fuhre-ich-einen-export-aus).

![](/images/contacts-slacknotifications.png)

## Kommandos

Für die Benachrichtigung müssen die folgenden Kommandos genutzt werden.

Host:

**Host Notification Command - openITCOCKPIT Version 4.0**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake SlackModule.SlackNotification --type Host --notificationtype $NOTIFICATIONTYPE$ --hostname "$HOSTNAME$" --hostaddress "$HOSTADDRESS$" --hoststate "$HOSTSTATEID$" --output "$HOSTOUTPUT$"
```

Service:

**Service Notification Command - openITCOCKPIT Version 4.0**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake SlackModule.SlackNotification --type Service --notificationtype $NOTIFICATIONTYPE$ --hostname "$HOSTNAME$" --hostaddress "$HOSTADDRESS$" --hoststate "$HOSTSTATEID$" --servicedesc "$SERVICEDESC$" --servicestate "$SERVICESTATEID$" --output "$SERVICEOUTPUT$"
```
