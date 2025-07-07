# Theming und CI <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

## Design Modul

Das Erscheinungsbild von openITCOCKPIT kann mithilfe des DesignModule, welches über den [integrierten Paketmanager](/configuration/packagemanager/) von openITCOCKPIT installiert werden kann, nach Bedarf angepasst werden.

Über den Designeditor lassen sich die Farben der Weboberfläche, sowie die vom System verwenden Logos
anpassen. Dafür sind keine Programmierkenntnisse erforderlich.

![Modify the openITCOCKPIT theme](/images/openitcockpit-design-editor.png)

### Design Exportieren / Importieren

Eigene Designs können exportiert und auf einem anderen openITCOCKPIT Systemen importiert werden.

Um ein Design exportieren zu können, muss zunächst ein eigenes Design erstellt und abgespeichert werden.
Danach scrollen Sie im Design Editor nach ganz unten. Dort finden Sie eine Schaltfläche
"Exportieren Sie das aktuell gespeicherte Design". Damit bekommen Sie das aktuelle Design als eine `.json` Datei zum Download zur Verfügung gestellt.

Um ein exportiertes Design wieder zu importieren, klicken Sie auf die Schaltfläche "Importieren" und laden die entsprechende `.json` Datei hoch.

Über diese Methode können Sie zum Beispiel unser [Halloween Thema für openITCOCKPIT ](https://github.com/it-novum/oitc-halloween-theme) laden.

![Halloween theme for openITCOCKPIT](/images/openitcockpit-Halloween-login.jpg)

### Eigenes CSS

Für komplette Gestaltungsfreiheit besteht die Möglichkeit, eigene CSS-Regeln zu hinterlegen. Somit können alle Abstände, Farben und
Schriftarten nach Bedarf angepasst werden.

!!! tip
    Das Erstellen von CSS-Regeln erfordert Kenntnisse von Cascading Stylesheets und sollte nur von erfahrenen Benutzern
    eingerichtet werden.


!!! Angular-Selektoren
Es können wiederverwendete Angular-Komponenten anhand ihres Selektors systemweit gestylt werden. Zum Beispiel können Sie unsere Statussymbole so umgestalten. Beispielsweise können mit diesem Code alle Service- und Host-Status-Icons im Fehlerfall zum Blinken gebracht werden.

```CSS
/* Make status icons blink */
oitc-hoststatus-icon .btn-danger {
  animation: alarmAnimation 1s steps(2, start) infinite;
  -webkit-animation: alarmAnimation 1s steps(2, start) infinite;
}
oitc-servicestatus-icon .btn-danger {
  animation: alarmAnimation 1s steps(2, start) infinite;
  -webkit-animation: alarmAnimation 1s steps(2, start) infinite;
}

@keyframes alarmAnimation {
  to {
    background:red;
  }
  from {
    background:yellow;
  }
}
@-webkit-keyframes alarmAnimation {
  to {
    background:red;
  }
}
```