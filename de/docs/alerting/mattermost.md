# Mattermost <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

## Was kann ich mit dem Mattermost Modul tun?

Dieses Modul bietet die Möglichkeit einer Zwei-Wege-Integration von Mattermost in openITCOCKPIT. Alarme können an
Mattermost gesendet werden und Bestätigungen (Acknowledgements) können von Mattermost an openITCOCKPIT geschickt werden.

![Screenshot: Was kann ich mit dem Mattermost Modul tun?](/images/mattermost-chat.png)

## Was kann ich konfigurieren?

Unter "API Mattermost" können Sie die Konfiguration finden.

| Feld Name | Erforderliches Feld | Beschreibung |
| --- | --- | --- |
| Webhook URL | :warning: | Definiert die Adresse des Mattermost Servers, welcher genutzt werden soll. **
Example**: [http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte](http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte) |
| Enable Two-Way Integration |     | Über die Zwei-Wege-Integration kann Mattermost Acknowledgements an openITCOCKPIT Senden. Ohne werden nur Alarme an Mattermost geschickt. |
| openITCOCKPIT API Key |     | Dieser API-Key wird von Mattermost genutzt um die Acknowledgements an openITCOCKPIT zu schicken. Zuerst muss ein benutzerdefinierter API-Key mit openITCOCKPIT erstellt werden |
| Use Proxy Server |     | Ob der konfigurierte HTTP Proxy genutzt werden soll oder nicht. |

## Mattermost Konfiguration

Erstellen Sie einen neuen [Bot Account](https://docs.mattermost.com/developer/bot-accounts.html) (oder normalen
Benutzer) für openITCOCKPIT in Ihrer Mattermost Umgebung.

Anschließend erstellen Sie einen neuen [Incoming Webhook.](https://docs.mattermost.com/developer/webhooks-incoming.html)

![Screenshot: Mattermost Konfiguration](/images/mattermost-webhooks.png)

Sobald Sie auf "Save" klicken, wird Mattermost Ihnen eine Webhook URL anzeigen. For
Example: [*http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte*](http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte)
. Kopieren Sie diese in eine Textdatei. Sie wird später noch benötigt.

### Selbst signierte Zertifikate oder private IP-Adressen

Wenn Sie private IP-Adressen verwenden, müssen Sie zuerst das Netzwerk oder die IP-Adresse Ihres openITCOCKPIT Servers
in den Konfigurationsschlüssel *AllowedUntrustedInternalConnections* in Ihrer Mattermost's *config.json* hinzufügen.

```plaintext
"AllowedUntrustedInternalConnections": "192.168.122.32",
```

Lesen Sie
auch: [Allow untrusted internal connections to](https://docs.mattermost.com/administration/config-settings.html#allow-untrusted-internal-connections-to)

Bei der Verwendung von Selbst signierten Zertifikaten müssen Sie die Option*EnableInsecureOutgoingConnections* in Ihrer
Mattermost's *config.json aktivieren.*

```plaintext
"EnableInsecureOutgoingConnections": true,
```

Lesen Sie
auch: [Enable Insecure Outgoing Connections](https://docs.mattermost.com/administration/config-settings.html#enable-insecure-outgoing-connections)

## openITCOCKPIT Konfiguration

Öffnen Sie die Mattermost Module Konfiguration und füllen Sie die erforderlichen Felder aus.

![Screenshot: openITCOCKPIT Konfiguration](/images/mattermost-config.png)

## Kommandos

Für die Benachrichtigung müssen die folgenden Kommandos genutzt werden.

Diese sollten bei der Installation des Moduls automatisch erstellt werden sein.

Host:

**Host Notification Command - openITCOCKPIT Version 4.0**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake MattermostModule.mattermost_notification --type Host --notificationtype "$NOTIFICATIONTYPE$" --hostuuid "$HOSTNAME$" --state "$HOSTSTATEID$" --output "$HOSTOUTPUT$" --ackauthor "$NOTIFICATIONAUTHOR$" --ackcomment "$NOTIFICATIONCOMMENT$"
```

Service:

**Service Notification Command - openITCOCKPIT Version 4.0**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake MattermostModule.mattermost_notification --type Service --notificationtype "$NOTIFICATIONTYPE$" --hostuuid "$HOSTNAME$" --serviceuuid "$SERVICEDESC$" --state "$SERVICESTATEID$" --output "$SERVICEOUTPUT$" --ackauthor "$NOTIFICATIONAUTHOR$" --ackcomment "$NOTIFICATIONCOMMENT$"
```