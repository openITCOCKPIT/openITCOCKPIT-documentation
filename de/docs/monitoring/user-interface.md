# User Interface

### Das Interface im Überblick
Das Layout des User-Interface teilt sich in zwei Bereiche auf. Den Navigationsbereich (1. Blau) und den Inhaltsbereich 
(2. Rot)
Der Navigationsbereich von openITCOCKPIT bleibt immer gleich, wohingegen der Inhalt der ausgewählten Seite immer im 
Inhaltsbereich (2) angezeigt wird.

![user-interface](/images/user-interface.png)

### Der Navigationsbereich im Detail

#### Obere Navigationsleiste
![top nav bar](/images/layout-header-explaination.png)

Die obere Navigationsleiste beinhaltet neben einer Suche (2) und der Uhrzeit (7) weitere Kurzlinks zu verschiedenen 
Aktionen

1. Schaltfläche zum Ein-/Ausklappen des Hauptmenüs
2. Suchleiste mit der Möglichkeit nach Hosts, Services, UUIDs und IP-Adressen zu suchen.
3. Subscription Badge - nur sichtbar bei unregistrierten und Community Editionen.
4. [Systemzustand (System Health)](#system-health) 
5. [Export](../basic-principles/#export) Schaltfläche
6. Zeigt an, ob eine neue openITCOCKPIT Version verfügbar ist. Nur sichtbar, wenn dies der Fall ist.
7. Zeigt die [Meldung des Tages](#meldung-des-tages) an
8. Aktuelle [(Server)Uhrzeit](#system-uhrzeiten)
9. Sprachauswahlbox
10. Log-out


##### System health
Die System health Anzeige gibt einen schnellen Überblick auf den Zustand des openITCOCKPIT Servers. 
Hier werden Warnungen und kritische Zustände, wie beispielsweise mangelnder Festplattenspeicher, kritische 
Arbeitsspeicherauslastung sowie nicht laufenden Dienste, angezeigt.
Ist die Anzeige leer und in der Farbe Grün dargestellt, ist mit dem Server alles in Ordnung (siehe screenshot). 

![system health](/images/system-health.png)

##### Meldung des Tages

Um alle Benutzer oder ausgewählte Benutzergruppen gleichzeitig über ein bestimmtes Ereigniss informieren zu können, besteht im openITCOCKPIT die Möglichkeit eine `Meldung des Tages` zu erstellen. 
Diese Meldung wird immer nach dem Einloggen automatisch eingeblendet. 

![message of the day](/images/message-otd-modal.png)


Zusätzlich kann die `Medlung des Tages` über das Klicken auf den Menüpunkt (7) eingeblendet werden.

![message of the day](/images/message-of-the-day.png)

Die [Konfiguration](../../configuration/usermanagement/#meldung-des-tages-erstellen) der `Meldung des Tages` findet man als separaten Punkt unter Benutzerverwaltung 

##### System Uhrzeiten
Das User-Interface ist in der Lage zwei verschiedene Uhrzeiten anzuzeigen. 

![user server time](/images/user-servertime.png)

Dies geschieht automatisch, sobald sich die lokale Benutzerzeit (1) von der Serverzeit (2) unterscheidet. 
Anpassungen der Benutzerzeitzone können im [Profil](#profil-informationen) vorgenommen werden. 

#### Hauptmenü
![main menu](/images/main-menu.png)

Das Hauptmenü in openITCOCKPIT bietet neben der Liste mit allen Menüeinträgen auch die Möglichkeit das Menü zu 
durchsuchen (1). Dazu muss nur einmal auf die Schaltfläche :fontawesome-solid-angle-down: geklickt werden. Dies 
erleichtert das Finden von Einträgen im Menü enorm.

Darunter befindet sich die Anzeige Ihres Benutzernamens. Die goldene Krone signalisiert, dass Administrator-Rechte zu 
diesem Benutzer vorhanden sind. Durch einen Klick auf den Benutzernamen gelangt man in das [Benutzerprofil](#profil).

Unterhalb des Hauptmenüs befinden sich weitere Schaltflächen (3):

- :fontawesome-solid-chart-line: verlinkt zu einer Übersicht, welche das Senden von anonymisierten Statistiken an die Entwickler von openITCOCKPIT ermöglicht.
- :fontawesome-solid-bug: führt zur Support-Übersichtsseite. Dort haben Sie die Möglichkeit Fehler zu melden sowie kommerziellen Support zu erhalten.
- :fontawesome-solid-life-ring: verlinkt auf die Übersicht der verfügbaren Subskriptionen um kommerziellen support sowie Enterprise Module zu erhalten.
- :fontawesome-solid-book: verlinkt zu einer Übersichtsseite die weitere Links zu verschiedenen Dokumentationen enthält.



### Profil
In der Profil-Übersicht haben Sie die Möglichkeit Anpassungen an Ihrem eigenen Benutzerprofil zu tätigen. 

#### Profil Informationen

Neben den Änderungsmöglichkeiten Ihres Namens, E-Mail-Adresse und Telefonnummer, können Sie verschiedene Einstellungen 
treffen, die die Darstellung von Listen, Browser Darstellungen und weiteres verändern.

![Profil Information edit](/images/profile-information.png)

1. Zeigt Statusinformationen zu den überwachten Objekten in der oberen Navigationsleiste an.
   ![Header stats](/images/layout-header-with-stats.png)
2. Rekursiver Browser berücksichtigt im [Browser](#browser) die Elemente in verschachtelten, unterhalb des aktuell gewählten Containers. 
3. Länge der Listen beeinflusst die auf einer Seite angezeigten Listenelemente. Diese Einstellung wirkt sich global auf alle Listen aus.
4. Hier kann die Anzeigesprache für den Benutzer geändert werden.
5. Gewünschtes Datumsformat des Benutzers.
6. Zeitzone des Benutzers.





#### Profilbild

Um ein Profilbild hochzuladen, können Sie das gewünschte Bild einfach per Drag-and-drop in das dafür vorgesehene Feld 
ziehen. Das Hochladen und Speichern geschieht anschließend automatisch.

![Profile picture](/images/profile-image.png)

#### Passwort ändern

!!! info
    Diese Option steht nur bei lokalen Benutzern zur verfügung. Benutzer die über LDAP hinzugefügt wurden, müssen Ihr 
    Passwort über das Betriebssystem oder ein LDAP-Account-Manager-Tool ändern.

Um Ihr Passwort zu ändern, können Sie dieses Formular nutzen. Dazu müssen Sie Ihr altes Passwort bereithalten und ein 
neues Passwort vergeben. Die Voraussetzungen für das neue Passwort sind mindestens 6 alphanumerische Zeichen sowie 
mindestens eine Ziffer.

![Profile change password](/images/profile-changepassword.png)

#### API-Keys
Über Ihr Profil können Sie API-Keys erstellen, welche zur Authentifizierung mit der openITCOCKPIT API genutzt werden. 
Wie sie einen API-Key erstellen erfahren sie in einem [gesonderten Artikel](../../development/api/#api-keys)



## Browser

Der Browser bietet eine, für einen Benutzer sichtbare, Übersicht aller Container, deren Hosts sowie den Status der Host 
und Services.

Die Darstellung des Host- und Servicestatus zeigt im Standard nur den Status der Hosts und Services an, die in dem 
aktuell gewählten Container liegen.

Mit der Einstellung `Rekursiver Browser` in den Profileinstellungen wird der Gesamtstatus aller, für einen Benutzer, 
sichtbaren Hosts und Services angezeigt.

## Host Browser

Der Host Browser gibt eine Übersicht über den aktuellen Zustand des Host sowie seiner Services. Zudem bekommt man 
detaillierte Status- und Geräteinformationen, eine Zeitleiste sowie bei entsprechend installierten Modulen noch mehr 
Zusatzinformationen zum Host.

### Navigationsleiste

Die Navigationsleiste verlinkt zu verschiedenen Aktionen zu einem Host

![Screenshot: Navigationsleiste](/images/hosts-browsertopnavbar.png)

#### Prüfzeit Zurücksetzen

![Screenshot: Prüfzeit Zurücksetzen](/images/hosts-browserresetchecktime.png)

Hiermit wird die Prüfzeit des Hosts zurückgesetzt. Dies hat denselben effekt wie `Prüfzeitraum zurücksetzen` in den Statusinformationen

#### Objekt Dokumentation

![Screenshot: Objekt Dokumentation](/images/hosts-browserdocumentation.png)

Hier kann eine Dokumentation zum Host eingetragen werden

#### Benachrichtigungen

![Screenshot: Benachrichtigungen](/images/hosts-browsernotifications.png)

Um eine Übersicht aller gesendeten Benachrichtigungen zum Host zu bekommen, klicken Sie auf diese Schaltfläche

#### Verlaufshistorie

![Screenshot: Verlaufshistorie](/images/hosts-browsercheckhistory.png)

Die Verlaufshistorie enthält das Ergebnis jeder Überprüfung des Hosts mit Datum, Prüfversuch, Statustyp und der Ausgabe

#### Statushistorie

![Screenshot: Statushistorie](/images/hosts-browserstatehistory.png)

Die Statushistorie enthält die Ergebnisse wann der Host seinen Status gewechselt hat

#### Bestätigungshistorie

![Screenshot: Bestätigungshistorie](/images/hosts-browseracknowledgmenthistory.png)

Die Bestätigungshistorie enthält alle Bestätigungen zum Status des Hosts

#### Host editieren

![Screenshot: Host editieren](/images/hosts-browseredit.png)

Hier kann der Host editiert werden

#### Mehr Aktionen

![Screenshot: Mehr Aktionen](/images/hosts-browsermoreactions.png)

##### Service Liste

Hier gelangt man zu einer Übersicht aller vorhandenen Services zu dem Host

##### Servicevorlagengruppe zuordnen

Sie können in openITCOCKPIT Servicevorlagengruppen erstellen, die eine Reihe von Servicevorlagen enthalten. Diese 
Gruppen können dann über diese Option einem Host zugewiesen werden. Im sich öffnenden Formular können Sie die 
entsprechende Servicevorlagengruppe und zusätzlich die zu erstellenden Services auswählen. Dies hat den Vorteil, dass 
die passenden Services für einen Host sehr schnell erstellt werden können. Damit die Änderungen wirksam werden, muss die
Konfiguration anschließend exportiert werden.

#### openITCOCKPIT Agent Discovery

Hierüber kann die Einrichtung für einen openITCOCKPIT Agent erfolgen. Es wird zum Agent Wizard weitergeleitet.

#### Checkmk Erkennung

Hierüber kann ein Checkmk discovery gestartet werden.

### Statusinformationen

Die Statusinformationen enthalten für den Status relevante Daten. Diese beinhalten neben den Prüfungsparametern und 
Benachrichtigungseinstellungen eine Leiste die den Status des aktuellen Hosts anzeigt. Diese Leiste ist in der aktuellen
Statusfarbe eingefärbt und enthält Informationen, die Aufschluss geben, seit wann der Host in diesem Status ist, wann 
die letzte Überprüfung war, wann die nächste Überprüfung ist und den Statustyp. Darüber hinaus gibt es hier die 
Möglichkeit verschiedene Aktionen durchzuführen.

#### Prüfzeitraum zurücksetzen

Beim Prüfzeitraum zurücksetzen wird die nächste Überprüfung zum nächstmöglichen Zeitpunkt ausgeführt (in der Regel 
sofort). Dies kann entweder nur für den Host selbst oder aber auch für den Host und seine Services ausgewählt werden.

#### Plane Wartung

Über diese Option kann ein Wartungszeitraum für diesen Host eingerichtet werden. Hier gibt man an was genau in dem 
Wartungszeitraum enthalten sein soll, ein Kommentar zum Wartungszeitraum sowie die Zeitspanne von und bis wann die 
Wartung stattfinden soll

##### Einzelne Hosts

Bei dieser Option wird nur der Host selbst in einen Wartungszeitraum eingetragen.

##### Hosts einschließlich Services

Bei dieser Option wird der Host selbst, sowie seine Services in ein Wartungsfenster eingetragen

##### Hosts und abhängige Hosts (ausgelöst)

Bei dieser Option wird der Host selbst, sowie abhängige Hosts in ein Wartungsfenster eingetragen. Hier wird der Start 
der Wartungszeit durch den Start einer anderen geplanten Host-Wartungszeit ausgelöst.

##### Hosts und abhängige Hosts (nicht ausgelöst)

Bei dieser Option wird der Host selbst, sowie abhängige Hosts in ein Wartungsfenster eingetragen. Hier startet und 
stoppt die Wartungszeit genau zu den Zeiten, die Sie bei der Planung festgelegt haben.

#### Bestätige Hoststatus

Je nach Benachrichtigungseinstellungen werden Benachrichtigungen für einen Host in einem Intervall versendet. Diese 
Benachrichtigungen können unterbunden werden, indem man den Hoststatus bestätigt. Hier besteht auch die Option den 
Status für den Host sowie dessen Services zu bestätigen. Die Option `Sticky` lässt die Bestätigung so lange bestehen, 
bis der Host wieder im Status `UP` ist.

#### Passive Übertragung eines Prüfergebnisses

Mit dem passiven Übertragen von Prüfergebnissen erhält der Host den angegebenen Status mit Kommentar. Ist 
`Auf harten Zustand zwingen` angehakt, so wird der Hoststatustyp gleich auf `HARD` gesetzt und die Anzahl der 
Prüfversuche ignoriert.

#### Deaktiviere Benachrichtigungen

Mit dieser Option können Sie Benachrichtigungen für den Host oder den Host und seine Services vorübergehend 
deaktivieren.

#### Benutzerdefinierte Hostbenachrichtigung senden

Wählen Sie diese Option, um eine benutzerdefinierte Hostbenachrichtigung zu senden. Hier kann ausgewählt werden, ob das 
Senden der Nachricht erzwungen werden soll. Hierbei wird der Benachrichtigungszeitraum sowie die deaktivierten 
Benachrichtigungen für den Host ignoriert. Zudem kann man auswählen, ob die Benachrichtigung auch an die 
Eskalationskontakte gesendet werden soll.

### Geräte informationen

In den Geräteinformationen finden Sie Eigenschaften zu dem Host. Diese bestehen aus der IP-Adresse / Hostnamen, die 
UUID, welche den Host im openITCOCKPIT genau identifiziert sowie Berechtigungsinformationen und weitere Eigenschaften.

### Zeitleiste

Die Zeitleiste gibt eine genaue Übersicht über den Host, was und wann passiert ist. Sie enthält Informationen, wann ein 
Hoststatus bestätigt, Wartungszeiten eingetragen, Benachrichtigungen gesendet worden sind und wann der Host, welchen 
Status hatte.

![Screenshot: Zeitleiste](/images/hosts-browsertimeline.png)

### Grafana

Unter dem Reiter `Grafana` finden Sie das Grafana Dashboard zu diesem Host.

Hier werden alle verfügbaren Graphen zu den Services des Hosts dargestellt


## Service Browser

Der Service Browser gibt eine Übersicht über den aktuellen Zustand des Services. Zudem werden hier Status- und 
Serviceinformationen, eine Zeitleiste sowie bei entsprechend installierten Modulen, noch mehr Zusatzinformationen, 
angezeigt.

### Navigationsleiste

Die Navigationsleiste verlinkt zu verschiedenen Aktionen zu einem Service.

![Screenshot: Navigationsleiste](/images/services-browsertopnavbar.png)

#### Prüfzeit Zurücksetzen

![Screenshot: Prüfzeit Zurücksetzen](/images/hosts-browserresetchecktime.png)

Hiermit wird die Prüfzeit des Services zurückgesetzt. Dies hat denselben Effekt wie `Prüfzeitraum zurücksetzen` in den 
Statusinformationen

#### Objekt Dokumentation

![Screenshot: Objekt Dokumentation](/images/hosts-browserdocumentation.png)

Hier kann eine Dokumentation zum Service eingetragen werden

#### Benachrichtigungen

![Screenshot: Benachrichtigungen](/images/hosts-browsernotifications.png)

Klicken Sie auf diese Schaltfläche, um eine Übersicht aller gesendeten Benachrichtigungen zum Service zu bekommen 

#### Verlaufshistorie

![Screenshot: Verlaufshistorie](/images/hosts-browsercheckhistory.png)

Die Verlaufshistorie enthält das Ergebnis jeder Überprüfung des Services mit Datum, Prüfversuch, Statustyp und der 
Ausgabe

#### Statushistorie

![Screenshot: Statushistorie](/images/hosts-browserstatehistory.png)

Die Statushistorie enthält die Ergebnisse, wann der Service seinen Status gewechselt hat

#### Bestätigungshistorie

![Screenshot: Bestätigungshistorie](/images/hosts-browseracknowledgmenthistory.png)

Die Bestätigungshistorie enthält alle Bestätigungen zum Status des Service

#### Host editieren

![Screenshot: Host editieren](/images/hosts-browseredit.png)

Hier kann der Host des Services editiert werden

#### Service editieren

![Screenshot: Service editieren](/images/services-browsereditservice.png)

Hier kann der Service selbst editiert werden

#### Mehr Aktionen

![Screenshot: Mehr Aktionen](/images/services-browsermoreactions.png)

##### Service liste

Hier gelangt man zu einer Übersicht aller vorhandenen Services desselben Hosts

### Status Informationen

Die Statusinformationen enthalten für den Status relevante Daten. Diese beinhalten neben den Prüfungsparametern und 
Benachrichtigungseinstellungen eine Leiste, die den Status des aktuellen Services anzeigt. Diese Leiste ist in der 
aktuellen Statusfarbe eingefärbt und enthält Informationen, die Aufschluss geben, seit wann der Service in diesem Status
ist, wann die letzte Überprüfung war, wann die nächste Überprüfung ist und den Statustyp. Darüber hinaus gibt es hier 
die Möglichkeit andere verschiedene Aktionen durchzuführen.

#### Prüfzeit zurücksetzen

Beim Prüfzeit zurücksetzen wird die nächste überprüfung zum nächstmöglichen Zeitpunkt ausgeführt (in der Regel sofort).

#### Plane Wartung

Über diese Option kann ein Wartungszeitraum für diesen Service eingerichtet werden. Hier gibt man ein Kommentar zum 
Wartungszeitraum an sowie die Zeitspanne von bis wann die Wartung stattfinden soll

#### Passive Übertragung eines Prüfergebnisses

Mit dem passiven Übertragen von Prüfergebnissen erhält der Service den angegebenen Status mit Kommentar. Ist 
`Auf harten Zustand zwingen` angehakt, so wird der Servicestatustyp gleich auf `HARD` gesetzt und die Anzahl der 
Prüfversuche ignoriert.

#### Aktiviere die Flattererkennung (Flapping)

Hier wird die Erkennung des Flapping-Status vorübergehend aktiviert

#### Deaktiviere Benachrichtigungen

Mit dieser Option können Sie Benachrichtigungen für den Service vorübergehend deaktivieren

#### Benutzerdefinierte Servicebenachrichtigung senden

Wählen Sie diese Option, um eine Benutzerdefinierte Servicebenachrichtigung zu senden. Hier kann ausgewählt werden, ob 
das Senden der Nachricht erzwungen werden soll. Hierbei wird der Benachrichtigungszeitraum sowie die deaktivierten Benachrichtigungen für den Service ignoriert. Zudem kann man auswählen, ob die Benachrichtigung auch an die Eskalationskontakte gesendet werden soll.

### Service Informationen

In den Service Informationen finden Sie Eigenschaften zu dem Service. Diese bestehen aus der IP-Adresse/Hostname des 
Hosts, die UUIDs welche den Host und Service im openITCOCKPIT genau identifiziert sowie Berechtigungsinformationen und 
weitere Eigenschaften.

### Zeitleiste

Die Zeitleiste gibt eine genaue Übersicht über den Service, was und wann passiert ist. Sie enthält informationen wann 
ein Servicestatus bestätigt, Wartungszeiten eingetragen, Benachrichtigungen gesendet worden sind und wann der Service 
welchen Status hatte.

Darüber hinaus ist zudem der Hoststatus enthalten.

![Screenshot: Zeitleiste](/images/services-browsertimeline.png)
