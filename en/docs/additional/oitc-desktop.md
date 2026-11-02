# openITCOCKPIT-Desktop
The openITCOCKPIT desktop app is a standalone application that can be installed on any modern operating system and provides an overview of current monitoring events and status updates. openITCOCKPIT desktop uses the openITCOCKPIT HTTP API to communicate with the openITCOCKPIT server.

## Dashboard
![dashboard](../images/oitc-desktop/desktop-app-dashboard.png)

The dashboard consists of the overview page plus further views (alarms, status pages) that can be reached over the tabs in the top right.

#### Overview
The first section of the dashboard overview shows the total congestion of the hosts and services. This section is always available.
You can go into more detail by clicking on the corresponding entries.

#### Resource overview widget *
![dashboard](../images/oitc-desktop/desktop-scm-widget.png)
If the user has a resource overview widget in his ***openITCOCKPIT Server Dashboard***, this will also be displayed on this page - straight after the general overview section. By clicking on the corresponding status entries (greater than 0), you can delve into the corresponding resources.

!!! info
    The Resource overview widget only appears on the mobile dashboard overview if it is also present in the openITCOCKPIT Server Dashboard.


#### Takctical Overviews
If tactical overviews are configured in the server dashboard of the user, they are also displayed here.
Clicking the corresponding entries can be deepened.

#### Changeclendar
If change calendars are defined on the server to which the logged-in user has access, these are also displayed here
The display of the individual calendars can be configured.

#### Top Alerts(Notifications)
![dashboard](../images/oitc-desktop/desktop-top-alerts.png)

The notifications of the last 24 hours are displayed here with their status.
The respective widget contains a list that can be scrolled through.
The list is sorted according to the number and the last (current date) of the notification(s). Number here does not mean the number of contacts notified,
but the number of notifications for this host (service) itself.
Clicking on the corresponding host(service) links to the notification log view, where you can then see which contacts have been notified and how.
#### Statusseiten
![dashboard](../images/oitc-desktop/desktop-statuspages.png)

If status pages are configured in the OITC backend, they are sorted here according to the highest cumulative status (see reporting-> status pages).


## Installation
* Appropriate installation packages are available for every operating system - Linux, Windows, MacOS.
* The app can be set to automatically search for updates when it starts - or manually via the settings page.

## Usage

### Login

![login](../images/oitc-desktop/login.png)

In the first field `your server URL` enter the URL or IP address of your openITCOCKPIT system.
In the second field, enter the API key of a user of the openITCOCKPIT system.

#### Creation of API Keys
In order to be able to log in, you must first obtain an API key created in your openITCOCKPIT system ([siehe API Key erstellen](../../development/api/#api-keys)). You can simply enter the key in the `Your Api-Key` field.

#### Autologin
If auto login is set (default), the login data will be saved automatically after a successful login and the login takes place automatically the next time the application is started.

#### Profile
You can create different profiles via the dropdown on the login page.
All settings you make in the app are saved in the currently active profile.

After successfully log in, you will be redirected to the dashboard.

### Settings
All settings on the settings page are saved automatically!
![settings](../images/oitc-desktop/settings.png)

* **Enable auto start**
The application is started when the operating system is started (beta)

* **Close to tray**
When closing the application via the application bar, the application is not terminated but only hidden, can be displayed again via the tray icon menu.
* **Show widget on start**
The widget is displayed when the application starts.

* **Show only widget on start**
When starting the application, only the widget is displayed.
![widget](../images/oitc-desktop/widget.png)
The main application can be displayed via the menu in the tray.

* **State refresh interval**
Interval of data retrieval for widget and dashboard (min. 1 minute).

* **Use slow pagination in lists**
Switch the pagination type

* **Activate widget position storage**
Automatic save of the position of the widget

* **Activate window posisiton storage**
Automatic save of the application position and size

* **Disable automatic update checks**
Turns off the update check when starting the app.

* **Enable push notifications**
Turns push notifications on/off.

* **Enable dark mode**
ON/OFF switch Dark Mode explicitly on/off. Auto switches the mode based on the operating system setting.

* **Auto login enabled**
The application automatically logs in with the last active login data (profile) when it is started.

* **Logout**
The application logs out and jumps to the login page, for example to change or edit the profile.

* **Check & save**
Checks and saves the credentials of the active profile

* **Check for update**
Explicit check whether an update is available for the app.

### Widget settings
* Via the **Widget settings** tab on the settings page, the filter for the widget can be defined and the order of the widget display can be determined using drag & drop.
![tray](../images/oitc-desktop/widget-settings.png)

### Widget
The second line of the widget shows the unhandled shares.
The widget can be positioned using the icon.
Clicking on a widget entry brings up the corresponding list in the application.
  ![widget](../images/oitc-desktop/widget.png)

### Custom Widgets
With version 4.6.9 of the openITCOCKPIT-Desktop App it is possible to configure and show any number of widgets.
#### Administration
![widget-verwaltung](../images/oitc-desktop/widget-administration.png)
#### Configuration
![widget-configuration](../images/oitc-desktop/custom-widgets-config.png)
The configuration is extended by the marked Fields. To process this new filter fields the  openITCOCKPIT-Backend 4.7.0 is needed.
#### Display
![widgets-show](../images/oitc-desktop/custom-widgets.png)

### Tray
![tray](../images/oitc-desktop/tray.png)
Some settings can also be made via the tray icon (right-click).

## Customization
The openITCOCKPIT desktop application is able to adapt to the identity of the respective company.
For this case the app icon (application bar, tray, widget), the logo of the login page and the background image of the login page can be changed.
![assets](../images/oitc-desktop/custom-assets.png)

To do this, a folder named **customAssets** must be created (linked) within the configuration directory of the application.

Depending on the operating system, the configuration directory is in the following locations:

Windows
```bash
c:\Benutzer\<user>\AppData\Roaming\openITCOCKIT-Desktop
```
OSX
```bash
/users/<user>/Library/Application Support/openITCOCKIT-Desktop
```
Linux
```bash
/home/<user>/.config/openITCOCKIT-Desktop
```

### customAssets
Within the customAssets folder, the following file naming conventions must be observed:

**Icon**: favicon.png
Only png as Endung allowed.
Depending on the operating system, the dimensions should be slightly different:
Windows: min. 64x64, better 256x256
Linux: same as  Windows
OSX: max. 32x32, better 16x16 - otherwise the icon at the top of the bar will be too big.

**logo**: logo.png (.svg,.jpg)
Any resolution, since it is scaled

**background**: background.png (.svg, .jpg)
Resolution in principle also arbitrary, since it is scaled, but it should be at least FullHD.

## Hosts, Services

The host and services views and their detail pages are derived from the corresponding pages of the oitc server's web interface and are therefore not explained in more detail here.
### Hostslist
![hostslist](../images/oitc-desktop/hostlist.png)
### Hostbrowser
![hostbrowser](../images/oitc-desktop/hostbrowser.png)
### Serviceslist
![serviceslist](../images/oitc-desktop/servicelist.png)
### Servicebrowser
![servicebrowser](../images/oitc-desktop/servicebrowser.png)

### Other Views
### Notification-Log
![notification-log](../images/oitc-desktop/desktop-notifications.png)
### Downtimes
![downtimes](../images/oitc-desktop/desktop-downtimes.png)
![systemdowntimes](../images/oitc-desktop/desktop-systemdowntimes.png)
### Groups
#### Host groups
![hostgroup](../images/oitc-desktop/desktop-hostgroup.png)
![hostgroup-extended](../images/oitc-desktop/desktop-hostgroup-extended.png)
#### Service groups
![sevicegroup](../images/oitc-desktop/desktop-servicegroups.png)
![servicegroup-extended](../images/oitc-desktop/desktop-servicegroups-extended.png)
### Resource center
See [Resource Center Server Dokumentation](../../configuration/resource-center/)
#### Resources
![resources](../images/oitc-desktop/desktop-resources.png)
![resources-statuslog](../images/oitc-desktop/desktop-resources-statuslog.png)
![resources-setstatus](../images/oitc-desktop/desktop-resources-setstatus.png)

#### Resource groups
![resourcegroup](../images/oitc-desktop/desktop-resources.png)
![resourcegroup-summary](../images/oitc-desktop/desktop-resourcegroup-summary.png)
![resourcegroup-notifications](../images/oitc-desktop/desktop-resourcegroup-notifications.png)

The other views have - as far as stated - been taken from the server.

#### Known Issues

!!! info
    When you share your screen using Microsoft Teams it can happen that the Widgets of openITCOCKPIT Desktop go into the background.
    You can resolve the issue by restarting the openITCOCKPIT Desktop application.
