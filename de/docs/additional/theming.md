# Theming und CI <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

## Design Modul

Das Erscheinungsbild von openITCOCKPIT kann mithilfe des DesignModule, welches über den integrierten
Paketmanager von openITCOCKPIT installiert werden kann, nach Bedarf angepasst werden.

Über den Designeditor lassen sich die Farben der Weboberfläche, sowie die vom System verwenden Logos
anpassen. Dafür sind keine Programmierkenntnisse erforderlich.

![Modify the openITCOCKPIT theme](/images/openitcockpit-design-editor.png)

Neben dem standard mäßig genutzten hellen Theme, bietet openITCOCKPIT auch ein dunkles Theme.
Dieses ist vorkonfiguriert und lässt sich über die Schaltfläche "Dunkles Thema" im Designeditor laden.
Zum Anwenden klicken Sie im Anschluss auf "Stil aktualisieren".

![Default openITCOCKPIT dark theme](/images/openitcockpit-dark-theme.png)

### Design Exportieren / Importieren

Eigene Designs können exportiert und auf einem anderen openITCOCKPIT Systemen importiert werden.

Um ein Design exportieren zu können, muss zunächst ein eigenes Design erstellt und abgespeichert werden.
Danach scrollen Sie im Design Editor nach ganz unten. Dort finden Sie eine Schaltfläche
"Exportieren Sie das aktuell gespeicherte Design". Damit bekommen Sie das aktuelle Design als eine `.json` Datei zum Download zur Verfügung gestellt.

Um ein exportiertes Design wieder zu importieren, klicken Sie auf die Schaltfläche "Importieren" und laden die entsprechende `.json` Datei hoch.

Über diese Methode können Sie zum Beispiel unser [Halloween Thema für openITCOCKPIT ](https://github.com/openITCOCKPIT/oitc-halloween-theme) laden.

![Halloween theme for openITCOCKPIT](/images/openitcockpit-Halloween-login.jpg)

### Eigenes CSS

Für komplette Gestaltungsfreiheit besteht die Möglichkeit, eigene CSS-Regeln zu hinterlegen. Somit können alle Abstände, Farben und
Schriftarten nach Bedarf angepasst werden.

!!! tip
    Das Erstellen von CSS-Regeln erfordert Kenntnisse von Cascading Stylesheets und sollte nur von erfahrenen Benutzern
    eingerichtet werden.

