# openITCOCKPIT-Desktop
Die openITCOCKPIT-Desktop-App ist eine Standalone-Application, die auf jedem modernen Betriebssystem installiert werden kann und einen Überblick über aktuelle Überwachungsereignisse und Statusaktualisierungen bietet. openITCOCKPIT-Desktop nutzt die openITCOCKPIT HTTP API zur Kommunikation mit dem openITCOCKPIT Server.

## Dashboard
![dashboard](../images/oitc-desktop/desktop-app-dashboard.png)

Das Dashboard besteht aus der Übersichtsseite plus weiteren Ansichten (Alarme, Statusseiten), die oben rechts über die Tabs erreichbar sind.


#### Übersicht
Der erste Abschnitt der Dashboardübersicht, zeigt den Gesamtstaus der Hosts und Services an. Dieser Abschnitt ist immer vorhanden.
Durch Anklicken der entsprechenden Einträge kann vertieft werden.

#### Ressourcenübersichts-Widget *
![dashboard](../images/oitc-desktop/desktop-scm-widget.png)
Besitzt der Benutzer in seinem ***openITCOCKPIT Server Dashboard*** ein Ressourcenübersichts-Widget, so wird dieses auf dieser Seite auch angezeigt - direkt nach der generellen Übersicht.
Per Klick auf die entsprechenden Statuseinträge (größer 0) kann auf die ensprechenden Ressourcen vertieft werden.

!!! info
    Das Ressourcenübersichts-Widget erscheint nur auf der mobilen Dashboardübersicht, wenn es auch im openITCOCKPIT Server Dashboard vorhanden ist.

#### Taktische Übersichten
Sind im Server Dashboard des Users taktische Übersichten konfiguriert, so werden diese auch hier angezeigt.
Durch Anklicken der entsprechenden Einträge kann vertieft werden.
!!! info
    Es werden die - **und nur die** - taktischen Übersichten angezeigt, die im openITCOCKPIT-Backend Dashboard des Users konfiguriert sind.

#### Änderungskalender
Sind auf dem Server Änderungskalender definiert, auf die der angemeldete User Zugriff hat, so werden diese hier auch angezeigt
Die Anzeige der einzelnen Kalener ist konfigurierbar.

#### Top Alarme
![dashboard](../images/oitc-desktop/desktop-top-alerts.png)

Hier werden die Benachrichtigungen der letzten 24 Stunden mit dem entstechenden Status angezeigt. 
Das jeweilige Widget beinhaltet eine Liste, durch die gescrollt werden kann.
Die Liste ist sortiert nach der Anzahl und dem letzten (aktuellen Datum) der Benachrichtigung(en). Anzahl bedeutet hier nicht die Anzahl der benachrichtgten Kontakte,
sondern die Anzahl der Benachrichtigungen zu diesem Host(Service) selbst.
Durch Anklicken des enstprechenden Hosts(service) wird auf die Benachrichtigungs-Log Ansicht verlinkt, wo dann zu sehen ist, welche Kontakte auf welchem Weg benachrichtigt worden sind.

#### Statusseiten
![dashboard](../images/oitc-desktop/desktop-statuspages.png)

Sind im OITC-Backend Statusseiten konfiguriert, so werden diese hier nach höchstem kumuliertem Status sortiert (s. Reporting->Statusseiten) angezeigt.


## Installation
* Es stehen für jedes Betriebssystem - Linux, Windows, Macos - entsprechende Installationspakete zur Verfügung.
* Es kann in der App eingestellt werden, dass beim Start - oder manuell über die Settingsseite - automatisch nach Updates gesucht wird.

## Anwendung
### Login

![login](../images/oitc-desktop/login.png)

Im ersten Feld `Ihre Server-URL` geben Sie bitte die URL oder IP-Adresse Ihres openITCOCKPIT Systems an.
Im zweiten Feld geben sie den Api-Key eines Benutzers des openITCOCKPIT Systems ein.
#### Erstellung des API Keys
Um sich einloggen zu können, müssen Sie zunächst einen API Key auf
Ihrem openITCOCKPIT System erstellen ([siehe API Key erstellen](../../development/api/#api-keys)). Den Key können Sie einfach im Feld `Ihr Api-Key` einfügen.

#### Autologin
Ist auto login eingestellt (default) werden die Logindaten nach erfolgreichem Login automatisch gespeichert und beim nächsten Start der Application erfolgt das Login automatisch.

#### Profile
Über das Dropdown auf der Loginseite könnensie verschiedene Profile anlegen.
Alle Einstellungen, die sie in der App vornehmen, werden in dem gerade aktiven Profil gespeichert.

Nach erfolgreichem Login werden Sie auf das Dashboard weitergeleitet.

### Settings
Sämtliche Einstellungen auf der Settingsseite werden automatisch gespeichert!
![settings](../images/oitc-desktop/settings.png)

* **Enable auto start**
Die Anwendung wird beim Start des Bestriebssystem mitgestartet (beta)

* **Close to tray**
Beim Schliessen der Anwendung über die Anwendungsleiste wird die Anwendung nicht beendet sondern nur versteckt, kann über das Tray-Icon menü wieder zur Anzeige gebracht werden.

* **Show widget on start**
Das Widget wird beim Starten der Anwendung angezeigt.

* **Show only widget on start**
Beim Starten der Anwendung wird nur das Widget zur Anzeige gebracht.
Die Hauptanwendung kann über das Menü im Tray zur Anzeige gebracht werden.

* **State refresh interval**
Das interval der Abfrage der Daten für das Widget und das Dashboard (min. 1 Minute).

* **Use slow pagination in lists**
Umschalten der Paginierung

* **Activate widget position storage**
Speichert  automatisch die Position des Widgets

* **Activate window posisiton storage**
Speichert automatisch die Postion und Größe der Anwendung

* **Disable automatic update checks**
Schaltet den Updatecheck beim Start der App aus.

* **Enable push notifications**
Schaltet Pushbenarichtigungen an/aus.

* **Enable dark mode**
ON/OFF schalten den Dark Mode explizt an/aus. Auto schaltet den Modus anhand der Betriebssystemeinstellung.

* **Auto login enabled**
Die Anwendung loggt sich beim Start automatisch mit den letzten aktiven Anmeldedaten (Profil) ein.

* **Logout**
Die Anwendung loggt sich aus und springt zur Loginseite, etwa um das Profil zu wechseln oder zu editieren.

* **Check & save**
Prüft und speichert die Anmeldedaten des aktiven Profils

* **Check for update**
Expliziter Check ob ein Update für die App vorhanden ist.

### Widget settings
* Über den **Widget settings** Tab auf der Settingsseite kann der Filter für das Widget definiert werden und die Reihenfolge der Widgetanzeige per Drag & Drop bestimmt werden.
![tray](../images/oitc-desktop/widget-settings.png)

### Widget
* Die zweite Zeile des Widgets zeigt die unhandled Anteile.
* Mit Hilfe des Icons kann das Widget positioniert werden.
* Beim Klicken uf einen Widgeteintag wird die entsprechende List in der Anwendung zur Anzeige gebracht.
![widget](../images/oitc-desktop/widget.png)

### Custom Widgets
Mit Version 4.6.9 der openITCOCKPIT-Desktop App ist die Möglichkeit geschaffen worden, beliebig viele Widgets zu konfigurieren und anzuzeigen.
#### Verwaltung
![widget-verwaltung](../images/oitc-desktop/widget-administration.png)
#### Konfiguration
![widget-configuration](../images/oitc-desktop/custom-widgets-config.png)
Die Konfiguration der Widgets ist um die gekennzeichneten Felder erweitert worden. Die neuen Filter benötigen das openITCOCKPIT-Backend 4.7.0.
#### Anzeige
![widgets-show](../images/oitc-desktop/custom-widgets.png)

### Tray
![tray](../images/oitc-desktop/tray.png)
Über das Trayicon (Rechtsclick) können ebenfalls einige Einstellungen vorgenommen werden.

## Personalisierung

Die openITCOCKPIT-Desktop Anwnedung ist in der Lage, sich der Identität des jeweiligen Unternehmens anzupassen.
Dazu können das Appicon (Anwendungleiste, Tray, Widget), das Logo der Loginseite und das Hintergrundbild der Loginseite getauscht werden.

![assets](../images/oitc-desktop/custom-assets.png)

Dazu muss innerhalb des Konfigurationsverzeichnisses der Anwendung ein Ordner names **customAssets** angelegt (verlinkt) werden.

Das Konfigurationsverzeichnis liegen je nach Betriebssystem an folgenden Orten:

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
Innerhalb des Ordners customAssets müssen folgende Dateinamenkonventionen beachtet werden:

**Icon**: favicon.png
Nur png als Endung erlaubt.
Je nach Betriebssystem sollten die Dimensionen etwas anders sein:
Windows: mindestens 64x64, besser 256x256
Linux: gilt dasselbe wie für Windows
OSX: maximal 32x32, besser 16x16 - da sonst das Icon oben in der Leiste zu groß wird.

**logo**: logo.png (.svg,.jpg)
Auflösung beliebig, da skaliert wird

**background**: background.png (.svg, .jpg)
Auflösung im Prinzip auch beliebig, da skaliert wird, sollte aber mindestens FullHD sein.

## Hosts, Services

Die Host-, Services-Views und ihre Detailseiten sind von den entsprechenden Seiten der Weboberfläche des oitc-Servers abgeleitet und werden deshalb hier nicht näher ausgeführt.
### Hostslist
![hostslist](../images/oitc-desktop/hostlist.png)
### Hostbrowser
![hostbrowser](../images/oitc-desktop/hostbrowser.png)
### Serviceslist
![serviceslist](../images/oitc-desktop/servicelist.png) 
### Servicebrowser
![servicebrowser](../images/oitc-desktop/servicebrowser.png)

## Weitere Ansichten

### Benachrichtigungs-Log
![notification-log](../images/oitc-desktop/desktop-notifications.png)
### Downtimes
![downtimes](../images/oitc-desktop/desktop-downtimes.png)
![systemdowntimes](../images/oitc-desktop/desktop-systemdowntimes.png)
### Gruppen
#### Hostgruppen
![hostgroup](../images/oitc-desktop/desktop-hostgroup.png)
![hostgroup-extended](../images/oitc-desktop/desktop-hostgroup-extended.png)
#### Servicegruppen
![sevicegroup](../images/oitc-desktop/desktop-servicegroups.png)
![servicegroup-extended](../images/oitc-desktop/desktop-servicegroups-extended.png)
### RessourcenCenter
Siehe [Resource Center Server Dokumentation](../../configuration/resource-center/)
#### Ressourcen
![resources](../images/oitc-desktop/desktop-resources.png)
![resources-statuslog](../images/oitc-desktop/desktop-resources-statuslog.png)
![resources-setstatus](../images/oitc-desktop/desktop-resources-setstatus.png)

#### Ressourcengruppen
![resourcegroup](../images/oitc-desktop/desktop-resources.png)
![resourcegroup-summary](../images/oitc-desktop/desktop-resourcegroup-summary.png)
![resourcegroup-notifications](../images/oitc-desktop/desktop-resourcegroup-notifications.png)

Die weiteren Ansichten sind -  soweit ausgeführt - aus dem Server übernommen worden.

#### Bekannte Probleme
!!! info
    Wenn Sie Ihren Bildschirm mit Microsoft Teams übertragen, kann es passieren, das die Widgets teilweise im Hintergrund verschwinden.
    Das Problem kann durch einen Neustart der openITCOCKPIT Desktop Anwendung behoben werden.


