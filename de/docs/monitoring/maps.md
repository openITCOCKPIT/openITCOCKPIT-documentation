# Karten

## Status Karte

Die Statuskarte ist eine automatisch erstellte Karte, die alle Hosts mitsamt ihrem Status auf einer Karte darstellt.

Mit einem Klick auf einen Host wird ein popup angezeigt, welches den Status der Services anzeigt.

Parent-Child Beziehungen können angezeigt werden bei einem klick auf "Eltern-Kind-Beziehungen berücksichtigen"


## Automatische Karte

Eine automatische Karte zeigt Host und Services anhand eines selbst definierten Filters an.

### Automap erstellen

Um eine Automap zu erstellen, klicken Sie zunächst auf die Schaltfläche "Neu" in der "Automatische Karten" Übersicht.

Im Formular wählen Sie einen Container aus und vergeben einen Namen.

Sie können zusätzlich das Feld rekursiv auswählen. Dies bewirkt, dass auch Hosts unterhalb des gewählten Containers berücksichtigt werden.

Anschließend setzen Sie die Filter fest, nach denen entschieden wird, welche Host und Services angezeigt werden sollen.

Die Filter bestehen aus jeweils einem regulären Ausdruck für den Host und Service Filter.

Anschließend legen Sie fest, welcher Status angezeigt werden darf und wie die Darstellung erfolgen soll. Im rechten unteren Bildrand sehen Sie eine Vorschau zu den gewählten Anzeigeoptionen.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | Container in dem die Automatische Karte erstellt werden soll |
| Name | :fontawesome-solid-xmark: | Name der Automatischen Karte |
| Beschreibung |  | Beschreibung der Automatischen Karte |
| Host RegEx | :fontawesome-solid-xmark: | Host Filter als Regulärer Ausdruck |
| Service RegEx | :fontawesome-solid-xmark: | Service Filter als Regulärer Ausdruck |


## Map Modul <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>


Das Map Modul oder Karten Modul ist eine frei verfügbare Erweiterung in openITCOCKPIT. Es bietet die möglichkeit die überwachten Objekte visuell darzustellen und dies mit eigenen Hintergründen zu versehen. So kann beispielsweise eine Geländekarte oder eine Server Rack direkt mit überwachten Objekten oder unterkarten versehen werden.

### Karte erstellen

Eine Karte benötigt, bevor Sie visuell bearbeitet werden kann zunächst einige Informationen

Hier wählt man zuerst mindestens einen Container aus, in dem die Karte verfügbar sein soll.

Danach vergibt man einen Kartennamen sowie einen Titel.

Das Feld Aktualisierungsintervall legt fest, in welchem Intervall in Sekunden eine Karte in der Kartenansicht aktualisiert werden soll.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | Container in dem die Karte erstellt werden soll |
| Satellit |  | Satellitensystem auf dem die Karte erstellt werden soll |
| Kartenname | :fontawesome-solid-xmark: | Name der Karte |
| Kartentitel | :fontawesome-solid-xmark: | Titel der Karte |
| Aktualisierungsintervall | :fontawesome-solid-xmark: | Bestimmt das Intervall in Sekunden, in dem die Karte Ihre Elemente aktualisiert |

### Karte bearbeiten

Hat man ein Karten Grundgerüst erstellt, kann die visuelle Bearbeitung erfolgen.

Dazu klickt man neben das Zahnradsymbol der entsprechenden Karte (1) und anschließend auf "Bearbeite im Karteneditor" (2)

![](/images/mapmodule-editinmapeditor.png)

Nun ist man im Karten editor angelangt und kann nun über das Seitenmenü verschiedene Aktionen erledigen.

![](/images/mapmodule-mapeditorsidemenu.png)

- 1\. Items

Items können Hosts, Services, Hostgruppen und Servicegruppen sein. Darüber hinaus können andere Karten verlinkt werden.

Items werden mit Iconsets dargestellt. Eigene Iconsets können auch genutzt werden.

- 2\. Linien

Linien können Hosts, Services, Hostgruppen und Servicegruppen, Karten und einfache, Statuslose Linien sein.

- 3\. Zusammenfassungsstatuselement

Das Zusammenfassungsstatuselement setzt sich aus mehreren überwachten Objekten zusammen.

Dies kann je nach ausgewähltem Objekt ein Host und mindestens ein Service oder mehrere Hosts und mehrere Services sein.

- 4\. Gadgets

Gadgets sind unterschiedliche Anzeigeelemente. Dies können Graphen, Tachos, Ampeln o.ä. sein.

Der Unterschied zu den vorhergehenden Elementen ist, dass ein Gadget immer nur ein Service sein kann, da hier immer Performancedaten zu grunde liegen müssen.

- 5\. Hintergrundbild ändern

Hier können Sie Hintergrundbilder für Ihre Karten hochladen und auch wieder entfernen.

- 6\. Text hinzufügen

Mit diesem Tool können sie Text in Ihre Karte einfügen.

- 7\. Icons

Hier können Sie Icons hochladen und auf Ihrer Karte platzieren. Der Unterschied zu Items ist, dass diese Icons keinen Status anzeigen.

##### Eigene Items / Iconsets

Um ein eigenes Iconset hochzuladen, müssen Sie alle erforderlichen Icons in ein ZIP-Archiv komprimieren.
Alle Symbole müssen PNG-Bilder sein.
Benötigte Icons:

| Icon | Beschreibung |
| --- | --- |
| up.png | Host status up |
| down.png | Host Status down |
| unreachable.png | Host Status unreachable |
| ack.png | Bestätigter Hoststatus |
| downtime.png | Host Downtime |
| downtime\_ack.png | Host Bestätigt und in Downtime |
| error.png |     |
| ok.png | Service Status ok |
| warning.png | Service Status warning |
| critical.png | Service Status critical |
| unknown.png | Service Status unknown |
| sack.png | Bestätigter Servicestatus |
| sdowntime.png | Service Downtime |
| sdowntime\_ack.png | Service Bestätigt und in Downtime |

Die folgenden Farb-Guidelines können dazu genutzt werden.

![](/images/mapmodule-colorguidelines.png)

### Karte anzeigen

Es gibt in openITCOCKPIT zwei mögliche Karten ansichten für das Karten Modul. Die Erste möglichkeit ist der "normale" ansichtsmodus. dazu klickt man in der Kartenübersicht auf das Menü der entsprechenden Karte (1) und wählt anschließend "Anzeigen" aus.

![](/images/mapmodule-viewmap.png)

Um zur Vollbild ansicht zu gelangen, öffnet man in der Kartenübersicht das Menü der entsprechenden Karte (1) und wählt anschließend "im Vollbild anzeigen" (2) aus

Diese Ansicht eignet sich beispielsweise zum Anzeigen auf einem TV-Gerät.

![](/images/mapmodule-viewmapfullscreen.png)

### Rotationen

Karten Rotationen wechseln eine selbst bestimmte Anzahl von Karten in einem Intervall durch.

### Rotation erstellen

Um eine Rotation zu erstellen, klicken Sie im Hauptmenü Karten → Rotationen.

Dort klicken Sie in der Übersicht auf die Schaltfläche "Neu".

Im Formular wählen Sie die entsprechenden Container aus und vergeben einen Namen für die Rotation.

Danach legen Sie das Rotationsintervall fest. Dies bestimmt die Zeit in Sekunden, die eine Karte sichtbar ist, bevor sie durch die nächste ausgewechselt wird.

Zum Schluss wählen Sie noch die Karten aus die Rotiert werden sollen.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | Container in dem die Rotation erstellt werden soll |
| Rotationsname | :fontawesome-solid-xmark: | Name der Rotation |
| Rotationsintervall | :fontawesome-solid-xmark: | Das Intervall in dem die gewählten Karten rotieren sollen |
| Karten | :fontawesome-solid-xmark: | Karten die rotieren sollen |

### Rotation anzeigen

Um eine vorhandene Rotation anzuzeigen, gibt es wie im Kartenmodul auch zwei Ansichtsmodi.

Für den "normalen" Ansichtsmodus klicken Sie zunächst auf das Menü der entsprechenden Rotation (1) und anschließend auf "Anzeigen" (2)

![](/images/mapmodule-rotationview.png)

Wenn Sie die Rotation im Vollbild modus anschauen möchten, klicken Sie wieder zunächst auf das Menü (1) der entsprechenden Rotation und anschließend auf die Schaltfläche "Im Vollbild anzeigen" (2)

![](/images/mapmodule-rotationviewfullscreen.png)

### Karten Generatoren

Karten Generatoren können automatisch Karten mit Zusammenfassungselementen erstellen.

![](/images/mapmodule-mapgeneratorindex.png)

#### Generierung durch Container-Struktur

Als Ausgangspunkt der Generierung dienen die Hosts. Es werden alle Hosts sowie Container von jeden Host bis zum Mandanten-Container berücksichtigt. Für jeden dieser Container wird eine Karte erstellt. Karten/Container, die hierarchisch in der Container-Struktur weiter unten stehen, werden den darüberliegenden Karten als Zusammenfassungselemente hinzugefügt, sodass die Container-Struktur durchgeklickt werden kann. Hosts werden ebenfalls der generierten Karte, die den zugewiesenen Container darstellt, als Zusammenfassungselemente hinzugefügt.

![](/images/mapmodule-mapgeneratormapexample.png)

Die Generierung kann durch die Angabe von Start-Containern eingeschränkt werden. Wenn Start-Container definiert sind, muss einer dieser Container in der Container-Hierarchie des Hosts bis zum Mandanten-Container vorkommen. Andernfalls wird der Host sowie dessen Hierarchie ignoriert. Diese Start-Container bilden dann die ersten Container in der Hierarchie, anstelle des Mandanten-Containers.

![](/images/mapmodule-mapgeneratorgeneratedmaps.png)

Die generierten Karten erhalten den Mandanten-Container oder, bei Verwendung von Start-Containern, den jeweiligen Start-Container in der Hierarchie als zugewiesenen Container.

Das Feld „Elemente pro Zeile“ gibt an, wie viele Elemente in einer Reihe platziert werden, bevor ein Zeilenumbruch erfolgt.

![](/images/mapmodule-mapgeneratoredit.png)

Eine Karten-Generierung kann erneut gestartet werden. Dabei werden neue Elemente zu den bestehenden generierten Karten hinzugefügt oder neue Karten und Elemente erstellt, falls neue Hosts oder Container vorhanden sind.

![](/images/mapmodule-mapgeneratorgenerate.png)

## OpenStreetMap <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

### Was kann ich mit dem OpenStreetMap Modul tun?

Das openStreetMap-Modul ist in der Lage, Standorte auf einer "realen Welt" - Karte darzustellen, indem der Status aller enthaltenen Hosts zusammengefasst wird.

### Was kann man konfigurieren?

Unter "Systemkonfiguration → APIs → OpenStreetMap" sind die Einstellungen für das OpenStreetMap Modul zu finden.

Die Filter "Location status" und "Empty Locations" sind Standard Einstellungen und können über die Filteroption in der OpenStreetMap Ansicht temporär angepasst werden.

| Feld Name | Erforderlich | Beschreibung |
| --- | --- | --- |
| Server Adresse | :fontawesome-solid-xmark: | Ist die volle Adresse des OpenStreetMap Tile Servers, über welchen das Modul die Map Daten versucht abzurufen. **Beispiel**: [http://10.10.10.20/osm\_tiles/{z}/{x}/{y}.png](http://10.10.10.20/osm_tiles/%7Bz%7D/%7Bx%7D/%7By%7D.png) |
| Kartenaktualisierungsintervall | :fontawesome-solid-xmark: | Intervall in Sekunden, mit dem die Map in der Ansicht aktualisiert wird (Standard: 30) |
| Standorte mit Status anzeigen |     | Definiert die Standard Zustände der Locations, die in der Ansicht angezeigt werden sollen |
| Leere oder nicht überwachte Standorte |     | Die Option "Leere oder nicht überwachte Standorte" verhindert, dass leere Locations in der OpenStreetMap Ansicht angezeigt werden. |
| Erweiterte Einstellungen | |  |