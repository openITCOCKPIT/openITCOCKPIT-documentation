Mit dem Container-Visualisierungsbaum können Container unabhängig von Berechtigungen in einer frei definierbaren
Baumstruktur angeordnet und visualisiert werden. Die Zuordnung erfolgt per Parent/Child-Beziehung und dient
ausschließlich der übersichtlichen Darstellung und Gruppierung von Containern, ohne Auswirkungen auf die Zugriffsrechte.

Auf der Browser-Übersicht `/browser` Seite wird eine alternative Sicht der Containerstruktur angezeigt. Diese Übersicht
dient dazu Organisationsstruktur sowie derer Abhängigkeiten visuell darzustellen.

![](/images/organizational_trees/status_tree.png)

In der Übersicht werden im System hinterlegte Rechte berücksichtigt. Das bedeutet alle Container, auf die ein Benutzer
keine Rechte hat, werden automatisch ausgeblendet. Anhand der Container-Id soll ein zusätzlicher Tab für Organigramm angezeigt werden.

![](/images/organizational_trees/browser_tree.png)

Es können mehrere virtuelle Bäume, je Container erstellt werden. Für die
Host-Statusübersicht, wird die Einstellung des virtuellen Containers `is_recursive` für das Auflösen aller
Child-Container
berücksichtigt. Zusätzlich können mehrere Benutzer (openITCOCKPIT Benutzer) hinterlegt werden (optional), um bei einem
Ausfall als die richtige Ansprechperson identifiziert zu werden.

##Konfiguration der virtuellen Bäume

Im Konfigurationsbereich kann ein Organigramm erstellt und bearbeitet werden. Folgende Felder stehen zur Verfügung:

* Name des Baumes (Pflichtfeld)
* Beschreibung (optional)

Auf der linken Seite befindet sich eine Auswahl verfügbarer Container-Typen, wie:

* Mandant
* Standort
* Knoten

Diese Auswahl kann per Drag & Drop in den rechten Bereich gezogen und frei positioniert werden.

![](/images/organizational_trees/config_edit.png)

Über `Bearbeiten` Button kann Bearbeitungsbereich eines bestimmten Knotens geöffnet werden.

![](/images/organizational_trees/edit.png)

Es öffnet sich ein neues Fenster, in dem je nach Typ ein bestimmter Container ausgewählt werden kann. Zusätzlich können
weitere Einstellungen vorgenommen werden:

* Containername (Pflichtfeld)
* `is_recursive` Wenn diese Option aktiviert ist, werden Host und Service-Statusübersicht für alle Child-Container des
  ausgewählten Containers berücksichtigt und angezeigt.
* Regional manager (optional)
* Manager (optional)
* Benutzer (optional)

![](/images/organizational_trees/config_modal.png)
