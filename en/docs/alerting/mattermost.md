# Mattermost <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

## What can I do with the Mattermost module?

This module offers the possibility of setting up a two-way integration of Mattermost in openITCOCKPIT. Alerts can be sent to Mattermost and acknowledgments can be sent from Mattermost to openITCOCKPIT.

![Screenshot: What can I do with the Mattermost module?](/images/mattermost-chat.png)

## What can I configure?

You can find the configuration under "API Mattermost".

| Name field                                                                                                                | Required field | Description                                                                                                                                                  |
|---------------------------------------------------------------------------------------------------------------------------|----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Webhook URL                                                                                                               | :warning:      | Defines the address of the Mattermost server to be used. **                                                                                                  |
| Example**: [http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte](http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte) |                |                                                                                                                                                              |
| Enable Two-Way Integration                                                                                                |                | Mattermost can send acknowledgements to openITCOCKPIT using the two-way integration feature. If this is not enabled, only alerts will be sent to Mattermost. |
| openITCOCKPIT API Key                                                                                                     |                | This API key is used by Mattermost to send acknowledgements to openITCOCKPIT. First a custom, user-defined API key has to be created with openITCOCKPIT      |
| Use Proxy Server                                                                                                          |                | Decide whether the configured HTTP proxy should be used or not.                                                                                              |

## Mattermost configuration

Create a new [bot account](https://docs.mattermost.com/developer/bot-accounts.html) (oder normalen
Benutzer) (or normal user account) for openITCOCKPIT in your Mattermost environment.
Now create a new [incoming webhook.](https://docs.mattermost.com/developer/webhooks-incoming.html)

![Screenshot: Mattermost configuration](/images/mattermost-webhooks.png)

Once you click "Save", Mattermost will present you with a webhook URL. For Example: [*http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte*](http://192.168.122.1/hooks/1nmqus1wsfr988e81sr8whqrte). Copy this into a text file. You will need it later.

### Self-signed certificates or private IP addresses

If you are using private IP addresses, you must first add the network or IP address of your openITCOCKPIT server to the configuration key *AllowedUntrustedInternalConnections* in your Mattermost's *config.json*.

```plaintext
"AllowedUntrustedInternalConnections": "192.168.122.32",
```

Also read: [Allow untrusted internal connections to](https://docs.mattermost.com/administration/config-settings.html#allow-untrusted-internal-connections-to)

When using self-signed certificates, you need to enable *EnableInsecureOutgoingConnections* option in your Mattermost's *config.json*.

```plaintext
"EnableInsecureOutgoingConnections": true,
```

Also read: [Enable Insecure Outgoing Connections](https://docs.mattermost.com/administration/config-settings.html#enable-insecure-outgoing-connections)

## openITCOCKPIT configuration

Open the Mattermost Module configuration and fill in the required fields.

![Screenshot: openITCOCKPIT configuration](/images/mattermost-config.png)

## Commands

The following commands must be used for notifications.

These should be created automatically when the module is installed.

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
