# Import / Export <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

Die Import/Export-Funktionalität in openITCOCKPIT ist der geeignete Weg, um Konfigurationselemente zwischen mehreren Systemen zu übertragen. Sie ist Teil des Importmoduls.

In einem ersten Schritt können Elemente für Kommandos, Zeiträume, Kontakte, Kontaktgruppen, Servicetemplates und Servicetemplate-Gruppen als json-Datei exportiert werden. Wenn es Abhängigkeiten zwischen z.B. Servicetemplates und Kontakten gibt, werden diese automatisch erkannt und exportiert.

Der zweite Schritt ist der Import der Datei auf einem anderen Master-System. Das ist genauso einfach wie der Export. Dabei erkennt das Modul, ob das importierte Service-Template ein neues Template ist oder bereits existiert. Wenn es ein neues Template ist, zeigt ein Banner an, dass es keine Importkonflikte gibt. Wenn das Servicetemplate bereits existiert, wird eine Benachrichtigung angezeigt und die Unterschiede zwischen der aktuellen und der neuen Konfiguration angezeigt.

Wechsele zu `Verwaltung -> Objektimport -> Export / Import`

## Export der Configuration Items

Zunächst werden alle Elemente ausgewählt, die exportiert werden sollen. Wie bereits erwähnt, erkennt das Modul Abhängigkeiten zu anderen Elementen und Abhängigkeiten müssen nicht beachtet werden. Wenn zum Beispiel ein Servicetemplate exportiert wird, werden automatisch die Kommandos, Kontakte etc. mit übernommen.

![Screenshot: Export der Configuration Items](/images/import_export/export_items.png)

Mit einem Klick auf __*Export configuration items*__, wird eine .json-Datei erzeugt, die für den Import auf einem anderen System verwendet werden kann.

!!! info "Hinweis"
    Während des Imports wird die Prüfsumme der Datei überprüft und nur importiert, wenn die Prüfsumme korrekt ist. Eine Veränderung der exportierten Datei ist somit nicht möglich.

## Import der Configuration Items

!!! warning "Hinweis"
    Bevor mit dem Import begonnen wird, sollte eine Sicherungskopie der Datenbank erstellt werden.

Für den Import wird die exportierte .json-Datei benötigt. Die Datei kann einfach per Drag-and-Drop in das Upload-Feld gezogen werden oder es kann durch einen Klick auf das Feld nach der Datei gesucht werden.

![Screenshot: Import der Configuration Items](/images/import_export/import_file.png)

### Zusammenfassung
Nachdem die Datei ausgewählt wurde, zeigt das Modul eine Zusammenfassung des Imports und mögliche Konflikte an.

![Screenshot: Zusammenfassung](/images/import_export/import_summary.png)

### Ausschließliche neue Items

Werden nur neue Elemente importiert, zeigt das Modul im Bereich __*Import*__ an, dass keine Konflikte gefunden wurden und dass der Import ohne Probleme durchgeführt werden kann.

![Screenshot: Ausschließliche neue Items](/images/import_export/import_ready.png)

### Abweichungen zu bestehenden Konfigurationen

Im Falle des Überschreibens bestehender Elemente gibt das Modul eine Warnung aus und zeigt die Änderungen im Detail an.

![Screenshot: Abweichungen zu bestehenden Konfigurationen](/images/import_export/import_danger.png)

Der Import kann aber auch dann durchgeführt werden, wenn es Unterschiede in der Konfiguration gibt.

### Import erfolgreich

Eine abschließende Meldung zeigt an, dass der Import erfolgreich abgeschlossen wurde und dass alle Änderungen im Changelog protokolliert wurden.

![Screenshot: Import erfolgreich](/images/import_export/import_finished.png)

## Changelog

Wie üblich werden alle Änderungen im Changelog protokolliert. Der angemeldete Benutzer wird als der Benutzer verwendet, der die Änderungen vorgenommen hat. Auf diese Weise ist es auch bei einem Import möglich zu verfolgen, wer die Änderungen vorgenommen hat.

![Screenshot: Changelog](/images/import_export/changelog.png)