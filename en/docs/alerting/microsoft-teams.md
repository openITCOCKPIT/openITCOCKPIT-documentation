# Microsoft Teams <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## What can I do with the Microsoft Teams Module?

Similar to the [Slack module](/alerting/slack), this integration will provide communications from openITCOCKPIT into a
Teams chat within MicrosoftTeams.

![](/images/microsoft-teams/title.png)

## How To Configure?

The settings for the Microsoft Teams module can be found under "System configuration → APIs → Teams".

| Field name       | Required field | Description                                                                                                            |
|------------------|----------------|------------------------------------------------------------------------------------------------------------------------|
| Webhook URL      | :warning:      | Defines the URL to the webhook that is called from OITC. <br/>This is received when configuring the "Incoming Webhook" |
| Use Proxy Server |                | Indicates whether to use the configured proxy                                                                          |

## Dependencies

To make this feature work, your Microsoft Teams account needs the free tier
of [Microsoft Power Automate](https://make.powerautomate.com).
Also, in case you want to post to a private channel, you will need a (designated) user with the permissions to post to a
the specific channel.
If you are going to post in a public channel, that is not required.

## Setting up Microsoft Power Automate

openITCOCKPIT will use the API of Microsoft Power Automate to publish the messages to Microsoft Teams. To start this,
log in to Log in to [Microsoft Power Automate](https://make.powerautomate.com).

1. Start by creating an "Automated cloud flow".
    - ![](/images/microsoft-teams/create-flow.png)
    - ![](/images/microsoft-teams/create-flow-2.png)
    - Add a fitting name for your flow. Then SKIP the flow's trigger.
2. Trigger
    - ![](/images/microsoft-teams/trigger.png)
3. First Step "Compose"
    - Create an Action. Search for "compose" and add the "Compose" Action from the "Data Operation" Group.
    - ![](/images/microsoft-teams/compose.png)
    - Click into the "Inputs" field and then at the "fx" button to add an expression.
    - ![](/images/microsoft-teams/compose-2.png)
    - There, add ``first(triggerBody()?['attachments'])?['content']`` to the big input field and click "Add"
    - ![](/images/microsoft-teams/compose-3.png)
4. Step "Post card in a chat or channel".
    - ![](/images/microsoft-teams/post-1.png)
    - Create another Action. Search for "Post card in a chat or channel" and add the Action from the "Microsoft Teams"
      Group.
    - ![](/images/microsoft-teams/post-2.png)
    - Select post as "Flow bot", Post in "Channel", then select your team and the channel the message should go to.
    - ![](/images/microsoft-teams/post-3.png)
    - At last, click the "Adaptive Card" input field and then the Bolt icon. Here, you should see the "Outputs" from the
      previous "Compose" step. Click that.
5. Save & Copy Webhook URL
    - Save your flow.
    - If you open it again and click the trigger, you can copy your HTTP URL and add this to openITCOCKPIT:
    - ![](/images/microsoft-teams/copy-1.png)
    - ![](/images/microsoft-teams/copy-2.png)

Once this has been done, the alerts will be sent using MS Teams.

## Commands

The following commands must be used for notifications.

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
