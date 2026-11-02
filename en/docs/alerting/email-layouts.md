# Email layouts

Sending notifications via email is a function employed by almost all users. Email notifications are sent in HTML and plain text format. In order to better adapt notifications to the user's respective needs, the user can store their own individual email layouts allowing them to customise the appearance and content of their notifications.

![email layout option](/images/alerting/openitcockpit-4-notifications.png)

## Creating a layout

Different layouts are used for notifications depending on whether they are being sent from hosts or services. A total of four files should be created.

**Hosts:**

```sh
# For HTML emails
cp /opt/openitc/frontend/src/Template/email/HTML/notification_host.php /opt/openitc/frontend/src/Template/email/HTML/custom_layout_notification_host.php

# For plain text emails
cp /opt/openitc/frontend/src/Template/email/text/notification_host.php /opt/openitc/frontend/src/Template/email/text/custom_layout_notification_host.php
```

**Services**
```sh
# For HTML emails
cp /opt/openitc/frontend/src/Template/email/HTML/notification_service.php /opt/openitc/frontend/src/Template/email/HTML/custom_layout_notification_service.php

# For plain text emails
cp /opt/openitc/frontend/src/Template/email/text/notification_service.php /opt/openitc/frontend/src/Template/email/text/custom_layout_notification_service.php
```

!!! warning
    It is important that the file ends with `_host.php` or `_service.php`. The file name can only consist of letters, numbers, hyphens and underscores.

To send a test email, the `oitc` command can be used.
```
oitc nagios_notification -v --type Host --notificationtype PROBLEM --hostname c36b8048-93ce-4385-ac19-ab5c90574b77 --hoststate down --hostaddress 127.0.0.1 --hostoutput "Test E-Mail" --contactmail <email address> --layout custom_layout_notification
```

It is important, however, that the parameters `--hostname`, `--contactmail` and `--layout` are configured accordingly.

If the system cannot find the specified layout, an error message will be displayed
```
2021-09-10 08:58:59 Error: Notification: HTML or plain text layout "foobar_layout_notification" not found. Using default.
```
In addition, the error will be logged in the file `/opt/openitc/frontend/logs/cli-error.log`. 

## Using layouts

After a custom layout has been created, the two commands `host-notify-by-email` and `service-notify-by-email` must also include the parameter `--layout custom_layout_notification` to function correctly.

openITCOCKPIT then uses your layout as a template for emails.

![custom email layout](/images/alerting/openitcockpit-custom-email-layout.png)

## HTML and text emails
The `--format` parameter can be used to specify the type of email to be sent.

| Format | Description                                                                  |
|--------|------------------------------------------------------------------------------|
| `both` | Sends an HTML + text email. The client can decide which format is displayed. |
| `html` | Only sends an HTML email                                                     |
| `text` | Only sends a text email                                                      |

All email attachments such as logos and graphs can be excluded via the `--no-attachments` parameter in order to save storage space.

## Changing email logos
The logo used for your emails can be changed using the [Design Module](../../additional/theming/).
