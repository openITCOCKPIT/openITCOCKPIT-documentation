# Ereigniskorrelation (Eventcorrelation) <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

Das Ereigniskorrelationsmodul in openITCOCKPIT ist eine sehr hilfreiche Komponente, wenn es darum geht, aus verschiedenen Services einen einzigen Gesamtstatus zu bekommen.

Eine Ereigniskorrelation ist ein virtueller Host, der virtuelle Services hat.

Beim Erstellen einer Ereigniskorrelation wird daher ein Host erstellt, der von einer Hostvorlage vom Typ "EVC Template" abgeleitet wird.

Diesen virtuellen Host ist nachher in der Host-Übersicht genauso sichtbar wie ein Real existierender Host.

## Ereigniskorrelation erstellen

Nachdem der Host für die Ereigniskorrelation erstellt wurden, kann man die Ereigniskorrelation selbst bearbeiten.

In einer neuen Ereigniskorrelation ist Grundsätzlich anfangs eine einzige Ebene Sichtbar. Auf dieser Ebene klickt man auf die Schaltfläche "Neuer vService".

Mehrere Services können durch logische Operatoren miteinander verbunden werden. Dabei wird nach einem logischen Operator immer ein virtueller Service (vService) erstellt, der den Status, der aus den Services und dem Operator resultiert, annimmt.

Da die virtuellen Services wie echte Services auf dem System behandelt werden, ist es möglich, dass die Services die man zu einer Verknüpfung hinzufügen möchte, auch virtuelle Services aus einer anderen Ereigniskorrelation sein können.

Es gibt folgende Operatoren:

### UND / AND

Der "UND" Operator verlangt, dass alle seine Services den Status OK haben, damit der virtuelle Service auch den Status OK bekommt.

![](/images/EVC-andOperator.png)

### ODER / OR

Beim "ODER" Operator muss mindestens ein Service den Status OK haben, damit der virtuelle Service den Status OK bekommt.

![](/images/EVC-orOperator.png)

### GLEICH / EQUAL

Der "GLEICH" oder "EQUAL" Operator kann nur einen Service haben. Dieser Operator eignet sich dazu ein Servicestatus "durchzuschleifen" um ihn in einer späteren Ebene wieder verwenden zu können.

![](/images/EVC-eqOperator.png)

### MIN

Min ist ein Operator, der zusätzlich noch eine Zahl als Angabe benötigt. Diese Zahl gibt an, wie viele Services den Status OK haben müssen, damit der virtuelle Service den Status OK bekommt.

![](/images/EVC-min2Operator.png)

### SCORE

Der Score-Operator ermöglicht es, die Gesamtgesundheit mehrerer Services zu bewerten, indem den Zuständen der Services Punktwerte zugewiesen und die Gesamtsumme mit einem definierten Schwellenwert verglichen wird.

- Jeder Service kann einen von vier Zuständen haben: **Ok**, **Warnung**, **Kritisch** oder **Unbekannt**.
- Der Zustand **Ok** hat immer einen Punktwert von Null (`0`).
- Für die anderen Zustände (**Warnung**, **Kritisch**, **Unbekannt**) können für jeden Service individuelle Punktwerte (Score) festgelegt werden. Bleibt ein Wert leer, wird er als Null (`0`) behandelt.

**Beispiel:**

| Service            | Warnung Score | Kritisch Score | Unbekannt Score                 |
|--------------------|---------------|----------------|---------------------------------|
| CPU-Auslastung     | `1`           | `5`            | `10`                            |
| Festplattennutzung | `5`           | `10`           | `leer` (wird als `0` behandelt) |


Wenn die "CPU-Auslastung" im Warnung-Zustand und die "Festplattennutzung" im **Kritisch**-Zustand ist, ergibt sich eine Gesamtpunktzahl von **11**. `1` (CPU-Auslastung) + `10` (Festplattennutzung) = **11**.

Für den Operator können Schwellenwerte festgelegt werden, zum Beispiel:

- Warnung: `5`
- Kritisch: `10`
- Unbekannt: `900`

Der Operator vergleicht die Gesamtpunktzahl mit diesen Schwellenwerten, um das Gesamtergebnis zu bestimmen:

- Ist die Gesamtpunktzahl kleiner als der Warnung-Schwellenwert, ist das Ergebnis **Ok**.
- Ist die Gesamtpunktzahl größer oder gleich dem Warnung-Schwellenwert, aber kleiner als der Kritisch-Schwellenwert, ist das Ergebnis **Warnung**.
- Ist die Gesamtpunktzahl größer oder gleich dem Kritisch-Schwellenwert, ist das Ergebnis **Kritisch**.
- Ist die Gesamtpunktzahl größer oder gleich dem Unbekannt-Schwellenwert, ist das Ergebnis **Unbekannt**.

Dieses System hilft, den kombinierten Status Ihrer Services flexibel anhand ihrer individuellen Zustände und Ihrer gewählten Bewertungsregeln zu beurteilen.

Punktwerte können negative oder positive Werte sein und die Operator-Schwellenwerte können nach Ihren Anforderungen gesetzt werden. Ein Wert von `Unendlich` wird nicht unterstützt, aber Sie können einen sehr hohen Wert verwenden, um einen ähnlichen Effekt zu erzielen.

![](/images/evc_scoring_operator.png)

Der SCORE-Operator kann in vier verschiedenen Modi arbeiten:

- SCORE Skalar ≥ (größer-gleich): Die Gesamtpunktzahl wird mit den Schwellenwerten per größer-gleich-Vergleich verglichen. Beispiel: Ist die Gesamtpunktzahl 11 und der Warnung-Schwellenwert 5, ist das Ergebnis Warnung, da 11 ≥ 5.
- SCORE Skalar ≤ (kleiner-gleich): Die Gesamtpunktzahl wird mit den Schwellenwerten per kleiner-gleich-Vergleich verglichen. Bei diesem Operator gilt je niedriger der Punktewert ist, desto schlechter ist der Status. Das heißt der Warnung Schwellwert sollte höher sein als der Kritisch-Schwellwert. Der Unbekannt-Wert sollte am 
niedrigsten sein. Beispiel: Der Warnung-Schwellwert ist 15, der Kritsch-Schwellwert ist 10 und der Unbekannt-Schwellwert ist 0. Ist die Gesamtpunktzahl 13, ist das Ergebnis Warnung, da 13 ≤ 15. Ist die Gesamtpunktzahl 10, ist das Ergebnis Kritsch, da 10 ≤ 10 etc. 
- SCORE Bereich Inklusiv (≥ 10 und ≤ 20 – innerhalb des Bereichs von 10 bis 20): Die Gesamtpunktzahl wird geprüft, ob sie innerhalb eines bestimmten Bereichs liegt. Beispiel: Ist die Gesamtpunktzahl 15 und der Warnung-Schwellenwert als Bereich 10 bis 20 gesetzt, ist das Ergebnis Warnung, da 15 im Bereich liegt.
- SCORE Bereich Exklusiv (< 10 oder > 20 – außerhalb des Bereichs von 10 bis 20): Die Gesamtpunktzahl wird geprüft, ob sie außerhalb eines bestimmten Bereichs liegt. Beispiel: Ist die Gesamtpunktzahl 5 und der Warnung-Schwellenwert als Bereich 10 bis 20 gesetzt, ist das Ergebnis Warnung, da 5 außerhalb des Bereichs liegt.


In der Ansicht der Ereigniskorrelation wird für jeden Service der jeweilige Punktwert (Score) angezeigt. Die Summe aller Punktwerte (`10` + `1` = `11` im Beispiel) wird verwendet, um den Gesamtstatus des virtuellen Service anhand der definierten Schwellenwerte und des ausgewählten Score-Operators zu bestimmen.

Ein Tooltip zeigt die in der Operator-Konfiguration definierten Schwellenwerte an.

> 11 (Gesamtpunktzahl) ist ≥ 5 (Warnung-Schwellenwert)
>
> 11 (Gesamtpunktzahl) ist ≥ 10 (Kritischer-Schwellenwert) → Ergebnis: Kritisch
>
> 11 (Gesamtpunktzahl) ist nicht ≥ 900 (Unbekannter-Schwellenwert)

![](/images/EVC-scoreOperator.png)


| Feld                               | Erforderlich              | Beschreibung                                                                                                                                 |
|------------------------------------|---------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| Basiskonfiguration                 |                           |                                                                                                                                              |
| Container                          | :fontawesome-solid-xmark: | [Container](../container/#container) in dem der Host erstellt werden soll                                                                    |
| Hostvorlage                        | :fontawesome-solid-xmark: | [Hostvorlage](#hostvorlagen) von der der Host abgeleitet werden soll                                                                         |
| Host Name / Name der Korrelation   | :fontawesome-solid-xmark: | Name des Hosts bzw. Name der zu erstellenden Ereigniskorrelation                                                                             |
| Beschreibung                       |                           | Beschreibung der Hostvorlage. Wird als Beschreibung des Hosts weitervererbt                                                                  |
| Priorität                          |                           | Priorität zum filtern in Listen                                                                                                              |
| Prüfungskonfiguration              |                           |                                                                                                                                              |
| Prüfungszeitraum                   | :fontawesome-solid-xmark: | Definition, in welchem [Zeitraum](../timeperiods/) Prüfungen stattfinden sollen                                                              |
| Prüfungsintervall                  | :fontawesome-solid-xmark: | Definiert in welchem Intervall Prüfungen stattfinden sollen. Siehe [Intervalle](#intervalle)                                                 |
| Wiederholungsintervall             | :fontawesome-solid-xmark: | Definiert den Wartezeitraum bevor eine neue Prüfung stattfindet, nachdem ein nicht UP status erreicht wurde. Siehe [Intervalle](#intervalle) |
| Max. Anzahl der Prüfversuche       | :fontawesome-solid-xmark: | Bestimmt die Anzahl der Prüfversuche, bevor ein Host in einen Hard State über geht. Siehe [Intervalle](#intervalle)                          |
| Benachrichtigungskonfiguration     |                           |                                                                                                                                              |
| Benachrichtigungszeitraum          | :fontawesome-solid-xmark: | Bestimmt den Zeitraum in dem für einen Host Benachrichtigungen versendet werden.                                                             |
| Benachrichtigungsintervall         | :fontawesome-solid-xmark: | Definiert den Zeitlichen Abstand von Benachrichtigungen, die zu diesem Host versendet werden                                                 |
| Kontakte                           | :fontawesome-solid-xmark: | Ein oder mehrere Kontakte die Benachrichtigungen zu diesem Host erhalten                                                                     |
| Kontaktgruppen                     | :fontawesome-solid-xmark: | Ein oder mehrere Kontaktgruppen die Benachrichtigungen zu diesem Host erhalten                                                               |
| Optionen zu Hostbenachrichtigungen |                           | Definiert die Status die Erreicht werden müssen, damit benachrichtigt wird                                                                   |
