# WebSocket Event Stream

openITCOCKPIT stellt einen WebSocket Event Stream (WebSocket-Ereignisstream) bereit, der Echtzeitzugriff auf Ereignisse und Benachrichtigungen des Monitoringsystems ermöglicht.


!!! info
    Erfordert openITCOCKPIT ≥ 5.8.0


## Verwendung und Konfiguration

Der WebSocket-Endpunkt ist unter `ws://<host>:<port>/ws` verfügbar und wird vom Statusengine Worker bereitgestellt. Standardmäßig lauscht der Worker auf `127.0.0.1:8091`; der lokale Endpunkt lautet daher `ws://127.0.0.1:8091/ws`. Verwenden Sie `wss://`, wenn TLS von einem Reverse Proxy terminiert wird.

Eine Authentifizierung ist immer erforderlich. Übermitteln Sie einen API-Schlüssel mit einer der folgenden Methoden:

| Methode                    | Beispiel                              | Verwendungszweck                                                                        |
|----------------------------|---------------------------------------|-----------------------------------------------------------------------------------------|
| `Authorization`-Header     | `Authorization: Bearer <api-key>`     | Empfohlen für Clients, die HTTP-Header setzen können.                                   |
| `X-Api-Key`-Header         | `X-Api-Key: <api-key>`                | Alternative für Clients, die HTTP-Header setzen können.                                 |
| Abfrageparameter `api_key` | `ws://host:8091/ws?api_key=<api-key>` | Nur für Browser-Clients, da die Browser-WebSocket-API keine eigenen Header setzen kann. |


Ein ungültiger oder fehlender API-Schlüssel führt dazu, dass der Worker die Verbindung mit HTTP `401` ablehnt, bevor der WebSocket-Handshake abgeschlossen ist.

Topics können beim Verbindungsaufbau über den optionalen, kommagetrennten Abfrageparameter `topics` ausgewählt werden:

```text
ws://127.0.0.1:8091/ws?api_key=<api-key>&topics=statusngin_hoststatus,statusngin_servicestatus
```

Wenn keine Topics angegeben werden, erhält der Client Ereignisse für **alle Topics**.

### API-Schlüssel erstellen und Listen-Adresse ändern

Standardmäßig lauscht der WebSocket-Server auf `127.0.0.1:8091` und ist nur lokal erreichbar. Für einen sicheren Remotezugriff wird ein Reverse Proxy empfohlen. Statusengine erzeugt beim Start selbstständig einen zufälligen API-Schlüssel, sodass der Endpunkt `/ws` nie ungeschützt ist.

Um einen statischen API-Schlüssel zu erhalten, öffnen Sie die openITCOCKPIT-Weboberfläche, navigieren Sie zu **System** → **Konfigurationsdatei-Editor** und bearbeiten Sie die Datei `/opt/openitc/etc/statusengine/worker-config.yml`.

Scrollen Sie zu `api_keys` und klicken Sie auf "Add new API key". openITCOCKPIT erzeugt automatisch einen sicheren API-Schlüssel. Sie können bis zu 25 API-Schlüssel definieren.
Um die Listen-Adresse zu ändern, bearbeiten Sie das Feld `listen_addr`. Setzen Sie den Wert auf `:8091`, damit der Server auf allen Netzwerkschnittstellen auf Port 8091 lauscht. (Nicht empfohlen)

![API-Schlüssel erstellen](/images/event_stream/statusengine_create_api_key.png)

## WebSocket-Frames

Eine Server-zu-Client-Nachricht besteht aus einem WebSocket-Frame pro Queue-Job. Sie enthält den Queue-Namen in `topic` und die Ereignisse dieses Jobs in `payload`:

```json
{
    "topic": "statusngin_hoststatus",
    "payload": [
        {"name": "localhost"},
        {"name": "db01"}
    ]
}
```

`payload` ist **immer ein Array** von Ereignissen.

### Zustellung und Wiederverbindungen

Der Event Stream ist keine persistente Message Queue. Ereignisse, die gesendet werden, während ein Client getrennt ist, sowie Frames, die aufgrund eines vollen Puffers verworfen werden, werden nicht erneut übertragen. Clients müssen geschlossene Verbindungen erkennen, sich selbst neu verbinden und ihre erforderlichen Topic-Abonnements nach der Wiederverbindung wiederherstellen.

### Langsame Clients

Jeder Client verfügt über einen eigenen **Puffer für 256 Frames**. Kann ein Client eingehende Nachrichten nicht schnell genug verarbeiten und der Puffer läuft über, **verwirft der Server neue Ereignisse für diesen Client**, bis er wieder aufgeholt hat. Dieser Mechanismus verhindert, dass langsame Clients die Ereigniszustellung an andere Clients beeinträchtigen.

Die Prometheus-Metrik `statusengine_websocket_messages_dropped_total` wird dabei erhöht.

## Steuerung der Abonnements

Zur Laufzeit können Clients ihr Abonnement durch Senden von JSON-Steuerframes ändern. `subscribe` fügt Topics hinzu, `unsubscribe` entfernt Topics aus dem aktuellen Abonnement. Beide Eigenschaften sind optional und können in einem Frame kombiniert werden.

```json
{"subscribe": ["statusngin_hoststatus", "statusngin_servicestatus"]}
```

```json
{"unsubscribe": ["statusngin_servicestatus"]}
```

```json
{
    "subscribe": ["statusngin_notifications"],
    "unsubscribe": ["statusngin_hoststatus"]
}
```

Der Web-Beispielclient zeigt, wie eine Verbindung zum WebSocket-Server hergestellt und Abonnements dynamisch geändert werden können.

## WebSocket-Beispielclients

### Web-Client

Der [Web-Beispielclient](https://github.com/statusengine/statusengine-worker/blob/main/web/ws-test-client.html) kann von GitHub heruntergeladen und als `ws-test-client.html` gespeichert werden. Ziehen Sie die Datei in einen Webbrowser, um den Beispielclient auszuführen.

![Web-Client-Beispiel](/images/event_stream/statusengine_example_web_client.png)

### Python-Client

Der [Python-Beispielclient](https://github.com/statusengine/statusengine-worker/blob/main/web/ws_client.py) kann von GitHub heruntergeladen und als `ws_client.py` gespeichert werden. Starten Sie ihn mit `python ws_client.py`. Der Python-Client benötigt die Bibliothek `websockets`, die mit `pip install websockets` installiert werden kann.

Mit `--help` werden alle verfügbaren Kommandozeilenoptionen des Python-Clients angezeigt.

![Python-Client-Beispiel](/images/event_stream/statusengine_example_python_client.png)

### cURL-Client

Dies ist ein einfaches Beispiel mit `curl` (Version 8.11.0 oder neuer).

```bash
curl --no-progress-meter --no-buffer -T . -N \
     -H "Authorization: Bearer <api-key>" \
     ws://127.0.0.1:8091/ws
```

- `-N` / `--no-buffer`: Deaktiviert die Ausgabepufferung, damit eingehende Nachrichten sofort sichtbar sind.
- `-T .`: Weist curl an, kontinuierlich Daten von `stdin` hochzuladen, sodass Nachrichten im Terminal eingegeben werden können.

Standardmäßig abonniert dieses curl-Beispiel alle Topics. Um das Abonnement zu ändern, fügen Sie `{"subscribe": ["statusngin_servicechecks"]}` ein und drücken Sie `Return`. Mit `{"unsubscribe": ["statusngin_servicechecks"]}` können Sie den Empfang von Ereignissen eines bestimmten Topics beenden.


## Event Stream Topics

Jeder Server-zu-Client-Frame enthält ein `topic` und ein `payload`. Das Payload ist immer ein Array; jeder Array-Eintrag entspricht dem unten für sein Topic aufgeführten Modell. Alle Zeitfelder mit dem Format `int64` enthalten Unix-Zeitstempel. Felder mit dem Suffix `_usec` enthalten die Mikrosekundenkomponente des zugehörigen Zeitfelds.

### `statusngin_hoststatus`

Modell: `HostStatusEvent`. Aktueller Status eines Hosts.

| Feld                            | Typ              | Beschreibung                                 |
|---------------------------------|------------------|----------------------------------------------|
| `timestamp`                     | integer (int64)  | Zeitpunkt, zu dem der Status gemeldet wurde. |
| `name`                          | string           | Hostname.                                    |
| `plugin_output`                 | string           | Plugin-Ausgabe.                              |
| `long_plugin_output`            | string           | Lange Plugin-Ausgabe.                        |
| `event_handler`                 | string oder null | Konfigurierter Event-Handler-Befehl.         |
| `perf_data`                     | string           | Rohe Nagios/Naemon-Performancedaten.         |
| `check_command`                 | string           | Check-Befehl.                                |
| `check_period`                  | string           | Check-Zeitperiode.                           |
| `current_state`                 | integer          | `0` = UP, `1` = DOWN, `2` = UNREACHABLE.     |
| `has_been_checked`              | integer          | `0` or `1`.                                  |
| `should_be_scheduled`           | integer          | `0` or `1`.                                  |
| `current_attempt`               | integer          | Aktueller Check-Versuch.                     |
| `max_attempts`                  | integer          | Maximale Anzahl an Check-Versuchen.          |
| `last_check`                    | integer (int64)  | Zeitpunkt des letzten Checks.                |
| `next_check`                    | integer (int64)  | Zeitpunkt des nächsten Checks.               |
| `check_type`                    | integer          | `0` = aktiv, `1` = passiv.                   |
| `last_state_change`             | integer (int64)  | Zeitpunkt des letzten Statuswechsels.        |
| `last_hard_state_change`        | integer (int64)  | Zeitpunkt des letzten HARD-Statuswechsels.   |
| `last_hard_state`               | integer          | Gleiche Kodierung wie `current_state`.       |
| `last_time_up`                  | integer (int64)  | Zeitpunkt des letzten UP-Status.             |
| `last_time_down`                | integer (int64)  | Zeitpunkt des letzten DOWN-Status.           |
| `last_time_unreachable`         | integer (int64)  | Zeitpunkt des letzten UNREACHABLE-Status.    |
| `state_type`                    | integer          | `0` = SOFT, `1` = HARD.                      |
| `last_notification`             | integer (int64)  | Zeitpunkt der letzten Benachrichtigung.      |
| `next_notification`             | integer (int64)  | Zeitpunkt der nächsten Benachrichtigung.     |
| `no_more_notifications`         | integer          | `0` or `1`.                                  |
| `notifications_enabled`         | integer          | `0` or `1`.                                  |
| `problem_has_been_acknowledged` | integer          | `0` or `1`.                                  |
| `acknowledgement_type`          | integer          | Bestätigungstyp.                             |
| `current_notification_number`   | integer          | Aktuelle Benachrichtigungsnummer.            |
| `accept_passive_checks`         | integer          | `0` or `1`.                                  |
| `event_handler_enabled`         | integer          | `0` or `1`.                                  |
| `checks_enabled`                | integer          | `0` or `1`.                                  |
| `flap_detection_enabled`        | integer          | `0` or `1`.                                  |
| `is_flapping`                   | integer          | `0` or `1`.                                  |
| `percent_state_change`          | float64          | Prozentuale Statusänderung.                  |
| `latency`                       | float64          | Check-Latenz.                                |
| `execution_time`                | float64          | Check-Ausführungszeit.                       |
| `scheduled_downtime_depth`      | integer          | Anzahl aktiver, überlappender Downtimes.     |
| `process_performance_data`      | integer          | `0` or `1`.                                  |
| `obsess`                        | integer          | `0` or `1`.                                  |
| `modified_attributes`           | integer          | Bitmaske geänderter Attribute.               |
| `check_interval`                | float64          | Normales Check-Intervall.                    |
| `retry_interval`                | float64          | Wiederholungsintervall.                      |


### `statusngin_servicestatus`

Modell: `ServiceStatusEvent`. Aktueller Status eines Services.

| Feld                            | Typ              | Beschreibung                                            |
|---------------------------------|------------------|---------------------------------------------------------|
| `timestamp`                     | integer (int64)  | Zeitpunkt, zu dem der Status gemeldet wurde.            |
| `host_name`                     | string           | Host-UUID.                                              |
| `description`                   | string           | Service-UUID.                                           |
| `plugin_output`                 | string           | Plugin-Ausgabe.                                         |
| `long_plugin_output`            | string           | Lange Plugin-Ausgabe.                                   |
| `event_handler`                 | string oder null | Konfigurierter Event-Handler-Befehl.                    |
| `perf_data`                     | string           | Rohe Performancedaten.                                  |
| `check_command`                 | string           | Check-Befehl.                                           |
| `check_period`                  | string           | Check-Zeitperiode.                                      |
| `current_state`                 | integer          | `0` = OK, `1` = WARNING, `2` = CRITICAL, `3` = UNKNOWN. |
| `has_been_checked`              | integer          | Ob der Service geprüft wurde.                           |
| `should_be_scheduled`           | integer          | Ob Checks geplant werden sollen.                        |
| `current_attempt`               | integer          | Aktueller Check-Versuch.                                |
| `max_attempts`                  | integer          | Maximale Anzahl an Check-Versuchen.                     |
| `last_check`                    | integer (int64)  | Zeitpunkt des letzten Checks.                           |
| `next_check`                    | integer (int64)  | Zeitpunkt des nächsten Checks.                          |
| `check_type`                    | integer          | `0` = aktiv, `1` = passiv.                              |
| `last_state_change`             | integer (int64)  | Zeitpunkt des letzten Statuswechsels.                   |
| `last_hard_state_change`        | integer (int64)  | Zeitpunkt des letzten HARD-Statuswechsels.              |
| `last_hard_state`               | integer          | Letzter HARD-Status.                                    |
| `last_time_ok`                  | integer (int64)  | Zeitpunkt des letzten OK-Status.                        |
| `last_time_warning`             | integer (int64)  | Zeitpunkt des letzten WARNING-Status.                   |
| `last_time_critical`            | integer (int64)  | Zeitpunkt des letzten CRITICAL-Status.                  |
| `last_time_unknown`             | integer (int64)  | Zeitpunkt des letzten UNKNOWN-Status.                   |
| `state_type`                    | integer          | `0` = SOFT, `1` = HARD.                                 |
| `last_notification`             | integer (int64)  | Zeitpunkt der letzten Benachrichtigung.                 |
| `next_notification`             | integer (int64)  | Zeitpunkt der nächsten Benachrichtigung.                |
| `no_more_notifications`         | integer          | Ob weitere Benachrichtigungen deaktiviert sind.         |
| `notifications_enabled`         | integer          | Ob Benachrichtigungen aktiviert sind.                   |
| `problem_has_been_acknowledged` | integer          | Ob das Problem bestätigt wurde.                         |
| `acknowledgement_type`          | integer          | Bestätigungstyp.                                        |
| `current_notification_number`   | integer          | Aktuelle Benachrichtigungsnummer.                       |
| `accept_passive_checks`         | integer          | Ob passive Checks akzeptiert werden.                    |
| `event_handler_enabled`         | integer          | Ob der Event-Handler aktiviert ist.                     |
| `checks_enabled`                | integer          | Ob Checks aktiviert sind.                               |
| `flap_detection_enabled`        | integer          | Ob die Flap-Erkennung aktiviert ist.                    |
| `is_flapping`                   | integer          | Ob der Service flapping ist.                            |
| `percent_state_change`          | float64          | Prozentuale Statusänderung.                             |
| `latency`                       | float64          | Check-Latenz.                                           |
| `execution_time`                | float64          | Check-Ausführungszeit.                                  |
| `scheduled_downtime_depth`      | integer          | Anzahl aktiver, überlappender Downtimes.                |
| `process_performance_data`      | integer          | Ob Performancedaten verarbeitet werden.                 |
| `obsess`                        | integer          | Ob obsessives Processing aktiviert ist.                 |
| `modified_attributes`           | integer          | Bitmaske geänderter Attribute.                          |
| `check_interval`                | float64          | Normales Check-Intervall.                               |
| `retry_interval`                | float64          | Wiederholungsintervall.                                 |


### `statusngin_hostchecks`

Modell: `HostCheckEvent`. Ergebnis eines abgeschlossenen Host-Checks.

| Feld              | Typ             | Beschreibung                             |
|-------------------|-----------------|------------------------------------------|
| `timestamp_usec`  | integer         | Mikrosekunden neben `start_time`.        |
| `host_name`       | string          | Host-UUID.                               |
| `command_line`    | string          | Ausgeführte Befehlszeile.                |
| `command_name`    | string          | Name des Check-Befehls.                  |
| `output`          | string          | Plugin-Ausgabe.                          |
| `long_output`     | string          | Lange Plugin-Ausgabe.                    |
| `perf_data`       | string          | Rohe Performancedaten.                   |
| `check_type`      | integer         | `0` = aktiv, `1` = passiv.               |
| `current_attempt` | integer         | Aktueller Check-Versuch.                 |
| `max_attempts`    | integer         | Maximale Anzahl an Check-Versuchen.      |
| `state_type`      | integer         | `0` = SOFT, `1` = HARD.                  |
| `state`           | integer         | `0` = UP, `1` = DOWN, `2` = UNREACHABLE. |
| `timeout`         | integer         | Konfigurierter Timeout.                  |
| `start_time`      | integer (int64) | Startzeit des Checks.                    |
| `end_time`        | integer (int64) | Endzeit des Checks.                      |
| `early_timeout`   | integer         | `0` oder `1`.                            |
| `execution_time`  | float64         | Ausführungszeit des Checks.              |
| `latency`         | float64         | Latenz des Checks.                       |
| `return_code`     | integer         | Plugin-Rückgabecode.                     |


### `statusngin_servicechecks`

Modell: `ServiceCheckEvent`. Ergebnis eines abgeschlossenen Service-Checks.

| Feld                  | Typ             | Beschreibung                                            |
|-----------------------|-----------------|---------------------------------------------------------|
| `timestamp_usec`      | integer         | Mikrosekunden neben `start_time`.                       |
| `host_name`           | string          | Host-UUID.                                              |
| `service_description` | string          | Service-UUID.                                           |
| `command_line`        | string          | Ausgeführte Befehlszeile.                               |
| `command_name`        | string          | Name des Check-Befehls.                                 |
| `output`              | string          | Plugin-Ausgabe.                                         |
| `long_output`         | string          | Lange Plugin-Ausgabe.                                   |
| `perf_data`           | string          | Rohe Performancedaten.                                  |
| `check_type`          | integer         | `0` = aktiv, `1` = passiv.                              |
| `current_attempt`     | integer         | Aktueller Check-Versuch.                                |
| `max_attempts`        | integer         | Maximale Anzahl an Check-Versuchen.                     |
| `state_type`          | integer         | `0` = SOFT, `1` = HARD.                                 |
| `state`               | integer         | `0` = OK, `1` = WARNING, `2` = CRITICAL, `3` = UNKNOWN. |
| `timeout`             | integer         | Konfigurierter Timeout.                                 |
| `start_time`          | integer (int64) | Startzeit des Checks.                                   |
| `end_time`            | integer (int64) | Endzeit des Checks.                                     |
| `early_timeout`       | integer         | `0` oder `1`.                                           |
| `execution_time`      | float64         | Ausführungszeit des Checks.                             |
| `latency`             | float64         | Latenz des Checks.                                      |
| `return_code`         | integer         | Plugin-Rückgabecode.                                    |


### `statusngin_service_perfdata`

Modell: `ServicePerfdataEvent`. Performancedaten eines Services. Für dieses Topic werden nur die unten aufgeführten Felder befüllt.

| Feld                  | Typ             | Beschreibung                                            |
|-----------------------|-----------------|---------------------------------------------------------|
| `host_name`           | string          | Host-UUID.                                              |
| `service_description` | string          | Service-UUID.                                           |
| `perf_data`           | string          | Rohe, nicht analysierte Nagios/Naemon-Performancedaten. |
| `start_time`          | integer (int64) | Startzeit des Checks.                                   |


### `statusngin_statechanges`

Modell: `StateChangeEvent`. Ein Statushistorien-Ereignis eines Hosts oder Services.

| Feld                  | Typ             | Beschreibung                                                 |
|-----------------------|-----------------|--------------------------------------------------------------|
| `timestamp`           | integer (int64) | Zeitpunkt des Ereignisses.                                   |
| `timestamp_usec`      | integer         | Mikrosekundenkomponente des Ereigniszeitpunkts.              |
| `host_name`           | string          | Host-UUID.                                                   |
| `service_description` | string          | Service-UUID; bei einem Host-Ereignis leer.                  |
| `output`              | string          | Plugin-Ausgabe.                                              |
| `long_output`         | string          | Lange Plugin-Ausgabe.                                        |
| `statechange_type`    | integer         | `0` = host, `1` = service.                                   |
| `state`               | integer         | Aktueller Status; Kodierung hängt von `statechange_type` ab. |
| `state_type`          | integer         | `0` = SOFT, `1` = HARD.                                      |
| `current_attempt`     | integer         | Aktueller Check-Versuch.                                     |
| `max_attempts`        | integer         | Maximale Anzahl an Check-Versuchen.                          |
| `last_state`          | integer         | Vorheriger Status.                                           |
| `last_hard_state`     | integer         | Vorheriger HARD-Status.                                      |


### `statusngin_logentries`

Modell: `LogEntryEvent`. Ein roher Naemon/Nagios-Logeintrag.

| Feld         | Typ             | Beschreibung                                                                                                                                    |
|--------------|-----------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| `entry_time` | integer (int64) | Zeitpunkt des Logeintrags.                                                                                                                      |
| `data_type`  | integer         | Naemon/Nagios-[NSLOG_*](https://github.com/naemon/naemon-core/blob/6259292ba9b7780cb0cdc4631a56c0d2eb3eb3ad/src/naemon/logging.h#L13-L42)-Code. |
| `data`       | string          | Text der Logzeile.                                                                                                                              |



### `statusngin_notifications`

Modell: `NotificationEvent`. Eine abgeschlossene Benachrichtigung.

| Feld                  | Typ             | Beschreibung                                                              |
|-----------------------|-----------------|---------------------------------------------------------------------------|
| `type`                | integer         | Immer `601` (`NEBTYPE_NOTIFICATION_END`).                                 |
| `timestamp_usec`      | integer         | Mikrosekundenkomponente des Ereigniszeitpunkts.                           |
| `host_name`           | string          | Host-UUID.                                                                |
| `service_description` | string          | Service-UUID; bei einer Host-Benachrichtigung leer.                       |
| `output`              | string          | Plugin-Ausgabe.                                                           |
| `long_output`         | string          | Lange Plugin-Ausgabe.                                                     |
| `ack_author`          | string          | Gesetzter Wert, wenn eine Bestätigung die Benachrichtigung ausgelöst hat. |
| `ack_data`            | string          | Bestätigungskommentar.                                                    |
| `notification_type`   | integer         | Naemon/Nagios-Benachrichtigungstypcode.                                   |
| `start_time`          | integer (int64) | Startzeit der Benachrichtigung.                                           |
| `end_time`            | integer (int64) | Endzeit der Benachrichtigung.                                             |
| `reason_type`         | integer         | Naemon/Nagios-Grundcode für Benachrichtigungen.                           |
| `state`               | integer         | Benachrichtigter Status; Kodierung hängt von Host oder Service ab.        |
| `escalated`           | integer         | `0` oder `1`.                                                             |
| `contacts_notified`   | integer         | Anzahl der tatsächlich benachrichtigten Kontakte.                         |


### `statusngin_contactnotificationmethod`

Modell: `ContactNotificationMethodEvent`. Eine abgeschlossene Zustellung an einen Kontakt.

| Feld                  | Typ              | Beschreibung                                           |
|-----------------------|------------------|--------------------------------------------------------|
| `type`                | integer          | Immer `605` (`NEBTYPE_CONTACTNOTIFICATIONMETHOD_END`). |
| `timestamp`           | integer (int64)  | Zeitpunkt des Ereignisses.                             |
| `timestamp_usec`      | integer          | Mikrosekundenkomponente des Ereigniszeitpunkts.        |
| `host_name`           | string           | Host-UUID.                                             |
| `service_description` | string           | Service-UUID; bei einer Host-Benachrichtigung leer.    |
| `output`              | string           | Plugin-Ausgabe.                                        |
| `ack_author`          | string           | Autor der Bestätigung.                                 |
| `ack_data`            | string           | Bestätigungskommentar.                                 |
| `contact_name`        | string           | Kontakt, der die Benachrichtigung erhält.              |
| `command_name`        | string           | Verwendeter Benachrichtigungsbefehl.                   |
| `command_args`        | string oder null | Argumente des Benachrichtigungsbefehls.                |
| `reason_type`         | integer          | Naemon/Nagios-Grundcode für Benachrichtigungen.        |
| `state`               | integer          | Benachrichtigter Status.                               |
| `start_time`          | integer (int64)  | Startzeit der Zustellung.                              |
| `end_time`            | integer (int64)  | Endzeit der Zustellung.                                |


### `statusngin_acknowledgements`

Modell: `AcknowledgementEvent`. Eine Bestätigung auf einem Host oder Service.

| Feld                   | Typ             | Beschreibung                                                       |
|------------------------|-----------------|--------------------------------------------------------------------|
| `entry_time`           | integer (int64) | Zeitpunkt der Bestätigung.                                         |
| `entry_time_usec`      | integer         | Mikrosekundenkomponente von `entry_time`.                          |
| `host_name`            | string          | Host-UUID.                                                         |
| `service_description`  | string          | Service-UUID; bei einer Host-Bestätigung leer.                     |
| `state`                | integer         | Bestätigter Status.                                                |
| `author_name`          | string          | Autor der Bestätigung.                                             |
| `comment_data`         | string          | Bestätigungskommentar.                                             |
| `acknowledgement_type` | integer         | `1` = normal, `2` = dauerhaft.                                     |
| `is_sticky`            | integer         | `0` oder `1`.                                                      |
| `persistent_comment`   | integer         | `0` oder `1`.                                                      |
| `notify_contacts`      | integer         | `0` oder `1`; Kontakte wurden über die Bestätigung benachrichtigt. |


### `statusngin_downtimes`

Modell: `DowntimeEvent`. Umfasst den vollständigen Lebenszyklus einer Downtime.

| Feld             | Typ             | Beschreibung                                                                    |
|------------------|-----------------|---------------------------------------------------------------------------------|
| `type`           | integer         | `1100` = ADD, `1101` = DELETE, `1102` = LOAD, `1103` = START, `1104` = STOP.    |
| `flags`          | integer         | Broker-Flags.                                                                   |
| `attr`           | integer         | Nur für STOP: `1` = regulär abgelaufen, `2` = vorzeitig abgebrochen; sonst `0`. |
| `timestamp`      | integer (int64) | Zeitpunkt des Ereignisses.                                                      |
| `timestamp_usec` | integer         | Mikrosekundenkomponente des Ereigniszeitpunkts.                                 |
| `downtime`       | object          | Downtime-Details, siehe unten.                                                  |


`downtime` hat die folgenden Felder:

| Feld                  | Typ             | Beschreibung                                        |
|-----------------------|-----------------|-----------------------------------------------------|
| `host_name`           | string          | Host-UUID.                                          |
| `service_description` | string          | Service-UUID; bei einer Host-Downtime leer.         |
| `author_name`         | string          | Autor der Downtime.                                 |
| `comment_data`        | string          | Downtime-Kommentar.                                 |
| `downtime_type`       | integer         | `1` = service, `2` = host.                          |
| `entry_time`          | integer (int64) | Zeitpunkt, zu dem die Downtime geplant wurde.       |
| `start_time`          | integer (int64) | Geplante Startzeit.                                 |
| `end_time`            | integer (int64) | Geplante Endzeit.                                   |
| `triggered_by`        | integer         | ID der auslösenden Downtime oder `0`.               |
| `downtime_id`         | integer         | Downtime-ID.                                        |
| `fixed`               | integer         | `0` = flexibel, `1` = fest.                         |
| `duration`            | integer         | Dauer in Sekunden; relevant für flexible Downtimes. |


### `statusngin_core_restart`

Modell: `CoreRestartEvent`. Wird gesendet, wenn der Monitoring-Core seine Konfiguration neu startet oder neu lädt.

| Feld          | Typ             | Beschreibung                                                     |
|---------------|-----------------|------------------------------------------------------------------|
| `object_type` | integer         | Immer `102`.                                                     |
| `timestamp`   | integer (int64) | Neustartzeit; derzeit `0`, wenn der Core sie nicht bereitstellt. |

## Metriken

Der Statusengine Worker stellt Prometheus-Metriken für den WebSocket Event Stream bereit. Der Metrik-Endpunkt ist absichtlich nicht authentifiziert und sollte nur für vertrauenswürdige Monitoringsysteme erreichbar sein.

| Metrik                                              | Typ     | Beschreibung                                                                                                                                                   |
|-----------------------------------------------------|---------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `statusengine_websocket_clients_active`             | Gauge   | Anzahl der aktuell verbundenen WebSocket-Clients.                                                                                                             |
| `statusengine_websocket_messages_broadcasted_total` | Counter | Erfolgreich an Client-Sendepuffer übergebene Ereignisse. Zählt Ereignisse, nicht Frames.                                                                       |
| `statusengine_websocket_frames_sent_total`          | Counter | An Clients übergebene Frames. Ein Frame enthält einen Queue-Job und kann mehrere Ereignisse enthalten.                                                         |
| `statusengine_websocket_messages_dropped_total`     | Counter | Ereignisse, die wegen eines vollen Sendepuffers eines einzelnen Clients verworfen wurden. Ein Drop betrifft nur diesen Client, kann aber einen vollständigen Frame mit mehreren Ereignissen verwerfen. |
| `statusengine_websocket_publish_dropped_total`      | Counter | Ereignisse, die wegen eines vollen Eingabepuffers des Hubs verworfen wurden. Dies betrifft alle verbundenen Clients und sollte alarmiert werden.              |

## API für externe Befehle

Der Statusengine Worker stellt außerdem den **schreibenden** Endpunkt `POST /commands` bereit. Er veröffentlicht externe Naemon-Befehle in der Queue `statusngin_cmd`, wo sie vom Statusengine-Broker-Modul verarbeitet werden.

!!! danger
    Der Endpunkt `/commands` gewährt Schreibzugriff auf das Monitoringsystem.
    Stellen Sie sicher, dass nur vertrauenswürdige Clients Zugriff auf diesen Endpunkt haben.

Dieser Endpunkt ist vom WebSocket Event Stream getrennt. Er besitzt eine eigene Listen-Adresse und eigene API-Schlüssel.

### Konfiguration

Die Konfiguration erfolgt über den Konfigurationsdatei-Editor von openITCOCKPIT. Navigieren Sie zu **System** → **Konfigurationsdatei-Editor** und bearbeiten Sie die Datei `/opt/openitc/etc/statusengine/worker-config.yml`.

- `command_listen_addr`: Steuert die Listen-Adresse für den Endpunkt `POST /commands`.
- `command_api_keys`: Separate API-Schlüssel für die API für externe Befehle. (Es können maximal 25 Schlüssel konfiguriert werden.)

### Authentifizierung

Senden Sie einen Schlüssel aus `command_api_keys` in einem der folgenden HTTP-Header:

| Header          | Beispiel                                  |
|-----------------|-------------------------------------------|
| `Authorization` | `Authorization: Bearer <command-api-key>` |
| `X-Api-Key`     | `X-Api-Key: <command-api-key>`            |

Der Abfrageparameter `api_key` wird für diesen Endpunkt nicht unterstützt. Ein fehlender oder ungültiger Schlüssel führt zu HTTP `401`.

### Anfrageformat

Der Anfrage-Body enthält entweder einen einzelnen Befehl mit `Command` und `Data` oder ein Array `messages` für eine Bulk-Anfrage. Bei `Command` und `Data` wird Groß- und Kleinschreibung unterschieden. Kombinieren Sie `messages` nicht mit `Command` oder `Data` in derselben Anfrage. Eine Bulk-Anfrage kann bis zu 50 Befehle verschiedener Typen enthalten.

| `Command`         | `Data`                                                                                                                                                                                                                                                                                               |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `check_result`    | Objekt mit den Pflichtfeldern `host_name` und `output` sowie den optionalen Feldern `service_description`, `long_output`, `perf_data`, `check_type`, `return_code`, `start_time`, `end_time`, `early_timeout`, `latency` und `exited_ok`. Lassen Sie `service_description` für einen Host-Check weg. |
| `schedule_check`  | Objekt mit den Pflichtfeldern `host_name` und `schedule_time` (ungleich `0`) sowie dem optionalen Feld `service_description`. Lassen Sie `service_description` für einen Host-Check weg.                                                                                                             |
| `delete_downtime` | Objekt mit dem Pflichtfeld `host_name` sowie den optionalen Feldern `service_description`, `start_time`, `end_time` und `comment`.                                                                                                                                                                   |
| `raw`             | Zeichenkette mit einem externen Naemon-Befehl. Der Worker ergänzt das erforderliche Präfix `[<unix timestamp>]`, falls es fehlt.                                                                                                                                                                     |

#### Modell `check_result`

Übermittelt ein passives Ergebnis für einen Host oder Service. Lassen Sie `service_description` für ein Host-Ergebnis weg.

| Feld                  | Typ             | Erforderlich | Beschreibung                                   |
|-----------------------|-----------------|--------------|------------------------------------------------|
| `host_name`           | string          | Ja           | Host-UUID.                                     |
| `service_description` | string          | Nein         | Service-UUID. Für ein Host-Ergebnis weglassen. |
| `output`              | string          | Ja           | Plugin-Ausgabe.                                |
| `long_output`         | string          | Nein         | Lange Plugin-Ausgabe.                          |
| `perf_data`           | string          | Nein         | Rohe Nagios/Naemon-Performancedaten.           |
| `check_type`          | integer         | Nein         | Check-Typ.                                     |
| `return_code`         | integer         | Nein         | Plugin-Rückgabecode.                           |
| `start_time`          | integer (int64) | Nein         | Startzeit des Checks als Unix-Zeitstempel.     |
| `end_time`            | integer (int64) | Nein         | Endzeit des Checks als Unix-Zeitstempel.       |
| `early_timeout`       | integer         | Nein         | Ob der Check vorzeitig abgelaufen ist.         |
| `latency`             | float64         | Nein         | Check-Latenz.                                  |
| `exited_ok`           | integer         | Nein         | Ob das Plugin erfolgreich beendet wurde.       |


#### Modell `schedule_check`

Plant einen Host- oder Service-Check. Lassen Sie `service_description` weg, um einen Host-Check zu planen. `schedule_time` darf nicht `0` sein.

| Feld                  | Typ             | Erforderlich | Beschreibung                                    |
|-----------------------|-----------------|--------------|-------------------------------------------------|
| `host_name`           | string          | Ja           | Host-UUID.                                      |
| `service_description` | string          | Nein         | Service-UUID. Für einen Host-Check weglassen.   |
| `schedule_time`       | integer (int64) | Ja           | Unix-Zeitstempel, zu dem der Check geplant ist. |


#### Modell `delete_downtime`

Löscht eine geplante Downtime für einen Host oder Service.

| Feld                  | Typ             | Erforderlich | Beschreibung                                    |
|-----------------------|-----------------|--------------|-------------------------------------------------|
| `host_name`           | string          | Ja           | Host-UUID.                                      |
| `service_description` | string          | Nein         | Service-UUID. Für eine Host-Downtime weglassen. |
| `start_time`          | integer (int64) | Nein         | Geplante Startzeit als Unix-Zeitstempel.        |
| `end_time`            | integer (int64) | Nein         | Geplante Endzeit als Unix-Zeitstempel.          |
| `comment`             | string          | Nein         | Downtime-Kommentar.                             |


#### Modell `raw`

Der Wert `Data` ist eine Zeichenkette mit einem [externen Naemon-Befehl](https://www.naemon.io/documentation/developer/externalcommands/). Der Worker ergänzt das führende `[<unix timestamp>]`, wenn es nicht angegeben wurde.

| Feld   | Typ    | Erforderlich | Beschreibung                |
|--------|--------|----------|---------------------------------|
| `Data` | string | Ja       | Zeichenkette mit Naemon-Befehl. |


Zum Beispiel kann ein passives Service-Ergebnis mit `curl` übermittelt werden:

```bash
curl --request POST http://127.0.0.1:8092/commands \
    -H "Authorization: Bearer 027bf8c045d46ef14d8c59336c9d5045d9ae51d614fc047f56b625863e9774d1" \
    -H "Content-Type: application/json" \
    --data '{
        "Command": "check_result",
        "Data": {
            "host_name": "c36b8048-93ce-4385-ac19-ab5c90574b77",
            "service_description": "74fd8f59-1348-4e16-85f0-4a5c57c7dd62",
            "output": "Warning - This is an example",
            "return_code": 1
        }
    }'
```

Eine erfolgreiche Anfrage liefert HTTP `202 Accepted` und die Anzahl der an den Broker veröffentlichten Befehle, beispielsweise `{"accepted": 1}`. Dies bestätigt, dass der Worker den Befehl an den Message Broker übergeben hat; es bestätigt nicht, dass Naemon den Befehl ausgeführt hat. Ungültige Anfragen liefern `400`, nicht erlaubte Befehle `403` und ein Brokerfehler `503`, damit der Client die Anfrage wiederholen kann.

