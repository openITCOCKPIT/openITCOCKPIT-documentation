# Kommandos

Die Kommandos sind ein essenzieller Bestandteil von openITCOCKPIT. Diese definieren, wie und mit welchen Parametern ein
Kommando skript aufgerufen werden soll.

In openITCOCKPIT haben Sie die möglichkeit Service, Host, Benachrichtigungs und Ereignisbehandler (Eventhandler)
kommandos zu definieren.

## Kommando erstellen

Navigieren Sie nach `Monitoring -> Objekte -> Kommandos` und klicken Sie auf die Schaltfläche `+ Neu`.

Wählen Sie Ihren Kommandotyp aus

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Kommandotyp | :fontawesome-solid-xmark: | Kommando typ: [Service](#service-prufkommando), [Host](#host-prufkommando), [Benachrichtigung](#benachrichtigungskommando) oder [Ereignisbehandler](#ereignisbehandlerkommando-event-handler) Kommando |
| Name | :fontawesome-solid-xmark: | Name des Kommandos |
| Kommandozeile | :fontawesome-solid-xmark: | Kommandozeilenbefehl mit [Makros](#standardmakros-und-benutzerdefinierte-makros) und Argumenten |
| Beschreibung |  | Beschreibung des Kommandos |
| Argumente |  | Zu übergebende Parameter an das Prüf Skript. Siehe [Argumente](#argumente) |

![edit ping command](/images/commands-edit-ping.png)

### Service Prüfkommando

Ein Service Prüfkommando ist ein Kommando, welches von der Monitoring engine ausgeführt wird. Diese art Kommandos werden
i.d.R auf dem openITCOCKPIT Server unter dem pfad `/opt/openitc/nagios/libexec` abgelegt.

Über Argumente ($ARG1$ - $ARG32$) können beispielsweise Schwellwerte vom Service an das Kommando übergeben werden. Im
Kommando selbst wird nur der Name für ein Argument vergeben. Den Wert erhält es durch einen Service.

### Host Prüfkommando

Host Prüfkommandos arbeiten gleich den Service Prüfkommandos. Der einzige Unterschied hier besteht darin, dass das
Kommando über den Kommandotyp für Hosts verfügbar gemacht wird.

### Benachrichtigungskommando

Benachrichtigungskommandos sind Kommandos, die von den Kontakten in openITCOCKPIT verwendet werden. Die
Benachrichtigungskommandos sind in openITCOCKPIT in der Regel php Skripte welche entweder im Kern oder in
installierbaren Modulen enthalten sind.

### Ereignisbehandlerkommando (Event Handler)

Event Handler Kommandos definieren optionale System Kommandos (Skripte oder ausführbare Dateien) welche immer dann laufen,
wenn ein Host oder ein Service seinen Status ändert.

Eine Nutzungsmöglichkeit besteht darin, Nagios Proaktiv Probleme lösen zu lassen, bevor jemand benachrichtigt wird.

Beispiele:

- Neustarten eines fehlgeschlagenen Dienstes
- Ein "Trouble Ticket" in einem Ticketsystem eröffnen
- Event informationen in die Datenbank zu loggen
- etc.

#### Wann werden Event Handler ausgeführt? 

Event Handler werden ausgeführt, wenn ein Host oder Service:

- in einem SOFT Problemstatus ist
- geht zunächst ein einen HARD Problemstatus
- Erholt sich anfänglich von einem SOFT- oder HARD-Problemstatus

Weitere Informationen zu Event Handler finden Sie in der [Offiziellen Naemon Dokumentation](https://www.naemon.io/documentation/usersguide/eventhandlers.html).

### Standardmakros und Benutzerdefinierte Makros

Eine Übersicht über alle verfügbaren [Standardmakros](../macros/#standard-makros), die z.B. in der Kommandozeile
verwendet werden können finden sich beim Neu erstellen oder editieren eines Kommandos in der oberen leiste. Ebenfalls
dort ist unter "$USERn$" auch eine Übersicht der [Benutzerdefinierten Makros](../macros/) zu finden.

![default macros](/images/UserDefinedMacros-DefaultMacroOverview.png)

### Kommandozeile

In der Kommandozeile steckt die eigentliche "Magie" der Kommandos. Hier wird der Aufruf des Prüf Skriptes definiert. Ein
Prüf Skript (check script) kann Übergabeparameter wie zum Beispiel Hostadresse, Schwellwerte oder
Konfigurationsparameter erwarten. Diese werden dann über Variablen, sogenannte [Argumente](#argumente)
und [Makros](#standardmakros-und-benutzerdefinierte-makros) übergeben. Argumente werden in den optionalen
Argumente-Feldern (am unteren Ende des "Kommando erstellen" / "Kommando bearbeiten" Formulars) definiert und können dann als Variable
innerhalb des Kommandozeilenbefehls eingefügt werden.

![macros and args](/images/commands-commandline-macros-args.png)

### Argumente

Argumente werden als Übergabeparameter vom Kommando an das Prüf Skript weitergegeben. In einem Kommando selbst wird kein
fester Wert für ein Argument, sondern lediglich der Name eines Argumentes definiert. Die Werte (hier anhand von
Schwellwerten eines Service Prüfkommandos) werden anschließend in der Servicevorlage nach dem Auswählen des
entsprechenden Prüfkommandos übergeben. So kann ein Kommando von mehreren Vorlagen mit unterschiedlichen Schwellwerten
genutzt werden.

Argumente in der Kommando-Konfiguration:

![command args](/images/commandargs.png)

Argumente in der Servicevorlagen Konfiguration:

![servicetemplate command args](/images/servicetemplate-commandargs.png)