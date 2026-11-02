# Dashboard

The dashboard is the homepage for openITCOCKPIT.
The dashboard is the homepage for openITCOCKPIT and consists of only one tab by default.

### Adding dashboards

To add new tabs, click on the + symbol in the upper right-hand corner of the dashboard.

![](/images/dashboards-newdashboard.png)

This will open the following window:

![](/images/dashboards-newdashboardpopup.png)

To create an empty, new tab, enter a name for the tab at the top and then click on the <span class="badge badge-primary">Create new tab</span> button.

To create a tab from a template, select a shared tab from the list and then click <span class="badge badge-primary">Create from shared tab.</span>.

If you create a tab from a template and something about the template is then changed, the following dialog will appear when you next access the tab.

![](/images/dashboards-sharing-update.png)

You can now choose whether you want to update your tab or not.

### Sharing dashboards

In openITCOCKPIT you have the ability to split tabs. To do this, first click on the downward arrow (1) on a dashboard tab and then on Start sharing.

The shared dashboards will then be available to other users in openITCOCKPIT.

![](/images/dashboards-sharing.png)

If a dashboard is already shared, the selection list will show the option <span class="badge badge-default">Stop sharing</span>. This can be used to stop sharing the dashboard tab again.

### Dashboard rotation

The dashboard rotation feature makes all existing dashboard tabs be displayed one after the other at a user-defined interval of between 10 seconds and 15 minutes.

When used with full-screen mode for dashboards, this can be useful for displaying openITCOCKPIT on a TV, etc.

### Deleting dashboards

To delete a dashboard, first click on the downward pointing arrow (1) on a dashboard tab and then on <span class="badge badge-danger">Delete</span> (2).

![](/images/dashboards-delete.png)

### Adding widgets

To add a new widget to a dashboard, click the <span class="badge badge-success">Add widget</span> button.

![](/images/dashboards-addwidget.png)

A list with all available widgets will then appear.

After you have added the corresponding widget, you may need to configure it.

![](/images/dashboard-widgetconfig.png)

After saving the widget configuration, the widget will be displayed with its content.

#### Widgets

##### Welcome
![welcome widget](/images/dashboard-welcomewidget.png)

Displays the total number of monitored hosts and services visible to a user. The user time zone, openITCOCKPIT version and edition are also displayed.

##### Overall failures
![parent outages widget](/images/dashboard-parentoutageswidget.png)

Shows a list of all inaccessible, linked parent objects.

##### Host/service pie chart (180)
![hosts services piecharts](/images/dashboard-host-services-piecharts.png)

Depending on the option selected, this shows half or full pie charts of all hosts or services and their statuses. Clicking on the status colour below the diagram will open a list displaying the hosts or services in the status selected.

##### Traffic light
![traffic light widget](/images/dashboard-trafficlightwidget.png)

Displays the status colour for a service

###### Configuration

A service must be selected for its status to be displayed. The widget configuration interface can be accessed via the gear symbol in the upper right area of the widget.

##### Speedometer widget
![speedometer widget](/images/dashboard-tachowidget.png)

Displays the value of a performance data record for a service. Threshold values are additionally marked in colour.

###### Configuration

A service as well as a performance data set must be selected. The widget configuration interface can be accessed via the gear symbol in the upper right area of the widget.

##### Notice
![notice widget](/images/dashboard-noticewidget.png)

The notice widget can display text, HTML or Markdown language.

###### Configuration

Text, HTML or Markdown can be inserted into the text field. The widget configuration interface can be accessed via the gear symbol in the upper right area of the widget.

##### Host/service in maintenance
![host service downtime widget](/images/dashboard-hostservicedowntimewidget.png)

The Host or Service in Maintenance widget displays hosts or services that are down for maintenance.

###### Configuration

Using the configuration interface, this can be filtered according to hosts or services and the maintenance comments. The maintenance times can also be hidden or displayed via various options. The widget configuration interface can be accessed via the gear symbol in the upper right area of the widget.

##### Host status/service status list
![host service status lists](/images/dashboard-hostservicestatuslists.png)

Displays a filterable list of hosts or services. These lists contain the status, current maintenance times, acknowledgements, the time the status occurred as well as the host or service output. The list can scroll automatically at a user-defined interval.

###### Configuration

Host or service status lists can be filtered by host name or host and service name as well as by output. In addition, various options are available, for example for filtering by status, maintenance times or status confirmations. The widget configuration interface can be accessed via the gear symbol in the upper right area of the widget.

##### Host status/service status overview
![host servicestatus overview](/images/dashboard-hostservicestatusoverview.png)

The host or service status overview widget shows the number of hosts or services in a given status (for example UP/OK).

###### Configuration

The host or service status overview only shows the number of hosts or services in the selected status. This selection can be made via the widget configuration interface. It is also possible to filter according to the host or host and service name. The widget configuration interface can be accessed via the gear symbol in the upper right area of the widget.

##### Host/Service Top Alerts
![host service top alerts](/images/server-Top-alerts.png)

The Host or Service Top Alerts widgets show the notification alerts for the configured status within the retroactively configured time period. 
It is grouped by number and most recent date. Count here refers to the number of alarms themselves and not the number of notifications sent. So if 20 people have been notified of an alarm, only 1 alarm will be counted. Otherwise, it will distort the display of the actual alarms.

###### Configuration
The widgets can be configured according to status and the period to be viewed.

##### Automap
![automap widget](/images/dashboard-automapwidget.png)

The widget displays the [automap](../maps/#automap) an

###### Configuration

The automap must be created beforehand using the [automap](../maps/#automap) function. Once this has been done, a map can be selected in the widget configuration. In addition, you can select how many elements are to be displayed on one page in the widget. The widget configuration interface can be accessed via the gear symbol in the upper right area of the widget.

##### Autoreport overview
![Autoreport overview widget](/images/dashboard-autoreportoverviewwidget.png)

This widget shows an availability indicator for a previously created [autoreport](../../reporting/reporting/#autoreports-ce) an. 

###### Configuration

The widget requires a previously created [autoreports](../../reporting/reporting/#autoreports-ce). This report can then be selected in the widget's configuration interface. Options for displaying availability, log data and dynamic colouring are also available. The widget configuration interface can be accessed via the gear symbol in the upper right area of the widget.

##### Grafana (automatically generated)

The widget displays automatically generated Grafana dashboards.

###### Configuration

Automatically generated Grafana dashboards can be selected via the host name in the widget configuration area. The widget configuration interface can be accessed via the gear symbol in the upper right area of the widget.

##### Grafana (user-defined)
![grafana userdefined](/images/dashboard-grafanauserdefinedwidget.png)

The widget displays custom [Grafana dashboards](../graphing/#grafana).

###### Configuration

Custom Grafana dashboards must be created beforehand using the [Grafana module](../graphing/#grafana). Once this has been done, a dashboard can then be selected via the widget configuration interface. The widget configuration interface can be accessed via the gear symbol in the upper right area of the widget.

##### Map (MapModule)
![Map module widget](/images/dashboard-mapmodulewidget.png)

The map widget displays a map created using the [MapModule](../maps/#map-module-ce).

###### Configuration

A map must be created beforehand using the [MapModule](../maps/#map-module-ce) The map can then be selected using the widget configuration interface. The widget configuration interface can be accessed via the gear symbol in the upper right area of the widget.

##### Event correlation
![evk widget](/images/dashboard-evkwidget.png)

The widget displays a previously created [event correlation](../eventcorrelation/#event-correlation-ce).

###### Configuration

An event correlation must be created beforehand via the [EventCorrelationModule](../eventcorrelation/#event-correlation-ce). The event correlation can then be selected using the widget configuration interface. The widget configuration interface can be accessed via the gear symbol in the upper right area of the widget.

### Deleting widgets

To delete a widget, simply click on the <span class="badge badge-danger">x</span> symbol of the corresponding widget.

![delete widget](/images/dashboards-widgetdelete.png)


### Restore defaults

To restore the defaults for a dashboard tab, click the <span class="badge badge-default">Restore Defaults</span> button in the adding dashboard widgets list.

![restore default](/images/dashboard-restoredefault.png)
