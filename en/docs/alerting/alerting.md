# Notifications / Alerts

openITCOCKPIT offers a variety of notification methods. In addition to the most common method,
the [email notification](../../beginners/setup-email-notifications/#setting-up-email-notifications), there are many
other options available out-of-the-box or by installing modules in openITCOCKPIT. Examples
include [browser push notification](../../beginners/setup-browser-push-notifications/#setting-up-push-notifications)
,
[PagerDuty](../pagerduty/#pagerduty-ee), messaging services like [Mattermost](../mattermost/#mattermost-ce)
, [Slack](../slack/#slack-ee) and ticketing systems like [AxiosAssyst](../axiosassyst/#axios-assyst-ee)
or [ServiceNow](../servicenow/#servicenow-ee).

## Contacts

Contacts are used in openITCOCKPIT to send notifications. Depending on the command configured for a given contact, these
notifications can be sent, for example, by email, browser push notifications or with extensions via SMS, chat
notifications or similar.

### Creating a new contact

To create a new contact, first click on the "New" button.

In the form that appears, select one or more containers in which the contact should be available. Then enter a name and
either an email address or telephone number.

Now select the notification method to be used for the host. To do this, choose the time frame and at least one command.

In order to send notifications to the contact, the "Host notifications enabled" option must be selected. Please note
that when using "Host notifications enabled" you can still stipulate when a notification should be sent.

Service notifications are configured according to the same scheme.

| Field                         | Required                  | Description                                                                                                                                                                                 |
|-------------------------------|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Container                     | :fontawesome-solid-xmark: | Container in which the contact is to be created                                                                                                                                             |
| Name                          | :fontawesome-solid-xmark: | Name of contact                                                                                                                                                                             |
| Description                   |                           | The interval at which the selected maps should rotate                                                                                                                                       |
| Email                         | :fontawesome-solid-xmark: | Email address of the contact. Either an email address, telephone number or both must be given                                                                                               |
| Phone                         | :fontawesome-solid-xmark: | Telephone number of the contact. Either an email address, telephone number or both must be given                                                                                            |
| Users                         |                           | The person using the contact. To receive browser notifications, a user must be assigned to the contact. The user ID is automatically set as a contact macro $_CONTACTOITCUSERID$ available. |
| Host notification             |
| Host time period              | :fontawesome-solid-xmark: | [The period during which notifications should be sent](../../configuration/timeperiods/)                                                                                                    |
| Host command                  | :fontawesome-solid-xmark: | Command to be used for notifications                                                                                                                                                        |
| Host notifications enabled    |                           | Enables notifications for hosts with this contact                                                                                                                                           |
| Push notifications to browser |                           | Activates the push notifications via the browser                                                                                                                                            |
| Service notifications         |                           |                                                                                                                                                                                             |
| Service time period           | :fontawesome-solid-xmark: | [The period during which notifications should be sent](../../configuration/timeperiods/)                                                                                                       |
| Service command               | :fontawesome-solid-xmark: | Command to be used for notification                                                                                                                                                         |
| Service notifications enabled |                           | Enables notifications for services with this contact                                                                                                                                        |
| Push notifications to browser |                           | Activates the push notifications via the browser                                                                                                                                            |

## Contact groups

Contact groups are collections of contacts. They are used to simplify the mass assignment of contacts to a wide variety
of objects. Contact groups can mostly be selected instead of individual contacts, for example, when creating hosts,
services, escalations, dependencies or templates.

| Field       | Required                  | Description                                           |
|-------------|---------------------------|-------------------------------------------------------|
| Container   | :fontawesome-solid-xmark: | Container in which the contact group is to be created |
| Name        | :fontawesome-solid-xmark: | Name of the contact group                             |
| Description |                           | Description of the contact group                      |
| Contacts    | :fontawesome-solid-xmark: | Contacts to be added to this contact group            |

### Is my contact group in use?

By using the "Used by" function it is possible to see an overview of the use of each respective contact group.

![contactgroup used by list item](/images/contactgroups-usedbylistitem.png)

## Escalations

Escalations can be used to alert one or more user groups in the event of an emergency. When a host or service is
escalated, contacts, contact groups, and notification options are overwritten by the escalation. These work the same for
hosts as they do for services.

### When are notifications escalated?

Notifications are only escalated if at least one escalation definition matches the notification in question. An
escalation defines a range of considerations that must be taken into account before notifications will be escalated.
This range is determined by the first notification (how any notifications are required for the escalation to take
effect) and the last notification (how any notifications are required for the default notification options for the
object to apply again). If an escalation period is defined, the escalation definition will only take effect within the
specified [timeperiod](../../configuration/timeperiods/). The escalation options can be used to select which states will
trigger an escalation. These are the states for hosts:

- Recovery
- Down
- Unreachable

and for services:

- Recovery
- Warning
- Critical
- Unknown

The Contacts and Contact Groups fields define the contacts that will be notified in the event of an escalation.

### Creating a host escalation

| Field                 | Required                  | Description                                                                                                                                         |
|-----------------------|---------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| Container             | :fontawesome-solid-xmark: | Container in which the escalation is to be created                                                                                                  |
| Hosts                 | :fontawesome-solid-xmark: | Hosts to be escalated                                                                                                                               |
| Excluded Hosts        |                           | Host groups to be escalated                                                                                                                         |
| Host groups           |                           | Hostgruppen die eskaliert werden sollen                                                                                                             |
| Excluded host groups  |                           | Host groups not to be escalated                                                                                                                     |
| First notification    | :fontawesome-solid-xmark: | The number of notifications transferred before the escalation rule overrides the notification settings.                                             |
| Last notification     | :fontawesome-solid-xmark: | When the number of final notifications is reached, the notification rule is disabled and the host or service's notification options are reinstated. |
| Notification interval | :fontawesome-solid-xmark: | IHow often the escalation notifications are to be sent                                                                                              |
| Escalation period     |                           | [Time range](../../configuration/timeperiods/) in which the escalation notifications are to be sent                                                 |
| Contacts              | :fontawesome-solid-xmark: | Escalation contact. At least one contact or contact group must be selected                                                                          |
| Contact groups        | :fontawesome-solid-xmark: | Escalation contact group. At least one contact or contact group must be selected                                                                    |
| Escalation options    |                           | The states for which the escalation will be activated                                                                                               |

### Create service escalation

| Field                   | Required                  | Description                                                                                                                                         |
|-------------------------|---------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| Container               | :fontawesome-solid-xmark: | Container in which the escalation is to be created                                                                                                  |
| Services                | :fontawesome-solid-xmark: | Services to be escalated                                                                                                                            |
| Excluded services       |                           | Services to be escalated                                                                                                                            |
| Service groups          |                           | Services not to be escalated                                                                                                                        |
| Excluded service groups |                           | Service groups not to be escalated                                                                                                                  |
| First notification      | :fontawesome-solid-xmark: | The number of notifications transferred before the escalation rule overrides the notification settings.                                             |
| Last notification       | :fontawesome-solid-xmark: | When the number of final notifications is reached, the notification rule is disabled and the host or service's notification options are reinstated. |
| Notification interval   | :fontawesome-solid-xmark: | How often the escalation notifications are to be sent                                                                                               |
| Escalation period       |                           | [Time range](../../configuration/timeperiods/) in which the escalation notifications are to be sent                                                 |
| Contacts                | :fontawesome-solid-xmark: | Escalation contact. At least one contact or contact group must be selected                                                                          |
| Contact groups          | :fontawesome-solid-xmark: | Escalation contact group. At least one contact or contact group must be selected                                                                    |
| Escalation options      |                           | The states for which the escalation will be activated                                                                                               |

## Host / service dependencies

Dependencies are a way of suppressing notifications and validating the checks run against specific objects based on the
status information of dependent objects. In openITCOCKPIT it is possible to define dependencies for hosts and host
groups as well as services and service groups.

Here is how it works: Before Naemon runs a service check or sends a notification, it checks the host or service for
dependencies. If no dependency is defined, the check is performed and the notification is sent as normal. If a
dependency is defined, each dependency is checked as follows:

1. The status of the dependent host or service is retrieved.
2. This status is matched against the execution or notification failure criteria (whichever is relevant at the time)
3. If this status matches any of the selected failure criteria, the dependency is considered to have failed and Naemon
   will stop further checking of the dependencies.
4. If this status does not match any of the selected failure criteria, the dependency is considered passed and Naemon
   will check the next dependency

This loop runs until either all dependent hosts or services pass verification or a dependency fails.

!!! info
    Unless otherwise configured, Naemon will use the latest hard state of the dependent hosts or services for its
    checking purposes.

#### Execution error/failure criteria

This type of dependency is used to temporarily suspend active checks. If all dependency checks for a host or service
pass, the host(s) or service(s) undergo checks as they normally would. If a dependency check fails, Naemon will
temporarily skip the check (host/service check) for the (dependent) host or service. If all dependencies pass the
check (at a later point in time), the check (host/service check) will continue as normal.

#### Notification of Failure Criteria

If all dependency checks for a host or service pass, notifications are sent out as normal. If a dependency check fails,
the notifications for the (dependent) host or service are temporarily suppressed. If all dependencies pass the check (at
a later time), the notifications for the (dependent) host or service will continue to be sent as normal.

#### Inheriting dependency

Dependencies are not automatically inherited. This means that if a host or service (A) has a dependency (B) and that
dependency in turn also has dependencies (C), then A does not depend on C by default. To enable the dependency, the
“Inherits parent” option must be checked

### Host dependencies

Host dependencies function the same as service dependencies.

1. A host can have dependencies with one or more hosts.
2. Host dependencies are not inherited by default (these can be inherited by ticking the appropriate option).
3. Host dependencies can be used to suppress notifications and run checks.
4. Host dependencies, if configured, are only valid within [defined periods](../../configuration/timeperiods/).

| Field                             | Required                  | Description                                                                 |
|-----------------------------------|---------------------------|-----------------------------------------------------------------------------|
| Container                         | :fontawesome-solid-xmark: | Container in which the host dependency is to be created                     |
| Hosts                             | :fontawesome-solid-xmark: | Hosts for which a dependency is to be created                               |
| Dependent hosts                   | :fontawesome-solid-xmark: | Hosts with a dependency in relation to the selected hosts                   |
| Host groups                       |                           | Host groups from which a dependency is to be created                        |
| Dependent host groups             |                           | Host groups that have a dependency to the selected hosts / host groups      |
| Time period                       |                           | [Period](../../configuration/timeperiods/) in which the dependency is valid |
| Inherits parent                   |                           | [Dependency inheritance](#inheriting-dependency)                           |
| Execution error/failure criteria  |                           | See [Execution failure criteria](#execution-errorfailure-criteria)               |
| Criteria for notification failure |                           | See [Notification failure criteria](#notification-of-failure-criteria)      |

### Service dependencies

Service dependencies are no different in function from host dependencies.

1. A service can have dependencies to one or more services.
2. A service can have dependencies to services that are not related to the same host.
3. Service dependencies are not inherited by default (these can be inherited by ticking the appropriate option).
4. Service dependencies can be used to suppress notifications and run checks.
5. If configured, service dependencies are only valid within [defined periods](../../configuration/timeperiods/).

| Field                             | Required                  | Description                                                                 |
|-----------------------------------|---------------------------|-----------------------------------------------------------------------------|
| Container                         | :fontawesome-solid-xmark: | Container in which the host dependency is to be created                     |
| Hosts                             | :fontawesome-solid-xmark: | Hosts for which a dependency is to be created                               |
| Dependent hosts                   | :fontawesome-solid-xmark: | Hosts with a dependency in relation to the selected hosts                   |
| Host groups                       |                           | Host groups from which a dependency is to be created                        |
| Dependent host groups             |                           | Host groups that have a dependency to the selected hosts / host groups      |
| Time period                       |                           | [Period](../../configuration/timeperiods/) in which the dependency is valid |
| Inherits parent                   |                           | [Dependency inheritance](#inheriting-dependency)                           |
| Execution error/failure criteria  |                           | See [Execution failure criteria](#execution-errorfailure-criteria)               |
| Criteria for notification failure |                           | See [Notification failure criteria](#notification-of-failure-criteria)      |
