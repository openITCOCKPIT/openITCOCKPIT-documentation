# Mobile Webseite  <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## Installation

Die Mobile Webseite ist so konzipiert, dass Sie auf einem eigenen Server betrieben werden kann.

Um eine Instanz der Mobilen Webseite zu erzeugen, benötigen Sie eine openITCOCKPIT Enterprise Lizenz, welche Sie
berechtigt, die Mobile Webseite zu installieren. Bitte Kontaktieren Sie uns über unser [Sales-Kontaktformular](https://avendis.com/kontakt/)

Sind die voraussetzungen dafür geschaffen, benötigen Sie auf ihrem neuen System Docker.

### Authentifizierung und herunterladen des Images
Bevor Sie das Docker image herunterladen können, müssen Sie sich bei unserer Docker Registry anmelden:

```bash
docker login https://cr.openitcockpit.io
```

Der Befehl fordert Sie auf, einen Benutzernamen sowie ein Passwort einzugeben.
Als Benutzername geben Sie bitte die E-Mail-Adresse ein, welche mit Ihrem openITCOCKPIT Enterprise Lizenzschlüssel
registriert ist. Als Passwort geben Sie Ihren Lizenzschlüssel ein.

Nach erfolgreicher Authentifizierung können Sie das Docker image herunterladen:

```bash
docker pull cr.openitcockpit.io/openitcockpit-mobile
```

### Docker container starten
Den Container können Sie mit folgendem Befehl starten:

```bash
docker run --rm -it -p 4443:443 -p 8898:80 --name mobile cr.openitcockpit.io/openitcockpit-mobile
```

Danach können Sie die Seite mit Ihrem Mobilen Endgerät öffnen:

```text
https://<hostname oder IP adresse>:4443
```

#### Bekannte Probleme

!!! info
    Wegen Api-Anpassungen benötigt die Version 1.7 der mobilen Webseite mindestens openITCOCKPIT Version 4.8.1 als Backend.

## Benutzung

![login](/images/mobile-website/login-screen.png){ width="300" }

### Login
Nach erfolgreicher Installation können Sie nun mit Ihrem Smartphone oder Tablet die entsprechende Webseite öffnen und
gelangen damit auf die Login seite.

Im Feld `Ihre Server-URL` geben Sie bitte die URL oder IP-Adresse Ihres openITCOCKPIT Systems an.

#### Erstellung des API Keys
Um sich einloggen zu können, müssen Sie zunächst einen API Key zur nutzung der Mobile webseite auf
Ihrem openITCOCKPIT System erstellen ([siehe API Key erstellen](../../development/api/#api-keys)). Zum einfacheren
übertragen des API Keys auf das Mobile endgerät, scannen Sie einfach den QR-Code mit einem entsprechendem
QR-Code Scanner und kopieren sie den API-Key. Den kopierten Key können Sie einfach im Feld `Ihr Api-Key` einfügen.

Nach erfolgreichem Login werden Sie auf das Dashboard weitergeleitet.

### Dashboard

![dashboard](/images/mobile-website/mobile-dashboard-de.png){ width="300" } | ![dashboard](/images/mobile-website/mobile-dashboard-with-resources-de.png){ width="300" }

Das Dashboard ermöglicht eine schnelle Übersicht über den Zustand Ihrer Infrastruktur.  
Es kann bei jedem Element, das auf dem Dashboardseiten angezeigt wird, durch Anklicken zu den entsprechenden Detailseiten vertieft werden.
Auf jeder Seite, auf die vertieft werden kann befindet sich oben links ein Zurückzeichen(<), über das zum Dashboard zurückgekehrt werden kann, das geht auch über mehrere Vertiefungen.

#### Übersicht
Die Dashboardübersicht zeigt den Gesamtstaus der Hosts und Services an.
Dieser Abschnitt ist immer vorhanden.
Die Übersicht zeigt die Anzahl der Hosts und Services, die in den jeweiligen Status fallen.
Unbehandelte Hosts und Services werden in ihren jeweiligen Spalten extra angezeigt.  
Mit einem Klick auf den jeweiligen status, gelangen Sie zu der entsprechend gefilterten Host oder Service Liste.
Durch Anklicken der entsprechenden Einträge kann vertieft werden.  

##### Ressourcenübersichts-Widget *
Besitzt der Benutzer in seinem ***openITCOCKPIT Server Dashboard*** ein Ressourcenübersichts-Widget, so wird dieses auf dieser Seite auch angezeigt - noch vor der Übersicht.
Per Klick auf die entsprechenden Statuseinträge (größer 0) kann auf die ensprechenden Ressourcen vertieft werden.  

!!! info
    Das Ressourcenübersichts-Widget erscheint nur auf der mobilen Dashboardübersicht, wenn es auch im openITCOCKPIT Server Dashboard vorhanden ist.  


#### Taktische Übersichten *
![dashboard](/images/mobile-website/tacticals-mobile.png){ width="300" }


!!! info
    Es werden die - **und nur die** - taktischen Übersichten angezeigt, die im openITCOCKPIT-Backend Dashboard des Users konfiguriert sind.

Unter den taktischen Übersichten werden die im openITCOCKPIT-Backend Dashboard des Users konfigurierten taktischen Übersichten angezeigt.
Werden in den Statusicons Einträge angezeigt - größer 0 - kann durch Anklicken auf die entsprechende Liste (Hosts, Services) vertieft werden, gleiches gilt für die Details Buttons.
Sind im Server Dashboard keine konfiguriert, dann werden hier auch keine angezeigt!

#### Alarme (Benachrichtigugen)
![dashboard](/images/mobile-website/mobile-notifications-de.png){ width="300" }

Hier werden die Benachrichtigungen der letzten 24 Stunden mit dem entsprendem Status angezeigt. Ein entsprechendes Widget wird nur angezeigt, 
wenn es in diesem Zeitraum auch Benachrichtigungen dazu gab. 
Das jeweilige Widget beinhaltet eine Liste, durch die gescrollt werden kann - es werden maximal 25 Einträge angezeigt. 
Die Liste ist sortiert nach der Anzahl und dem letzten (aktuellen Datum) der Benachrichtigung(en). Anzahl bedeutet hier nicht die Anzahl der benachrichtgten Kontakte, 
sondern die Anzahl der Benachrichtigungen zu diesem Host(Service) selbst.  
Die Auswertung der Alarme steht ab openITCOCKPIT Version 4.8.3 zur Verfügung.

#### Statusseiten
![dashboard](/images/mobile-website/mobile-statuspages-de.png){ width="300" }
Sind im openITCOCKPIT-Backend Statusseiten konfiguriert, so werden diese hier nach höchstem kumuliertem Status sortiert (s. Reporting->Statusseiten) angezeigt.



### Funktionen

#### Ressourcenstatus setzen
Ist auf dem openItcockpit Server das SCM-Module installiert, dann wird die Ressourcenliste ebenfalls auf der mobilen Seite angzeigt.
Dort kann dann der Ressourcenstatus neu gesetzt werden.
![dashboard](/images/mobile-website/mobile-resources.png){ width="300" } | ![dashboard](/images/mobile-website/mobile-resource-form.png){ width="300" }

Zu den Ressourcengruppen können Detailinformationen aufgerufen werden ![dashboard](/images/mobile-website/mobile-resourcegroup.png){ width="300" }

#### Prüfzeit zurücksetzen (Reset Check time) <span class="badge badge-info badge-outlined" title="Host">Host</span> <span class="badge badge-info badge-outlined" title="Host">Service</span>
Wählen Sie den gewünschten Host oder Service aus der jeweiligen Liste aus und klicken Sie anschließend auf den Reiter
`Aktionen`. Danach klicken Sie die Schaltfläche `Prüfzeit zurücksetzen`. Die Aktion wird sofort ausgeführt und benötigt
keine weiteren Informationen.

Weitere informationen zu [Prüfzeitraum zurücksetzen](../../monitoring/user-interface/#prufzeitraum-zurucksetzen)

![host details actions](/images/mobile-website/hosts-details-actions.png){ width="250" }


#### Wartungszeitraum planen (Downtime) <span class="badge badge-info badge-outlined" title="Host">Host</span> <span class="badge badge-info badge-outlined" title="Host">Service</span>
Wählen Sie den gewünschten Host oder Service aus der jeweiligen Liste aus und klicken Sie anschließend auf den Reiter `Aktionen`.
Danach klicken Sie die Schaltfläche `Plane Wartung`.

Danach verfahren Sie wie im Abschnitt [Wartungszeit erstellen](#wartungszeit-erstellen) beschrieben.

Hier können keine wiederkehrenden Wartungszeiten eingerichtet
werden. Wie Sie eine wiederkehrende Wartungszeit einrichten können, wird im Abschnitt
[wiederkehrende Wartungszeit erstellen](#wiedekehrende-wartungszeit-erstellen) erläutert.

Weitere Informationen zu [Plane Wartung](../../monitoring/user-interface/#plane-wartung)

#### Status bestätigen (Acknowledgement) <span class="badge badge-info badge-outlined" title="Host">Host</span> <span class="badge badge-info badge-outlined" title="Host">Service</span>
Wählen Sie den gewünschten Host oder Service aus der jeweiligen Liste aus und klicken Sie anschließend auf den Reiter `Aktionen`.
Danach klicken Sie die Schaltfläche `Status bestätigen`.

Haben Sie einen Host ausgewählt, so haben Sie die möglichkeit den Status für den Host oder den Host und seine Services
zu bestätigen.

Weitere Informationen zu [Hoststatus bestätigen](../../monitoring/user-interface/#bestatige-hoststatus)

#### Flattererkennung ein/ausschalten (Flapping) <span class="badge badge-info badge-outlined" title="Host">Host</span> <span class="badge badge-info badge-outlined" title="Host">Service</span>
Wählen Sie den gewünschten Host oder Service aus der jeweiligen Liste aus und klicken Sie anschließend auf den Reiter `Aktionen`.
Danach klicken Sie die Schaltfläche `Aktiviere Flattererkennung`.

Weitere Informationen zu [Flap Detection](../../configuration/hosts-services/#flap-detection)


#### Benachrichtigungen ein/ausschalten (Notifications) <span class="badge badge-info badge-outlined" title="Host">Host</span> <span class="badge badge-info badge-outlined" title="Host">Service</span>
Wählen Sie den gewünschten Host oder Service aus der jeweiligen Liste aus und klicken Sie anschließend auf den Reiter `Aktionen`.
Danach klicken Sie die Schaltfläche `Benachrichtigungen ein/ausschalten`.

Mit dieser Option können Sie Benachrichtigungen für den Host oder den Host und seine Services vorübergehend deaktivieren.
Ist ein Service ausgewählt, so wird entsprechend nur die Benachrichtigungen für den Service vorübergehend deaktiviert.

#### Passive Übertragung eines Prüfergebnisses (Passive transfer check result) <span class="badge badge-info badge-outlined" title="Host">Service</span>
Wählen Sie den gewünschten Service aus der Service Liste aus und klicken Sie anschließend auf den Reiter `Aktionen`.
Danach klicken Sie die Schaltfläche `Passive Übertragung eines Prüfergebnisses`.

Weitere Informationen zu [passive Übertragung eines Prüfergebnisses für Services](../../monitoring/user-interface/#passive-ubertragung-eines-prufergebnisses_1)

#### Benutzerdefinierte Benachrichtigung senden (Send custom service notification) <span class="badge badge-info badge-outlined" title="Host">Service</span>
Wählen Sie den gewünschten Service aus der Service Liste aus und klicken Sie anschließend auf den Reiter `Aktionen`.
Danach klicken Sie die Schaltfläche `Benutzerdefinierte Benachrichtigung senden`.

Weitere Informationen zu [Benutzerdefinierte Benachrichtigung senden](../../monitoring/user-interface/#benutzerdefinierte-servicebenachrichtigung-senden)

#### Massenaktionen
Massenaktionen sind für fast alle Funktionen verfügbar. Um eine Aktion für mehreren Hosts und / oder Services
gleichzeitig auszuführen, navigieren Sie zu entsprechenden Host oder Service Liste und klicken anschließend die
Schaltfläche `Auswahl`. Für jedes Listenelement werden nun Checkboxen angezeigt. Wählen Sie nun die entsprechenden
Objekte aus und klicken auf die Schaltfläche `Aktionen`. Die ausgewählte aktion wird für alle selektierten Objekte
angewandt.

#### Host und Service Wartungszeiten (Downtimes)
Eine Übersicht aller Wartungszeiten sowie wiederkehrenden Wartungszeiten finden Sie
im Menü unter den Punkten `Host Wartungszeiten` und `Service Wartungszeiten`.

![downtimes host current filled](/images/mobile-website/downtimes-host-current-filled.png){ width="300" }

##### Wartungszeit erstellen

Wartungszeiten erstellen sind für Hosts und Services gleich.
Bei hosts ist lediglich noch die Option zum Setzen der downtimes auf dessen Services

=== "Wartungszeit"

    ###### Wartungszeit erstellen

    Eine Wartungszeit erstellen Sie über den Menüpunkt `Host Wartungszeit` oder `Service Wartungszeit`. Dort klicken Sie
    auf die Schaltfläche `Neu`.

    Wählen Sie nun die entsprechenden Hosts oder Services aus, für die Sie eine Wartungzeit einrichten möchten.
    Das Feld Wartungstyp ist nur bei Host Wartungszeiten verfügbar. Dort können Sie auswählen, ob für die gewählten
    Services der gewählten Hosts zusätzlich eine Wartungszeit mit den selben parametern erstellt werden soll.
    Mit dem Kommentar können Sie die Wartungszeit beschreiben.

    Mit dem Auswahlfeld `Wiederkehrende Wartungszeit` können Sie [Wiederkehrende Wartungszeiten erstellen](#wiedekehrende-wartungszeit-erstellen)

    Die Felder `Start` und `Ende` definieren den start und endzeitpunkt der Wartungszeit.

    ![downtimes host add downtime](/images/mobile-website/downtimes-host-add.png){ width="250" }

=== "Wiederkehrende Wartungszeit"

    ###### Wiedekehrende Wartungszeit erstellen

    Eine Wiederkehrende Wartungszeit erstellen Sie über den Menüpunkt `Host Wartungszeit` oder `Service Wartungszeit`.
    Dort klicken Sie auf die Schaltfläche `Neu`.

    Wählen Sie nun die entsprechenden Hosts oder Services aus, für die Sie eine Wiederkehrende Wartungzeit einrichten
    möchten. Das Feld Wartungstyp ist nur bei Host Wartungszeiten verfügbar. Dort können Sie auswählen, ob für die
    gewählten Services der gewählten Hosts zusätzlich eine Wartungszeit mit den selben parametern erstellt werden soll.
    Mit dem Kommentar können Sie die Wartungszeit beschreiben.

    Wählen Sie die Option `Wiederkehrende Wartungszeit` aus. Die Folgenden Formularfelder ändern sich nun.

    Zunächst müssen Sie eine Startzeit angeben sowie eine Dauer. Die Dauer können Sie durch die vorgegebenen
    Schaltflächen auswählen oder in dem darunterliegenden Feld eine eigenen Wert eintragen. Dieser Wert wird in Minuten
    angegeben.

    Danach wählen sie entweder einen Wochentag, einen Monatstag oder beides aus.

    Bei Wochentagen wird die Wartungszeit immer an den ausgewählten Wochentagen um die angegebene Uhrzeit für die
    angegebene Dauer erfolgen.

    Bei den Monatstagen entsprechend am angegebenen Tag des Monats.

    Sind sowohl Wochentage als auch Monatstage angegeben, so wird die Watrungszeit beispielsweise Montags, Mittwochs und
    am 3. des Monats erfolgen.

    ![downtimes host add recurring downtime](/images/mobile-website/downtime-host-add-recurring-downtime.png){ width="250" }


##### Wartungszeit abbrechen

Wartungszeiten können über die Mobile Webseite auch abgebrochen werden. Dazu suchen Sie die entsprechende Wartungszeit aus
der Liste aus und klicken auf das Papierkorb-Symbol.

Es erscheint ein Popup, welches zur bestätigung der Löschung auffordert.

![downtime host cancel overlay](/images/mobile-website/downtime-host-cancel.png){ width="300" }

Wiederkehrende Wartungszeiten können abgebrochen werden, indem auf die entsprechende wiederkehrende Wartungszeit geklickt
wird und danach `Downtime abbrechen`.

![downtime host cancel recurring overlay](/images/mobile-website/downtime-host-cancel-recurring-downtime.png){ width="300" }

## Dunkles Design
openITCOCKPIT Mobile bietet standardmäßig ein dunkles Design. Sie können über das Hauptmenü zwischen dem hellen und dem dunklen Design wechseln.

![Light and dark theme](/images/mobile-website/mobile_light_and_dark.png)

## Customization

Die Mobile Webseite ist in der Lage, sich der Identität des jeweiligen Unternehmens anzupassen. Dies betrifft das Login
Logo, Header logo (Menüleiste oben), Favicon, Systemname (Menüleiste oben) sowie den Webseiten Titel.

Dazu muss ein Verzeichnis auf dem Hostsystem angelegt werden, in dem die entsprechenden Dateien auf **einer** Ebene abgelegt werden.

- `CustomConfigDir/`
    * `HeaderLogo.png`
    * `LoginLogo.png`
    * `interface.yml`
    * `favicon.png`

Die Datei interface.yml ist entsprechende Konfigurationsdatei, die alle Konfigurierbaren Parameter enthält. Eine
Beispieldatei befindet sich im
Repository [interface.example.yml](https://github.com/openITCOCKPIT/openITCOCKPIT-Mobile/blob/development/interface/interface.example.yml).

Damit die Änderungen wirksam werden, muss beim Aufruf des Docker Containers ein zusätzlicher Parameter hinzugefügt
werden:

```bash
-v /my/path/to/CustomConfigDir:/var/www/localhost/htdocs/interface
```

Dabei ist zu beachten, dass der Container interne Pfad:

`:/var/www/localhost/htdocs/interface` **immer** gleich bleibt!

Änderungen können dann "on the fly" in der `CustomConfigDir/interface.yml` erfolgen. Es muss kein Neustart des Docker
Containers erfolgen - ein neu laden der Webseite genügt.

### Beispielkonfiguration

Dies ist eine Beispielkonfiguration um zu veranschaulichen, wie sich eine Konfiguration der `interface.yml` Datei
auswirkt.

Als Vorlage diente der [Halloween theme](https://github.com/openITCOCKPIT/oitc-halloween-theme) von openITCOCKPIT.

![ci-login](/images/mobile-website/ci-login.png){ width="300"; align=center }


Konfiguration der `interface.yml`:

```yaml
############
# CUSTOM INTERFACE CONFIGURATION EXAMPLE
# All attributes are optional.
# Custom images needs to be placed in the same directory as this configuration file
############

# System name displayed in the website header
systemname: Spooky Monitoring

# Title of the Website
title: custom title

# Logo used on the Login Screen
# filename only! - the complete path will be set automatically
login_logo: openitcockpit_halloween.png

# Filename of a custom background image used by the login screen.
# It is recommended to compress the used image https://tinypng.com/.
# Compression can reduce the filesize up to 70%. The image should have a resolution of 2560x1440px
# filename only! - the complete path will be set automatically
login_bg: ben-mccloskey-wN_UDPOTC1w-unsplash.jpg

# Logo used on the main manu
# filename only! - the complete path will be set automatically
header_logo: ghost_emoji.png

# Determine if openITCOCKPIT Mobile should use one image for all favicons
# (one icon for all Desktop Browsers, Mobile Devices, Operating Systems)
# of if openITCOCKPIT Mobile should use specialized icons for all kind of platforms
# true = one icon for all platforms (not recommended)
# false = Specializes icons per platform (recommended)
simple_favicon: false

# favicon logo
# filename only! - the complete path will be set automatically
# This is only relevant if "simple_favicon" is set to true
# If you want to use favicons per platform use the Website https://realfavicongenerator.net/
# to generate all required files and pass the folder to the container
# More information can be found in the docs: https://docs.openitcockpit.io/en/additional/mobile-website/
favicon: favicon.ico

# Theme color
# Some mobile browsers support to set a so called theme-color, which defines the color of the address bar
# or other parts of the browser itself.
# https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta/name/theme-color
# If you want to adjust this value, it is recommended to set "simple_favicon" to false and to pass own favicons as well.
# The files "favicons/browserconfig.xml" and "favicons/site.webmanifest" to also contain the colors and have to be
# adjusted manually.
theme_color: '#4085c6'

# FQDN or IP-Address of your openITCOCKPIT Server
# If this value is defined, users have no option anymore to set the ip-address on the login screen.
server_url: demo.openitcockpit.io
```

### Favicons

Favicons sind kleine Icons, welche von den Browsern zum Beispiel neben Lesezeichen oder in der Leiste der geöffneten Tabs angezeigt werden.
Welche Arten von Favicons genutzt werden, hängt vom eingesetzten Browser und Betriebssystem ab. So gibt es zum Beispiel spezielle Icons,
wenn ein Lesezeichen auf dem Home-Bildschirm eines Smartphones gespeichert wird.

### Mehrere Favoriten (empfohlen)
Wie oben erwähnt, benötigen unterschiedliche Browser auf unterschiedlichen Betriebssystemen unterschiedliche Favicons. iOS und Android Geräte zum Beispiel haben eigene Icons Home-Bildschirm Verknüpfungen.
Microsoft Windows benötigt ein Kachel-Icon und Safari und macOS erfordern eigene Icons für die Darstellung in der Touchbar oder Tab-Leiste.

Am einfachsten ist, einen Favicon Generator  wie [RealFaviconGenerator](https://realfavicongenerator.net/) zu nutzen, um alle benötigten Icons zu erstellen.

Alle Favicons werden aus dem Dateipfad `/favicons/` geladen.
Im folgenden Beispiel-Screenshot ist zu sehen, wie man das Geister-Emoji 👻 als Favicon verwendet.

![Usage example of RealFaviconGenerator](/images/mobile-website/realfavicongenerator_usage_example.png){ width="300"}


Wenn für die Erstellung der Favicons [RealFaviconGenerator](https://realfavicongenerator.net/) genutzt wurde, muss nur das heruntergeladene Archiv entpackt werden
und alle Dateien in einen Ordner mit dem Namen `favicons` kopiert werden.

Bitte stellen Sie sicher, dass die folgenden Dateien im Ordner `favicons` enthalten sind:

- `android-chrome-192x192.png`
- `android-chrome-512x512.png`
- `apple-touch-icon.png`
- `browserconfig.xml`
- `favicon.ico`
- `favicon-16x16.png`
- `favicon-32x32.png`
- `mstile-150x150.png`
- `safari-pinned-tab.svg`
- `site.webmanifest`

Um die Änderungen zu übernehmen, muss `simple_favicon` auf `false` gesetzt sein in der `interface.yml`. (Standard)

Nun muss der Order `favicons` an den Container durchgereicht werden.
```
-v /host/path/to/favicons:/var/www/localhost/htdocs/webroot/favicons:ro
```

### Einfaches Favicon
Es ist auch möglich, ein Favicon für alle Plattformen zu verwenden. **Dies wird nicht empfohlen** und ist insbesondere für mobile Geräte eine schlechte Praxis.

Setzen Sie `simple_favicon` auf `true` und den Dateinamen bei `favicon` in der `interface.yml`.
Bitte stellen Sie sicher, dass es sich bei der Datei um ein Microsoft Windows Icon (`.ico`) handelt.
