# Benachrichtigung / Alerting

openITCOCKPIT bietet eine vielzahl von Benachrichtigungsmethoden an. Neben der gängigsten Methode,
der [E-Mail Benachrichtigung](../../beginners/setup-email-notifications/#e-mail-benachrichtigungen-einrichten), gibt es viele weitere, die bereits out-of-the-box oder durch
die Installation von Modulen in openITCOCKPIT verfügbar sind. Einige Beispiele dafür
sind [Browser Push Benachrichtigungen](../../beginners/setup-browser-push-notifications/#browser-push-benachrichtigungen-einrichten),
[PagerDuty](../pagerduty/#pagerduty-ce), Messaging Dienste wie [Mattermost](../mattermost/#mattermost-ce), [Slack](../slack/#slack-ee) und Ticketsysteme
wie [AxiosAssyst](../axiosassyst/#axios-assyst-ce)
oder [ServiceNow](../servicenow/#servicenow-ee).



## Kontakte

Kontakte werden in openITCOCKPIT genutzt, um Benachrichtigungen zu versenden. Diese Benachrichtigungen können je nach im
Kontakt konfiguriertem Kommando beispielsweise per E-Mail, Browser Push-Benachrichtigung oder mit Erweiterungen auch
über SMS, Chat Benachrichtigung oder ähnlichem versendet werden.

### Neuen Kontakt erstellen

Um einen neuen Kontakt zu erstellen, klicken Sie zunächst auf die Schaltfläche "Neu".

Danach wählen Sie im Formular einen oder mehrere Container aus in dem der Kontakt verfügbar sein soll und vergeben einen
Namen sowie entweder eine E-Mail-Adresse oder eine Telefonnummer.

Anschließend wählen Sie die Benachrichtigungsmethode für den Host aus. Dazu wählen Sie die Zeitspanne und mindestens ein
Kommando aus.

Damit die Benachrichtigungen für den Kontakt auch versendet werden, muss die Option "Hostbenachrichtigung aktiviert"
aktiv sein.

mit den "Optionen zu Hostbenachrichtigungen" können Sie noch auswählen, wann eine Benachrichtigung erfolgen soll.

Die Konfiguration zur Servicebenachrichtigung erfolgt nach demselben Schema.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | Container in dem der Kontakt erstellt werden soll |
| Name | :fontawesome-solid-xmark: | Name des Kontakts |
| Beschreibung |  | Das Intervall in dem die gewählten Karten rotieren sollen |
| E-Mail | :fontawesome-solid-xmark: | E-Mail Adresse des Kontakts. Entweder E-Mail Adresse, Telefonnummer oder beides muss gegeben sein |
| Telefon | :fontawesome-solid-xmark: | Telefonnummer des Kontakts. Entweder E-Mail Adresse, Telefonnummer oder beides muss gegeben sein |
| Benutzer | | Benutzer des Kontakts.  Für Browser-Benachrichtigungen muss dem Kontakt ein Benutzer zugewiesen werden. Die Benutzer-ID ist automatisch als Kontaktmakro $_CONTACTOITCUSERID$ verfügbar.  |
| Host-Benachrichtigung |
| Hostzeitspanne | :fontawesome-solid-xmark: | [Zeitraum](../../configuration/timeperiods/) in dem Benachrichtigt werden soll |
| Hostkommando | :fontawesome-solid-xmark: | Kommando, welches zum benachrichtigen verwendet werden soll |
| Hostbenachrichtigung aktiviert |  | Aktiviert die Benachrichtigungen für Hosts mit diesem Kontakt |
| Push-Benachrichtigungen an den Browser |  | Aktiviert die Push-Benachrichtigungen über den Browser |
| Servicebenachrichtigungen |  |  |
| Servicezeitspanne | :fontawesome-solid-xmark: | [Zeitraum](../../configuration/timeperiods/) in dem Benachrichtigt werden soll |
| Servicekommando | :fontawesome-solid-xmark: | Kommando, welches zum benachrichtigen verwendet werden soll |
| Servicebenachrichtigung aktiviert |  | Aktiviert die Benachrichtigungen für Services mit diesem Kontakt |
| Push-Benachrichtigungen an den Browser |  | Aktiviert die Push-Benachrichtigungen über den Browser |


## Kontaktgruppen

Kontaktgruppen sind Sammlungen von Kontakten. Sie dienen zur Vereinfachung der massenhaften Zuweisung von Kontakten an
verschiedenste Objekte. Kontaktgruppen können meist anstatt einzelner Kontakte wie zum Beispiel beim Erstellen von Host,
Services, Eskalationen, Abhängigkeiten oder Vorlagen ausgewählt werden.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | Container in dem die Kontaktgruppe erstellt werden soll |
| Name | :fontawesome-solid-xmark: | Name der Kontaktgruppe |
| Beschreibung |  | Beschreibung der Kontaktgruppe |
| Kontakte | :fontawesome-solid-xmark: | Kontakte, die zu dieser Kontaktgruppe hinzugefügt werden sollen |

### Ist meine Kontaktgruppe in Verwendung?

mit der Funktion "Verwendet von" (Used By) ist es möglich eine Übersicht über die Verwendung der jeweiligen
Kontaktgruppe zu bekommen.
![contactgroup used by list item](/images/contactgroups-usedbylistitem.png)

## Eskalationen

Benachrichtigungseskalationen können verwendet werden, um eine oder mehrere Benutzergruppen im Notfall zu
benachrichtigen. Wenn ein Host oder Dienst eskaliert, werden Kontakte, Kontaktgruppen und Benachrichtigungsoptionen
durch die Eskalation überschrieben. Sie funktionieren für Hosts gleichermaßen wie für Services.

### Wann werden Benachrichtigungen eskaliert?

Benachrichtigungen werden nur dann eskaliert, wenn mindestens eine Eskalationsdefinition mit der betreffenden
Benachrichtigung übereinstimmt. In einer Eskalation wird ein "Bereich" definiert, ab wann Benachrichtigungen eskaliert
werden sollen. Dieser Bereich wird bestimmt durch die Erste Benachrichtigung (Ab der wievielten Benachrichtigung greift
die Eskalation) und die letzte Benachrichtigung (Ab der wievielten Benachrichtigung greift wieder die Standardmäßig
definierten Benachrichtigungsoptionen des Objekts)
ist ein Eskalationszeitraum definiert, so greift die Eskalationsdefinition nur innerhalb des
angegebenem [Zeitabschnittes](../../configuration/timeperiods/). Über die Eskalationsoptionen kann ausgewählt werden für
welche Zustände eine Eskalation angestoßen werden soll. Dies sind für Hosts die Zustände:

- Wiederherstellung (Recovery)
- Nicht verfügbar (Down)
- Nicht erreichbar (Unreachable)

und für Services:

- Wiederherstellung (Recovery)
- Warnung (Warning)
- Kritisch (Critical)
- Unbekannt (Unknown)

Die Felder Kontakte und Kontaktgruppen definieren die Kontakte, die im Eskalationsfall Benachrichtigt werden.

### Hosteskalation erstellen

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | Container in dem die Eskalation erstellt werden soll |
| Hosts | :fontawesome-solid-xmark: | Hosts die eskaliert werden sollen |
| Ausgeschlossene Hosts |  | Hosts die nicht eskaliert werden sollen |
| Hostgruppen | | Hostgruppen die eskaliert werden sollen |
| Ausgeschlossene Hostgruppen | | Hostgruppen die nicht eskaliert werden sollen |
| Erste Benachrichtigung | :fontawesome-solid-xmark: |  Die Anzahl der Benachrichtigungen, die vor der Eskalationsregel übergeben wurden, überschreibt die Benachrichtigungseinstellungen.  |
| Letzte Benachrichtigung | :fontawesome-solid-xmark: |  Wenn die Anzahl der letzten Benachrichtigungen erreicht ist, wird die Benachrichtigungsregel deaktiviert und die Benachrichtigungsoptionen des Hosts oder Services werden erneut verwendet.  |
| Benachrichtigungsintervall | :fontawesome-solid-xmark: | In welchem Abstand erfolgen die Eskalationsbenachrichtigungen |
| Eskalationszeitraum |  | [Zeitabschnitte](../../configuration/timeperiods/) in dem die Eskalationsbenachrichtigungen versendet werden  |
| Kontakte | :fontawesome-solid-xmark: | Eskalationskontakt. Es muss entweder mindestens ein Kontakt oder eine Kontaktgruppe ausgewählt werden |
| Kontaktgruppen | :fontawesome-solid-xmark: | Eskalationskontaktgruppe. Es muss entweder mindestens ein Kontakt oder eine Kontaktgruppe ausgewählt werden |
| Eskalationsoptionen |  | Für welche Zustände wird die Eskalation aktiviert |

### Serviceeskalation erstellen

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | Container in dem die Eskalation erstellt werden soll |
| Services | :fontawesome-solid-xmark: | Services, die eskaliert werden sollen |
| Ausgeschlossene Services |  | Services, die nicht eskaliert werden sollen |
| Servicegruppen | | Servicegruppen, die eskaliert werden sollen |
| Ausgeschlossene Servicegruppen | | Servicegruppen, die nicht eskaliert werden sollen |
| Erste Benachrichtigung | :fontawesome-solid-xmark: |  Die Anzahl der Benachrichtigungen, die vor der Eskalationsregel übergeben wurden, überschreibt die Benachrichtigungseinstellungen.  |
| Letzte Benachrichtigung | :fontawesome-solid-xmark: |  Wenn die Anzahl der letzten Benachrichtigungen erreicht ist, wird die Benachrichtigungsregel deaktiviert und die Benachrichtigungsoptionen des Hosts oder Services werden erneut verwendet.  |
| Benachrichtigungsintervall | :fontawesome-solid-xmark: | In welchem Abstand erfolgen die Eskalationsbenachrichtigungen |
| Eskalationszeitraum |  | [Zeitabschnitte](../../configuration/timeperiods/), in dem die Eskalationsbenachrichtigungen versendet werden  |
| Kontakte | :fontawesome-solid-xmark: | Eskalationskontakt. Es muss entweder mindestens ein Kontakt oder eine Kontaktgruppe ausgewählt werden |
| Kontaktgruppen | :fontawesome-solid-xmark: | Eskalationskontaktgruppe. Es muss entweder mindestens ein Kontakt oder eine Kontaktgruppe ausgewählt werden |
| Eskalationsoptionen |  | Für welche Zustände wird die Eskalation aktiviert |

## Host / Service Abhängigkeiten

Abhängigkeiten sind eine Möglichkeit Benachrichtigungen und Überprüfungsausführungen für bestimmte Objekte anhand von
Statusinformationen abhängiger Objekte zu unterdrücken. In openITCOCKPIT ist es möglich Abhängigkeiten für Hosts und
Hostgruppen sowie Services und Servicegruppen zu definieren.

Dies funktioniert folgendermaßen:
Bevor Naemon einen Servicecheck ausführt oder eine Benachrichtigung sendet, wird der Host oder der Service nach
Abhängigkeiten überprüft. Ist keine Abhängigkeit definiert, so wird der Check ausgeführt und die Benachrichtigung ganz
normal versendet. Ist eine Abhängigkeit definiert, wird jede Abhängigkeit wie folgt überprüft:

1. Der Status des abhängigen Hosts oder Services wird geholt.
2. Dieser Status wird abgeglichen mit den Ausführungs oder Benachrichtigungsfehlerkriterien (Je nachdem was zu diesem
   Zeitpunkt relevant ist)
3. Wenn dieser Status mit einem der ausgewählten Fehlerkriterien übereinstimmt, gilt die Abhängigkeit als fehlgeschlagen
   und Naemon wird die weitere Überprüfung der Abhängigkeiten abbrechen.
4. Wenn dieser Status nicht mit einer der ausgewählten Fehlerkriterien übereinstimmt, gilt die Abhängigkeit als
   bestanden und Naemon wird die nächste Abhängigkeit überprüfen

Diese Schleife wird so lange ausgeführt, bis entweder alle Abhängigen Host oder Services die Überprüfung bestanden haben
oder eine Abhängigkeit fehlschlägt.

!!! info 
   Solange nicht anders konfiguriert, wird Naemon den aktuellsten hard state der abhängigen Hosts oder Services
   für die überprüfung nutzen.

#### Ausführungsfehlerkriterien

Diese Art der Abhängigkeiten werden genutzt, um aktive Überprüfungen (active checks) zu temporär auszusetzen. Sollten
alle Abhängigkeitsüberprüfungen für einen Host oder Service erfolgreich sein, wird Host oder Services ganz normal
überprüft. Schlägt eine Abhängigkeitsüberprüfung fehl, so wird Naemon die Überprüfung (Host-/Servicecheck) für den 
(abhängigen) Host oder Service temporär überspringen. Wenn alle Abhängigkeiten die Überprüfung (zu einem späteren
Zeitpunkt) bestehen, wird die Ausführung der Überprüfung (Host-/Servicecheck) ganz normal fortgesetzt.

#### Benachrichtigungsfehlerkriterien

Wenn alle Abhängigkeitsüberprüfungen für einen Host oder Service erfolgreich sind, werden Benachrichtigungen ganz normal
versendet. Schlägt eine Abhängigkeitsüberprüfung fehl, werden die Benachrichtigungen für den (abhängigen) Host oder
Service temporär unterdrückt. Wenn alle Abhängigkeiten die Überprüfung (zu einem späteren Zeitpunkt) bestehen, wird das
Senden der Benachrichtigungen für den (abhängigen) Host oder Service ganz normal fortgesetzt.

#### Abhängigkeitsvererbung

Abhängigkeiten werden nicht automatisch vererbt. Dies bedeutet, wenn ein Host oder Service (A) eine Abhängigkeit (B)
besitzt und diese Abhängigkeit wiederum auch Abhängigkeiten (C) besitzt, so ist A standardmäßig nicht von C abhängig. Um
die Abhängigkeit zu aktivieren, muss die Option "Erbt Elternteil" (inherits parent) aktiviert werden

### Host Abhängigkeiten

Host Abhängigkeiten unterscheiden sich in ihrer Funktion nicht von Service Abhängigkeiten.

1. Ein Host kann Abhängigkeiten zu einem oder mehreren Hosts haben.
2. Host Abhängigkeiten werden Standardmäßig nicht vererbt (Über Option vererbbar).
3. Host Abhängigkeiten können zum Unterdrücken von Benachrichtigungen und Check Ausführungen genutzt werden.
4. Host Abhängigkeiten sind, wenn konfiguriert, nur innerhalb von [Zeitabschnitten](../../configuration/timeperiods/)
   gültig.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | Container, in dem die Hostabhängigkeit erstellt werden soll |
| Hosts | :fontawesome-solid-xmark: | Hosts, von denen eine Abhängigkeit erstellt werden soll |
| Abhängige Hosts | :fontawesome-solid-xmark: | Hosts, die eine Abhängigkeit zu den gewählten Hosts haben |
| Hostgruppen | | Hostgruppen, von denen eine Abhängigkeit erstellt werden soll |
| Abhängige Hostgruppen | | Hostgruppen, die eine Abhängigkeit zu den gewählten Hosts / Hostgruppen haben |
| Zeitraum |  | [Zeitraum](../../configuration/timeperiods/), in dem die Abhängigkeit gültig ist |
| Erbt Elternteil |  | [Vererbung der Abhängigkeit](#abhangigkeitsvererbung) |
| Ausführungsfehlerkriterien |  | Siehe [Ausführungsfehlerkriterien](#ausfuhrungsfehlerkriterien) |
| Kriterien für Benachrichtigungsfehler |  | Siehe [Benachrichtigungsfehlerkriterien](#benachrichtigungsfehlerkriterien) |

### Service Abhängigkeiten

Service Abhängigkeiten unterscheiden sich in ihrer Funktion nicht von Host Abhängigkeiten.

1. Ein Service kann Abhängigkeiten zu einem oder mehreren Services haben.
2. Ein Service kann Abhängigkeiten zu Services haben, die nicht in verbindung mit demselben Host stehen.
3. Service Abhängigkeiten werden Standardmäßig nicht vererbt (über Option vererbbar).
4. Service Abhängigkeiten können zum Unterdrücken von Benachrichtigungen und Check Ausführungen genutzt werden.
5. Service Abhängigkeiten sind, wenn konfiguriert, nur innerhalb von [Zeitabschnitten](../../configuration/timeperiods/)
   gültig.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container | :fontawesome-solid-xmark: | Container, in dem die Serviceabhängigkeit erstellt werden soll |
| Services | :fontawesome-solid-xmark: | Services, von denen eine Abhängigkeit erstellt werden soll |
| Abhängige Services | :fontawesome-solid-xmark: | Services, eine Abhängigkeit zu den gewählten Services haben |
| Servicegruppen | | Servicegruppen, von denen eine Abhängigkeit erstellt werden soll |
| Abhängige Servicegruppen | | Servicegruppen, die eine Abhängigkeit zu den gewählten Services / Servicegruppen haben |
| Zeitraum |  | [Zeitraum](../../configuration/timeperiods/), in dem die Abhängigkeit gültig ist |
| Erbt Elternteil |  | [Vererbung der Abhängigkeit](#abhangigkeitsvererbung) |
| Ausführungsfehlerkriterien |  | Siehe [Ausführungsfehlerkriterien](#ausfuhrungsfehlerkriterien) |
| Kriterien für Benachrichtigungsfehler |  | Siehe [Benachrichtigungsfehlerkriterien](#benachrichtigungsfehlerkriterien) |

