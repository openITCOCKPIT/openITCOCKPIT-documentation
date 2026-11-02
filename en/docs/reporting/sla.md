# Service-Level-Agreement Module <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

The service level agreement module can be installed via the openITCOCKPIT package manager.
Navigate to `Management -> System Tools -> Package Manager` and install the *SLAModule*

## SLA Configuration

Under the menu item `Administration -> SLA MAnagement -> SLAs` you get to the SLA configuration area.
New SLAs can be created here and SLAs that have already been created are listed.

![SLA Overview](/images/sla/sla_list.png)

The current availability is displayed for all SLAs that have already been evaluated.

To calculate the availability the SLA needs to be defined with an name, a time period, an evaluation period and
guaranteed availability as a percentage. If desired, a value for an early warning can be entered as well.
The warning threshold needs to be higher than the guaranteed availability.

The start date of the SLA calculation is always the first day of the evaluation period. For example for the
evaluation period `MONTH` the start day is the first day of the month. For `WEEK` the start day is monday.
It is also possible to define a custom start date using the `Start date` field.

![SLA configuration](/images/sla/sla_configuration.png)

#### Basic configuration

| Field                   | Required                  | Description                                                                                                                  |
|-------------------------|---------------------------|------------------------------------------------------------------------------------------------------------------------------|
| Container               | :fontawesome-solid-xmark: | SLA Container (Object Permissions)                                                                                           |
| Name                    | :fontawesome-solid-xmark: | Name of the SLA                                                                                                              |
| Description             |                           | Description of the SLA                                                                                                       |
| Evaluation period       | :fontawesome-solid-xmark: | Day, Week, Month, Quarter, Year                                                                                              |
| Start date              |                           | Optional start date of the SLA                                                                                               |
| guaranteed availability | :fontawesome-solid-xmark: | Guaranteed availability percentage (90.5% for example).                                                                      |
| Warning threshold       |                           | Show a warning when the SLA availability is below this threshold                                                             |
| Operating time          | :fontawesome-solid-xmark: | Time period which will be used for the SLA calculation. Outages outside of this time period will not be counted.             |
| Consider downtimes      |                           | Determines whether maintenance times  (downtimes) should be taken into account. Outages during maintenance times are ignored |
| Reflection state        | :fontawesome-solid-xmark: | The status type to evaluate. Hard state only or hard and soft state                                                          |

#### Host and Service Assignment

After installing the SLA module, the configuration area of the host template or the host is extended with the SLA
option. The SLA can always be assigned to either the host template, meaning all hosts using this template are
automatically included in the SLA, or directly to the host.

It is also possible to exclude certain services from the SLA using the `SLA relevant` field. This can be done either via
the service template or directly on the service.

##### Host Assignment Rules

In addition to individual assignments, it is also possible to assign multiple hosts to an SLA. Through the `Assign to
hosts` menu item, there is an option to select multiple hosts simultaneously using specific filters.

![menu Assign to hosts](/images/sla/sla_assign_to_hosts.png)

By default, only hosts that are not assigned to any SLA are displayed in the list. The `Only unassigned hosts` switch
can be deactivated to disable this filtering. After clicking `Assign to hosts`, the corresponding SLA will be assigned
to
**all** hosts listed. If no service filter is set, all services will be considered within the SLA, in accordance with
the corresponding service template. However, if you need to override the settings of the service
template (`SLA relevant` field) or only want to select specific services, this can be achieved using a `Service RegEx`.

![Host mapping rules](/images/sla/sla_assign_to_hosts_filter.png)

The menu item `Affected hosts` shows a list of all hosts that have been assigned to the SLA, either directly or via the
host templates.

![menu Affected hosts](/images/sla/sla_menu_affected_hosts.png)

In this list you can see directly how the SLA was assigned. It is also possible to jump into the object configuration
to change the SLA assignment. For a better overview it is possible to filter by hostname.

![Affected hosts](/images/sla/sla_affected_hosts.png)

#### SLA Overview

As soon as the SLA is evaluated, the availability of the SLA is displayed in the SLA list.
By clicking on an SLA you get to the detail view. This view can also be reached via the drop down menu
item `View details`.

![SLA Oberview](/images/sla/sla_view_details.png)

This page shows the current availability of the entire SLA. The lowest value represents
the current availability of an SLA. In addition to the current availability, all relevant configuration details
and a summary is displayed. In the bar chart, the hosts are listed in ascending order with the lowest availability.

All hosts and their services are listed in the lower area. The order is also ascending so that
hosts with the lowest availability are listed first. The services are also sorted.
To enable searching for specific hosts, filters by hostname or availability have been added.

All hosts that are assigned to an SLA, will display the current availability as a badge in the `Hosts -> Browser` area.

![SLA availability badg for Host](/images/sla/sla_host_browser.png)

By clicking on the badge you can open a detailed overview for the particular host.

![SLA Host details](/images/sla/sla_host_browser_details.png)

The SLA details overview of a host, will also display the availability of the services that are associated with this
host.
The `Service -> Browser` page also contains a badge, which displays the service availability.

![SLA Service details](/images/sla/sla_service_browser_details.png)

The SLA service details overview does additionally contain a list of the last 10 days.

## SLA Host status overview for host groups

There is an overview page for the host groups that shows all the hosts included with their current SLA availability status in the form of a heat map. The hosts status overview is integrated as a tab in the extended view of the host group.   

![SLA Hostgroup Hosts Status Overview](/images/sla/sla_hostgroup_hosts_status_overview.png)

Hosts without availability status are displayed above this as `Not calculated`. The display leads to an overview of these hosts via a link.

![SLA Hostgroup Hosts Status Overview Non-calculated Hosts](/images/sla/sla_hostgroup_hosts_status_overview_not_calculated.png)

Hosts that are not assigned to an SLA are displayed as `Not in SLA`. The display leads to an overview of these hosts via a link.

![SLA Hostgroup Hosts Status Overview Not in SLA Hosts](/images/sla/sla_hostgroup_hosts_status_overview_not_sla.png)

The status is always displayed in ascending order. This means that the hosts with the lowest availability are displayed first. 

Each individual tile shows the current availability value and the minimum availability value in % and is linked to the SLA tab in `Hosts->Browser` (display: current availability value / minimum availability value %). If the minimum availability value is not reached, the tile is colored red, otherwise green.

The host name to which the values are assigned is shown below the availability values. 

![SLA Hostgroup Hosts Status Overview Tile](/images/sla/sla_hostgroup_hosts_status_overview_tile.png)

The heatmap can be exported as a CSV file via `Action`. 

The hosts can be filtered using the following fields:

* Hostname
* Availability (from, to)
* Container

![SLA Hostgroup Hosts Status Overview Filter](/images/sla/sla_hostgroup_hosts_status_overview_filter.png)

This overview can also be accessed directly via the host group overview by accessing the context menu of the elements or by clicking on the SLA label. Both are only displayed if the host group or its hosts are assigned to an SLA.  

![SLA Hostgroup Hosts Overview Page](/images/sla/sla_hostgroups_overview.png)