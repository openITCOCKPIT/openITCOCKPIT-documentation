# Reporting

openITCOCKPIT ist in der Lage Berichte (Reports) zu generieren. Diese Berichte können unterschiedlichste Daten wie zum
Beispiel Wartungszeiten, Ausfälle, Verfügbarkeiten und den aktuellen Status einzelner Host und Services beinhalten.

## Sofortige Berichte

Sofortige Berichte in openITCOCKPIT sind eine Variante der Berichte, die als HTML oder PDF generiert und optional auch
in einem Benutzerdefinierten Intervall versendet werden können.

Sofortige Berichte enthalten je nach Auswahl eine zusammenfassung des Status von Hosts, Services, Hostgruppen oder
Servicegruppen.

### Sofortigen Bericht erstellen

Um einen "Sofortigen Bericht" zu erstellen, klicken Sie zunächst in der "Sofortige Berichte" Übersicht auf die
Schaltfläche "Neu".

Anschließend wählen Sie im Formular einen Container aus, vergeben einen Namen und wählen den Objekttyp aus, der
ausgewertet werden soll.

Je nach gewähltem Objekttyp wählen Sie im darauffolgenden feld entweder Hosts, Hostgruppen, Services oder Servicegruppen
aus, die ausgewertet werden sollen.

Der Zeitraum gibt an wann die Auswertungszeiten stattfinden sollen.

Der Reflexionszustand definiert, ob entweder nur ein weicher und harter Zustand (hard state und soft state) oder nur ein
harter Zustand berücksichtigt werden soll.

Sie haben die möglichkeit wartungszeiten im Bericht zu berücksichtigen, dazu wählen Sie die Option "Berücksichtige
Wartungszeiten".

Ist die Option "Zusammenfassungsanzeige" ausgewählt, wird anstatt der Auflistung von einzelnen Hosts und deren Services
nur eine Gesamte ansicht der Status von Host und Services angezeigt.

Möchten Sie einen Bericht in einem Intervall von Tag, Woche, Monat oder Jahr automatisiert verschicken, so müssen Sie
die Option "Sende E-Mail" aktivieren.

Dort können Sie einem oder mehreren Benutzern den Bericht schicken.


| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | Container in dem der Sofortige Bericht erstellt werden soll |
| Name | :fontawesome-solid-xmark: | Name des Sofortigen Berichts |
| Typ | :fontawesome-solid-xmark: | Objekttyp der ausgewertet werden soll. Hostgruppen, Hosts, Servicegruppen und Services sind möglich  |
| Typ-Objekte | :fontawesome-solid-xmark: | Abhängig vom gewählten Typ müssen im nächsten Feld entweder Hosts, Hostgruppen, Services oder Servicegruppen ausgewählt werden |
| Auswertung | :fontawesome-solid-xmark: | Welche Objekte ausgewertet werden -> Nur Hosts, Hosts und Services oder nur Services |
| Zeitraum | :fontawesome-solid-xmark: | [Zeitraum](../configuration/timeperiods/) der Berücksichtigt werden soll |
| Reflexionszustand | :fontawesome-solid-xmark: | Der auszuwertende Statustyp. Hard-State oder Soft und Hard-State |
| Berücksichtige Wartungszeiten |  | Bestimmt ob Wartungszeiten berücksichtigt werden sollen |
| Zusammenfassungsanzeige |  | Bestimmt ob anstelle der Auflistungen von einzelnen Hosts eine Gesamtansicht der Status von Host und Services angezeigt wird |
| Sende E-Mail |
| Sendungsintervall | :fontawesome-solid-xmark: | Sendungsintervall: TAG, WOCHE, MONAT, JAHR |
| Benutzer zum Senden | :fontawesome-solid-xmark: | Benutzer an den der Bericht gesendet werden soll |



### Sofortigen Bericht generieren

Wenn Sie einen "Sofortigen Bericht" erstellt haben, klicken Sie auf das Menü des entsprechenden "Sofortigen Bericht" (1)
und anschließend auf die Schaltfläche "Generieren" (2).

![](/images/instantreports-generate.png)

Im sich öffnenden Formular geben Sie anschließend das Format an, in dem der Bericht generiert werden soll, sowie den zu
berücksichtigenden Zeitraum.

Danach bekommen Sie den Bericht im Browser angezeigt oder aber als Download zur verfügung gestellt.

## Aktueller Statusbericht

Der "Aktuelle Statusbericht" generiert einen Bericht im HTML oder PDF Format anhand von gewählten Services.

Neben den Status Filter funktionen kann zusätzlich nach Bestätigungen, Wartungszeiten und dem Prüfungstyp gefiltert
werden.

Der generierte Bericht enthält neben dem Hoststatus der gewählten Services auch die verschiedenen Metriken (Performance
Daten) der Services.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Services | :fontawesome-solid-xmark: | Services die ausgewertet werden sollen |
| Berichtsformat | :fontawesome-solid-xmark: | Berichtsformat HTML oder PDF |

## Wartungszeitberichte

Wartungszeitberichte in openITCOCKPIT geben aufschluss darüber, welche Hosts oder welche Hosts und Services sich wann in
einer Wartungszeit befanden. Dies wird visuell anhand eines Kalenders und Diagrammen dargestellt.

### Wartungszeitbericht erstellen

Um einen Wartungszeitbericht zu erstellen, klicken Sie im Hauptmenü auf den Punkt "Wartungszeitberichte".

Dort wählen Sie aus ob nur Hosts oder Host und Services ausgewertet werden sollen.

Bei dem Berichtsformat haben Sie die Wahl zwischen einem HTML bericht, der im Browser dargestellt wird oder einem PDF
bericht der zum Download angeboten wird.

Der Zeitraum definiert, welche Wartungszeiten berücksichtigt werden sollen.

Der Reflexionszustand definiert, ob entweder nur ein weicher und harter Zustand (hard state und soft state) oder nur ein
harter Zustand berücksichtigt werden soll.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Auswertung | :fontawesome-solid-xmark: | Hosts oder Hosts inklusive Services |
| Berichtsformat | :fontawesome-solid-xmark: | Berichtsformat HTML oder PDF |
| Zeitraum | :fontawesome-solid-xmark: | [Zeitraum](../configuration/timeperiods/) der berücksichtigt werden soll |
| Von |  | Start Zeitraum der Auswertung |
| Bis |  | End Zeitraum der Auswertung |
| Reflexionszustand | :fontawesome-solid-xmark: | Der auszuwertende Statustyp. Hard-State oder Soft und Hard-State |
| Dynamische Farbe |  | Je nach Ausfall werden verschiedene Farben angezeigt |


## Statusseiten

Statusseiten in openITCOCKPIT bieten Statusinformationen über Hosts, Services, Hostguppen, Ervicegroups in aeiner einheitlichen Weise.

Statusseiten können - wenn gewünscht - auch öffentlich (heißt ohne Login) aufgerufen werden. Alle Elemente einer Statusseite können über Aliasnamen annonymisiert werden. 
Alle Elemente einer Statusseite werden im selben Format dargestellt, so dass nicht ablesbar ist, um welche Art von Element es sich handelt.  

Jedes Element einer Statusseite kann Informationen über die enthaltenden Probleme (bestätigt/nicht betätigt) und Wartungen (laufend, für die nächsten 10 Tage geplant) enthalten.

### Statusseite erstellen
![](/images/status-pages/status-page-create.png)

| Feld            | Erforderlich                 | Beschreibung                                               |
| ---------------- | ------------------------- | ------------------------------------------------------------ |
| Container | :fontawesome-solid-xmark: | Der Container bestimmt die Auswahl der Elemente, Elemente des Rootcontainers sind immer auswählbar.|
| Name             | :fontawesome-solid-xmark: | Der Name der Seite |
| Beschreibung      |                           | Optionale Beschreibung |
| Öffentlich          |                           | Seite ist ohne Autentifizierung aufrufbar |
| Zeige Wartungen   |                           | Alle laufenden/geplanten Wartungen werden angezeigt | 
| Zeige  Wartungskommentar  |      | Die original Kommentare der Wartungen werden angezeigt                                   |
| Zeige Bestätigungen |  | Es wird angezeigt wieviele Probleme bestätigt sind |
| Zeige Bestätigungskommentar  |   | Die originalen Kommentare der Bestätigungen werden angezeigt. |
| Hostgruppen, Servicegruppen, Hosts, Services | | Die wählbaren Elemente der Seite|
| Anzeigename | | optionaler Aliasname, wenn gefüllt, wird dieser statt des Originalnamens angezeigt.|


### Anzeige
![](/images/status-pages/status-page-view.png)

#### Interne Anzeige
![](/images/status-pages/status-page-view-internal.png)

#### Externe Anzeige
![](/images/status-pages/status-page-view-external.png)

In- und externe Ansicht sind prinzipiell gleich.aber in der internen Ansicht sind die Elementnamen verlinkt.

### Status, Statusfarbe
Die farbliche kennzeichnung der Elemente entspricht den openITCOCKPIT Statusfarben. Die Farbe (Status) wird abhängig vom Typ des Elements ermittelt.

 - **Lila:** Nicht im Monitoring
 - **Grün:** Betrieb
 - **Gelb:** Leistungsprobleme
 - **Rot:** Schwerwiegender Ausfall
 - **Grau:** Unbekannt

| Typ             |   Status/Farbe                                                                                   |
| ---------------- | ----------------------------------------------------------------------------------------------- |
| Service          |  Status des Service                                                 |
|Servicegruppe     |  Es wird über den höchsten Status aller enthaltenen Services kumuliert.                               |.
| Host             |  Ist der Status des Host in DOWN, UNREACHABLE, dann ist das der Status des Hosts. Ist der Host UP wird der höchste Status aller enthaltenen Services auf den Hoststatus kumuliert.  |
|Hostgruppe        | Zunächst wir der höchste Status aller Hosts kumuliert, ist dieser !== UP , dann ist das der Stus der  Gruppe. Ist der Status des Hosts === UP wird über sämtliche Status der in allen Hosts enthaltenen Services kumuliert, und der Höchste ist der Stus der Gruppe.|
| Statusseite      | Der höchste Status aller Elemente ist der Seitenstatus|


### Zählung der Probleme(Bestätigungen)/Wartungen(laufend, geplant)
Es wird über alles gezählt, was auch zur Ermittlung des Status herangezogen wird.

| Typ             |   Probleme(Bestätigungen)/Wartungen(laufend, geplant)                                       |
| ---------------- | ----------------------------------------------------------------------------------------------- |
| Service | Es wird gezählt(angezeigt), ob der Service ein Problem hat. Es werden alle Downtimes(laufend, geplant) des Service gezählt.
 |
|Servicegruppe | Es werden die Probleme aller enthaltenen Services gezählt. Es werden alle Downtimes(laufend, geplant) aller entaltenen Services gezählt. |
| Host | Es werde alle Probleme über den Host und die enthaltenen Services gezählt(angezeigt). Es werden alle Downtimes (laufend, geplant) über den Host und die enthaltenen Services gezählt(angezeigt). |
| Hostgruppe | Es werden alle Probleme über alle Hosts und alle in den Hosts enthaltenen Services gezählt(angezeigt). Es werden alle Downtimes (laufend, geplant) über alle Hosts und die enthaltenen Services gezählt(angezeigt). |


## Statusseiten-Gruppen

Das _Statusseiten-Gruppen_-Feature ermöglicht es Ihnen, mehrere Statusseiten in einer zweidimensionalen Matrix zu organisieren und so eine übersichtliche und hoch aggregierte Darstellung zu erhalten.
Jede Statusseiten-Gruppe besteht aus mehreren `Sammlungen` und `Kategorien`.

Angenommen, Sie möchten den Status verschiedener Rechenzentren in einer Statusseiten-Gruppe präsentieren. Zunächst sollten Sie für jedes Rechenzentrum eine eigene Statusseite erstellen.

Im nächsten Schritt können Sie Sammlungen wie `Fulda`, `Frankfurt` und `Berlin` definieren, um die Standorte der Rechenzentren darzustellen.
Anschließend fügen Sie Kategorien wie `Facility`, `Infrastructure` und `Services` hinzu. Jede Zelle in der Matrix kann eine oder mehrere Statusseiten enthalten und bietet Ihnen so einen umfassenden Überblick über den Status jedes Standorts und jeder Kategorie.

Das Beispiel würde zu einer Statusseiten-Gruppen-Matrix wie dieser führen:

|            | Facility        | Infrastructure   | Services        |
|------------|-----------------|------------------|-----------------|
| Fulda      | [Statusseite/n] | [Statusseite/n]  | [Statusseite/n] |
| Frankfurt  | [Statusseite/n] | [Statusseite/n]  | [Statusseite/n] |
| Berlin     | [Statusseite/n] | [Statusseite/n]  | [Statusseite/n] |


Optional können Sie der Statusseiten-Gruppe einen Freitext hinzufügen. So können Sie nützliche Informationen wie Telefonnummern, Links zu einem Wiki oder andere relevante Details hinterlegen.

### Erstellung

Die Erstellung neuer Statusseiten-Gruppen erfolgt in zwei Schritten. Im ersten Schritt definieren Sie die Statusseiten-Matrix.

![](/images/status-page-groups/create-status-page-group-step1.png)

| Feld                              | Erforderlich              | Beschreibung                                                                                        |
|-----------------------------------|---------------------------|-----------------------------------------------------------------------------------------------------|
| Container                         | :fontawesome-solid-xmark: | Der Container bestimmt die Auswahl der Elemente, Elemente des Root-Containers sind immer auswählbar |
| Name                              | :fontawesome-solid-xmark: | Der Name der Statusseiten-Gruppe                                                                    |
| Beschreibung                      |                           | Optionale Beschreibung                                                                              |
| Weitere Informationen             |                           | Optionales Freitextfeld für relevante Informationen wie Telefonnummern                              |
| Zeige Alarme als Ticker-Nachricht |                           | Legt fest, ob Alarme als Lauftext angezeigt werden                                                  |
| Sammlung                          |                           | Erste Dimension der Matrix (Y-Achse)                                                                |
| Kategorie                         |                           | Zweite Dimension der Matrix (X-Achse)                                                               |


Im zweiten Schritt können Sie Statusseiten zuweisen.
Jede Zelle kann mehrere Statusseiten enthalten oder auch leer bleiben.

openITCOCKPIT berechnet den Status jeder Zelle in einer Statusseiten-Gruppe, indem alle zugewiesenen Statusseiten ausgewertet werden und der schlechteste Status übernommen wird – dies ist als „Worst State Wins“-Prinzip bekannt.

- **Zellenstatus:** Jede Zelle kann mehrere Statusseiten enthalten. Der Status der Zelle entspricht dem schlechtesten Status aller zugewiesenen Statusseiten.
- **Sammlungsstatus (Zeile):** Der Status einer Sammlung (Zeile) wird durch die Kumulation der Status aller Zellen in dieser Zeile berechnet. Auch hier bestimmt der schlechteste Status den Gesamtstatus der Sammlung.
- **Kategorie-Status (Spalte):** Der Status einer Kategorie (Spalte) wird durch die Kumulation der Status aller Zellen in dieser Spalte berechnet. Der schlechteste Status in der Spalte wird als Kategorie-Status angezeigt.

Dieses Vorgehen stellt sicher, dass kritische Probleme innerhalb einer Gruppe sofort auf Sammlungs- oder Kategorie-Ebene sichtbar sind und Sie schnell reagieren können.

![](/images/status-page-groups/create-status-page-group-step2.png)

### Ansicht

Die Ansicht einer Statusseiten-Gruppe beginnt mit dem Namen der Gruppe, gefolgt von einer optionalen Beschreibung.

Oben wird ein großes Icon angezeigt, das den Gesamtstatus der Statusseiten-Gruppe visuell darstellt. Der Status wird durch die Kumulation aller zugewiesenen Statusseiten nach dem „Worst State Wins“-Prinzip berechnet.

#### Verfügbare Zustände

 - **Lila:** Nicht im Monitoring
 - **Grün:** Betrieb
 - **Gelb:** Leistungsprobleme
 - **Rot:** Schwerwiegender Ausfall
 - **Grau:** Unbekannt

Neben dem Icon wird ein Zähler angezeigt, der die Gesamtanzahl der Hosts und Services darstellt, die von der Statusseiten-Gruppe repräsentiert werden.

Darunter kann ein optionales Freitextfeld angezeigt werden, das für nützliche Informationen wie Telefonnummern, E-Mail-Adressen oder andere Details genutzt werden kann.

Alle aktuellen Probleme werden als Lauftext (Marquee) angezeigt, sodass kritische Probleme sofort sichtbar sind.

#### Statusübersicht

Der Bereich „Statusübersicht“ zeigt die zweidimensionale Matrix aller Sammlungen (Zeilen) und Kategorien (Spalten). Jede Zelle zeigt den Status der zugewiesenen Statusseiten und ermöglicht einen schnellen Überblick über Ihre Infrastruktur.

#### Problemtabelle

Unterhalb der Matrix wird eine Tabelle angezeigt, die alle Probleme (sofern vorhanden) detailliert auflistet, damit Sie diese schnell identifizieren und beheben können.

![](/images/status-page-groups/status_page_group_view.png)

#### Dashboard

Statusseiten-Gruppen können auch zum Dashboard eines Benutzers hinzugefügt werden, um schnellen Zugriff und Monitoring zu ermöglichen.

![](/images/status-page-groups/status_page_group_widget.png)

Das Widget zeigt die gleichen Informationen wie die Standardansicht der Statusseiten-Gruppen, einschließlich Gesamtstatus, Host- und Service-Zähler, benutzerdefinierte Informationen und die Statusübersicht-Matrix.
![](/images/status-page-groups/statuspage_group_as_dashboard.png)

Sie können ein automatisches Aktualisierungsintervall für das Widget konfigurieren, damit die angezeigten Daten immer aktuell sind.

![](/images/status-page-groups/status_page_group_refresh.png)


## Autoreports <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

Das Autoreport-Modul in openITCOCKPIT ist ein konfigurierbarer Report, der automatisiert versendet werden kann. Ein
Report enthält die Ausfalldauer, maximal zulässige Ausfalldauer, sowie die Verfügbarkeit der gewählten Hosts und
Services.

### Autoreport erstellen

Um einen Autoreport zu erstellen, klicken Sie zunächst auf die Schaltfläche "Neu" in der Autoreports Übersicht.

Es öffnet sich der Autoreport Wizard, der Sie durch die Erstellung des Reports begleiten wird.

Wählen Sie zuerst einen Container für den Report aus und vergeben einen Namen.

Danach wählen Sie einen Zeitraum aus der zur Auswertung dient.

Der Bewertungszeitraum definiert den Zeitraum, ab wann ausgewertet werden soll.

Das Sendungsintervall definiert den Zeitraum, wann der Report versendet werden soll.

Danach geben Sie entweder eine garantierte Verfügbarkeit in Prozent an oder die maximale Anzahl von Ausfällen.

Die angezeigten Graphen können entweder in Prozent oder in Stunden angezeigt werden. Um dies Festzulegen müssen Sie in
dem Feld "Graph" eine auswahl tätigen.

Der Reflektionszustand definiert, ob entweder nur ein weicher und harter Zustand (hard state und soft state) oder nur
ein harter Zustand berücksichtigt werden soll.

Damit Wartungszeiten im Report nicht als Ausfälle angezeigt werden, können Sie die Option "Berücksichtige
Wartungszeiten" aktivieren.

Um Zusätzlich auch Feiertage zu berücksichtigen, aktivieren Sie die Option "Betrachte Feiertage" und wählen anschließend
einen Kalender aus.

Damit der Bericht versendet werden kann, muss zudem noch mindestens ein Benutzer ausgewählt werden.

Im nächsten Schritt wählen Sie die Hosts, aus die in dem Bericht ausgewertet werden sollen.

Es erscheint eine übersicht der Services aller gewählten Hosts. Hier können Sie auswählen wie diese ausgewertet werden
sollen.

Im letzten Schritt sehen Sie noch eine Übersicht der konfigurierten Einstellungen für den Bericht. Wenn alles passt,
klicken Sie weiter auf "Fertig"

Der Report wird nun automatisch in der angegebenen Zeit versendet. Sie haben allerdings auch die möglichkeit den Report
direkt als PDF oder HTML generieren zu lassen. Dazu klicken Sie im Menü des entsprechenden Reports auf "Generiere
Bericht".

Dort wählen Sie dann das Ausgabeformat aus und den Zeitraum der Ausgewertet werden soll. Nach dem Klick auf "Generiere
Bericht" bekommen Sie entweder den Report als PDF zum Download angeboten oder aber direkt im Browser in der HTML Version
angezeigt.

#### Berichtskonfiguration

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | Container in dem der Autoreport erstellt werden soll |
| Berichtsname | :fontawesome-solid-xmark: | Name des Autoreports |
| Berichtsbeschreibung |  | Beschreibung des Autoreports |
| Setze Start |  | Startdatum des Berichts soll definiert werden |
| Startdatum |  | Startdatum des Berichts. Kann nur bearbeitet werden wenn "Setze Start" aktiviert wurde |
| Zeitraum | :fontawesome-solid-xmark: | [Zeitraum](../configuration/timeperiods/) der berücksichtigt werden soll |
| Bewertungszeitraum | :fontawesome-solid-xmark: | Tag, Woche, Monat, Quartal oder Jahr |
| Sendungsintervall | :fontawesome-solid-xmark: | Täglich, Wöchentlich, Monatlich, Vierteljährlich, Jährlich oder niemals |
| Garantierte Verfügbarkeit | :fontawesome-solid-xmark: | Verfügbarkeit in Prozent. Es muss entweder "Garantierte Verfügbarkeit" oder "Maximale Anzahl von Ausfällen" angegeben sein |
| Maximale Anzahl von Ausfällen | :fontawesome-solid-xmark: | Maximale Anzahl von Ausfällen. Es muss entweder "Garantierte Verfügbarkeit" oder "Maximale Anzahl von Ausfällen" angegeben sein |
| Graph |  | Graph in Prozent oder Stunden |
| Reflexionszustand | :fontawesome-solid-xmark: | Der auszuwertende Statustyp. Hard-State oder Soft und Hard-State |
| Berücksichtige Wartungszeiten |  | Wartungszeiten zählen nicht als Ausfälle, wenn aktiviert |
| Betrachte Feiertage |  | Feiertage werden berücksichtigt |
| Kalender |  | Kalender mit Feiertagen. Nur konfigurierbar, wenn "Betrachte Feiertage" aktiviert ist |
| Benutzer |  | Benutzer an den der Bericht gesendet wird |

#### Host- und Servicekonfiguration

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Hosts | :fontawesome-solid-xmark: | Hosts die ausgewertet werden sollen |
| Service RegEx |  | Filter für Services als Regulärer Ausdruck |


### Autoreport Globals

Im Hauptmenü unter Systemkonfiguration → System → Autoreport Globals lassen sich verschiedene Standardeinstellungen zu
den Autoreports einstellen. Beschreibungen zu den einzelnen Optionen finden sich direkt in der Tabelle unter dem "Info
Button".

![](/images/autoreportModule-globalsinfo.png)

Bitte Beachten Sie, dass die Optionen die Sie dort setzen sich auf alle über das Autoreport-Modul generierten Berichte
auswirkt!