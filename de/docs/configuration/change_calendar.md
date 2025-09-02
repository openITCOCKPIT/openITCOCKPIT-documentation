# Change Kalender <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

Mit dem Change Kalender Feature können Infrastrukturänderungen direkt in openITCOCKPIT geplant werden. Dabei kann es sich um den Umzug von Servern, das Upgrade von Diensten und vieles mehr handeln. Alle Changes können direkt in openITCOCKPIT geplant werden und alles findet sich zentral in einer Ansicht. Die Organisation der Changes findet in einem anderen Tool statt? Auch das kein Problem! Der openITCOCKIT Change Calendar ist in der Lage, Changes als CSV-Datei zu importieren.

## Kalender Management

Im Menü ist der Changekalender unter `Changekalender` aufrufbar. Hier können Änderungskalender aufgelistet, hinzugefügt, geändert und gelöscht werden.

![](/images/change_calendar/list_calendars.png)

## Neuen Kalender erstellen

Um einen neuen Kalender von Grund auf zu erstellen, muss man auf die Schaltfläche "+ Neu" in der oberen rechten Ecke des Bildschirms klicken.

![](/images/change_calendar/new_calendar.png)

**Erforderliche Felder:**

- Container
    - Dieses Feld bietet die Möglichkeit, den Kalender und seine Ereignisse nur den Nutzern im ausgewählten Container anzuzeigen.
- Name
    - Anders als in der ersten Version des Moduls ist das Namensfeld nicht eindeutig.

**Weitere Informationen:**

- Beschreibung
    - Zusätzliche Information zu dem Kalender.
- Farbe
    - Zur Unterscheidung können unterschiedliche Farbe für den Kalender genutzt werden, die in dem Widget verwendet werden.
    - Das hilft den Nutzern, die verschiedenen Kalender, die in einem einzigen Widget erscheinen, zu unterscheiden.

![](/images/change_calendar/new_calendar_example.png)

**Changekalender erfolgreich erstellt**

![](/images/change_calendar/calendar_created_success.png)

## Managing Events

Auf der Kalender-Indexseite können bestehende Kalender geändert werden, wenn der/die Nutzer/in die Rechte dafür hat. 
Mit dem Recht, einen Kalender zu bearbeiten, hat der Nutzer die Möglichkeit, die Daten des Kalenders selbst und die zugrunde liegenden Ereignisse zu bearbeiten.

![](/images/change_calendar/manage_calendar.png)

### Erzeuge ein Event

Ein Ereignis kann mit einem Klick auf eines der "+"-Zeichen innerhalb eines Tages erstellt werden.

![](/images/change_calendar/calendar_create_event.png)

### Ändern eines Events

Die Events können geändert werden, indem auf ein bestehendes Ereignis in der Kalenderverwaltung geklickt wird.

![](/images/change_calendar/calendar_modify_event.png)

Das Event kann dann geändert oder gelöscht werden.

![](/images/change_calendar/calendar_modify_delete_event.png)

## Kalender Widget

Für den Kalender existiert auch ein Widget, das im Dashboard mit eingebunden werden kann.

### Erstellung eines Widgets

Zunächst werden alle Kalender ausgewählt, die im Widget angezeigt werden sollen.

![](/images/change_calendar/calendar_widget_1.png)

Der Anzeigetyp ist der Zeitbereich für den Kalender.

![](/images/change_calendar/calendar_widget_2.png)

Wenn das Widget gespeichert wird, werden die ausgewählten Kalender im Widget angezeigt.

![](/images/change_calendar/calendar_widget_3.png)

## CLI Import

Es gibt auch die Möglichkeit, die Änderungen über CSV-Dateien zu importieren.

Für einen erfolgreichen Import benötigen die CSV-Dateien die folgenden Informationen:
```
UID,Calendar,Start,End,Title,Description,Context
```

Eine Beispieldatei könnte wie folgt aussehen:

```
UID,Calendar,Start,End,Title,Description,Context
"ACTE000001","Another Calendar","2023-09-10T14:00:00+00:00","2023-09-10T15:00:00+00:00","Test Import Command One","Description of the imported event.","[{'name': 'A custom field',	'value': 'Test value. It is an error. Please hold the line.', 'class': 'danger'}]"
"ACTE000002","Another Calendar","2023-09-10T14:00:00+00:00","2023-09-10T15:00:00+00:00","Test Import Command Two","Yes, this is also a description.","[{ 'name': 'A custom field', 'value': 'Test value. It was working but with warnings.', 'class': 'warning'}]"
"ACTE000003","Another Calendar","2023-09-10T14:00:00+00:00","2023-09-10T15:00:00+00:00","Test Import Command Three","Aaaaand another description for an imported event.","[{ 'name': 'A custom field', 'value': 'Three is a charm. Now it is working properly.', 'class': 'success'}]"
```

Der Import wird durch Ausführen des folgenden Befehls gestartet:
```
oitc ChangecalendarModule.Import -f /tmp/kalender.csv
```

!!! info "Hinweis"
    Die importierte Datei bleibt unangetastet. Sie wird nur während des Imports gelesen und nicht mit bestehenden Events synchronisiert.

!!! warning "Hinweis"
    Die Importdatei enthält ein zusätzliches Feld, das zur eindeutigen Identifizierung eines Events dient. Ein bestehendes Event wird in diesem Fall beim Import aktualisiert.
