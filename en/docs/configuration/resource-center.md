# Service Capacity Management Module (Resource Management Module) <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

The Service Capacity Management can be installed via the package manager of openITCOCKPIT.
Navigate to `Administration -> System Tools -> Package Manager` and install the *ScmModule*

With Service Capacity Management Module, providers have the opportunity to communicate the status of their resources (
e.g., IT services) at a specified time to better channel potential bottlenecks.

## Global Settings

In this area, it is determined by when `Default` (deadline) the status of a resource must be communicated at the latest.
A cron
job checks whether a status has been communicated for each resource. The `Default` reminder time (in minutes) specifies
the period
within which a reminder email is sent to providers with missing status. Additionally, it can be specified whether an
already set status can be overwritten (<b>"Allow status overwriting"</b>). Another restriction of status communication
can be set via the "<b>Require user assignment</b>" setting. If this checkbox is active, only the assigned users are
allowed to set a status.

![Global Settings](/images/scm/scm_settings.png)

## Resource Groups

Under the menu item `Administration -> Resource Center -> Resource Groups`, you can access the configuration area of the
resource groups.

![Menu Resource Groups](/images/scm/scm_resourcegroups_menu.png)

Here, new resource groups can be created, or already created resource groups are listed.

### Listing of Resource Groups

![Resource Groups List](/images/scm/scm_resourcegroups_list.png)

### Overview of Resource Groups

By clicking the <code>SCM Board</code> button, you get an overview of all resource groups and resources.

![Resource Groups Overview](/images/scm/scm_resourcegroup_summary_details_1.png)

By clicking on a specific resource group, a detailed view is displayed.

![Resource Groups Overview](/images/scm/scm_resourcegroup_summary_details_2.png)

### Create a New Resource Group

By clicking the <code>+ New</code> button, the area where you can create a new resource group opens.

The container determines the visibility of this group. Automatically, this serves as a filter for user selection. The
user selection determines which users are allowed to set a status. The division between Region Manager, Manager, and
Users determines who receives a reminder email, status email, escalation email, or cumulative status email.
An escalation is triggered if no status is set even after the reminder email is sent. The reminder email goes to all
users and managers. The escalation email or status email goes only to managers. The cumulative status email is sent to
the Region Manager.

| Field                         | Required                  | Description                                                                                                                |
|-------------------------------|---------------------------|----------------------------------------------------------------------------------------------------------------------------|
| Container                     | :fontawesome-solid-xmark: | The container determines the visibility of this group. Automatically, this serves as a filter for user selection           |
| Name                          | :fontawesome-solid-xmark: | Name of the resource group                                                                                                 |
| Description                   |                           | Description of the resource group                                                                                          |
| Deadline                      | :fontawesome-solid-xmark: | It is determined by when (deadline) the status of a resource must be communicated at the latest                            |
| Reminder time                 | :fontawesome-solid-xmark: | The reminder time (in minutes) specifies the period within which a reminder email is sent to providers with missing status |
| Time period                   |                           | The time period defines working days and holidays that should be considered for the resource group check (optional)        |
| Users                         | :fontawesome-solid-xmark: | Users who receive a reminder and escalation email                                                                          |
| Users [Mailing list]          | :fontawesome-solid-xmark: | Mailing lists who receive a reminder and escalation email                                                                  |
| Managers                      | :fontawesome-solid-xmark: | Users who receive an escalation or status email                                                                            |
| Managers [Mailing list]       | :fontawesome-solid-xmark: | Mailing lists who receive an escalation or status email                                                                    |
| Region Manager                |                           | Users who receive a cumulative status email                                                                                |
| Region Manager [Mailing list] |                           | Mailing lists who receive a cumulative status email                                                                        |

#### Reminder Email

![Reminder Email](/images/scm/scm_reminder_mail.png)

#### Escalation Email

![Escalation Email](/images/scm/scm_escalation_mail.png)

#### Status Email

![Status Email](/images/scm/scm_status_mail.png)

#### Cumulative Status Email

![Cumulative Status Email](/images/scm/scm_cumulative_report_mail.png)

All emails are logged in the database and can be viewed via the "Notifications" menu item. The resource names in the
email are linked to the openITCOCKPIT web interface.

![Resource Groups Notifications](/images/scm/scm_resourcegroup_notifications.png)

## Mailing lists

In the Resource Management Module, in addition to regular users, mailing lists can also be stored. This allows you to
use multiple email addresses at once when sending emails, without having to create a openITCOCKPIT-user for each email
address. As with user selection, the mailing lists can be assigned to users, managers, and also regional managers.

Under the menu item `Administration -> Resource Center -> Mailing lists` you will find the configuration area. Here,
mailing lists can be listed, added, edited, and deleted.

Create a new mailing list

To create a new mailing list, click the "+ New" button in the upper right corner of

| Field       | Required                  | Description                                                                                                            |
|-------------|---------------------------|------------------------------------------------------------------------------------------------------------------------|
| Container   | :fontawesome-solid-xmark: | The container defines the visibility of the mailing list. Automatically, this serves as a filter for the distribution. |
| Name        | :fontawesome-solid-xmark: | Name of the mailing list                                                                                               |
| Description |                           | Description of the mailing list                                                                                        |
| Department  |                           | This field is used for mail dispatch. If this field is set, it will be displayed in the email                          |
| Recipients  |                           | List of E-Mail Addresses and Names                                                                                     |

## Resource

Via the menu item `Administration -> Resource Center -> Resource`, you can access the overview page of the individual
resources. By clicking the <code>My resources</code> button, the list is filtered by your own resources. The list
provides all details about the individual resources and their status information.

All resources are sorted by status.

![Resources Overview](/images/scm/scm_resources_list.png)

Unconfirmed resources are displayed first.
A resource can have one of the following statuses:

| Status | Info            |
|--------|-----------------|
| 🟦     | unconfirmed (0) |
| 🟩     | ok (1)          |
| 🟧     | warning (2)     |
| 🟥     | critical (3)    |

Via the menu item `Set status for selected`, the status for multiple resources can be set. Alternatively, the status for
a single resource can also be set.

![Set Status](/images/scm/scm_set_status.png)

Every submitted status is logged and can be viewed via the "Status log" menu item.

![Resources Status Log](/images/scm/scm_statuslog.png)

As with the resource group, clicking the <code>+ New</code> button creates a new resource. In the selection, you choose
the associated resource group. The name of the resource is defined as a mandatory field. The description is optional.

![Add Resource](/images/scm/scm_resource_add.png)

| Field          | Required                  | Description                 |
|----------------|---------------------------|-----------------------------|
| Resource Group | :fontawesome-solid-xmark: | Associated resource group   |
| Name           | :fontawesome-solid-xmark: | Name of the resource        |
| Description    |                           | Description of the resource |

All changes to the resource and resource groups are logged and can be viewed via the `Changelog` menu item.
![Resources Changelog](/images/scm/scm_changelog_resource.png)

All changes to the ScmModule objects can be viewed via the menu item `Logs -> Changelog -> Scm Module Changes`.

![Scm Module Changelog](/images/scm/scm_changelog.png)

## Dashboards

### My Resources Widget

A custom widget for the dashboard allows users to always see the current status of their assigned resources.

![Add My Resources Widget](/images/scm/scm_add_my_resources_widget.png)

![My Resources Widget](/images/scm/scm_my_resources_widget.png)

### Cronjobs Status Overview Widget

![Add My Resources Widget](/images/scm/scm_add_cronjob_status_widget.png)

![My Resources Widget](/images/scm/scm_cronjob_status_widget.png)
