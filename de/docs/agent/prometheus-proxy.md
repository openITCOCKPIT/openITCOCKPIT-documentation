# Prometheus-Proxy

Prometheus verwendet sogenannte "Exporter", um Metriken zu sammeln, die meist auf den entfernten Systemen laufen, die Sie überwachen möchten. Standardmäßig ist die Verbindung nicht verschlüsselt.  

Jeder Exporter stellt seinen eigenen Port bereit; zum Beispiel verwendet der `node_exporter` standardmäßig den Port `9100` und der `windows_exporter` den Port `9182`.

Insbesondere bei der Überwachung über verschiedene Netzwerke oder über das Internet müssen Sie Authentifizierung und Verschlüsselung zu Ihrer Monitoring-Konfiguration hinzufügen.  

Die meisten Exporter unterstützen eine Art von Sicherheitskonfiguration, um Authentifizierung und Verschlüsselung zu ermöglichen. Dies bedeutet jedoch, dass Sie jeden einzelnen Exporter konfigurieren müssen und sich dennoch mit den verschiedenen Ports auseinandersetzen müssen.

Der openITCOCKPIT Monitoring-Agent kann als Reverse Proxy für Prometheus-Exporter fungieren. Die Verbindung wird standardmäßig mit demselben Zertifikat verschlüsselt, das auch vom openITCOCKPIT-Agent verwendet wird. Das bedeutet, dass keine manuelle Konfiguration erforderlich ist und nur das openITCOCKPIT-System mit Ihren Prometheus-Exportern kommunizieren kann.


Die Verbindung wird vom openITCOCKPIT-Agent (standardmäßig Port `3333`) gehandhabt, sodass Sie keine Firewall-Regeln anpassen müssen.


!!! notice
    Derzeit ist die Prometheus-Proxy-Funktion nur im Pull-Modus verfügbar.



## Einrichtung

In diesem Abschnitt wird beschrieben, wie Sie den openITCOCKPIT-Agent als Proxy für Prometheus-Exporter einrichten.



### Prometheus-Exporter installieren

Installieren Sie alle Prometheus-Exporter wie gewohnt. Diese Dokumentation zeigt den Prozess anhand des `node_exporter` und des `mysqld_exporter`.


!!! danger
    Aus Sicherheitsgründen stellen Sie sicher, dass die Prometheus-Exporter nur auf localhost (`127.0.0.1` oder `::1`) lauschen.  
    Für den `node_exporter` und `mysqld_exporter` kann dies mit der Option `--web.listen-address=127.0.0.1:9100` geändert werden.  
    Es ist **nicht** notwendig, dass die Prometheus-Exporter im Netzwerk verfügbar sind.



### Den openITCOCKPIT-Monitoring-Agent installieren

Falls noch nicht geschehen, installieren Sie die neueste Version des openITCOCKPIT-Monitoring-Agents.  

Die neueste Version finden Sie auf der [offiziellen Download-Seite](https://openitcockpit.io/download_agent/).



### Den Agent konfigurieren

Es ist wichtig, alle Prometheus-Exporter, die Sie über den openITCOCKPIT-Agent bereitstellen möchten, in die Konfigurationsdatei `prometheus_exporters.ini` einzutragen. Den genauen Dateipfad für verschiedenen Betriebssystemen finden Sie auf [dieser Seite](/agent/debugging/#pfade).

Fügen Sie für jeden Exporter einen neuen Abschnitt hinzu.


```ini
[node_exporter]
enabled = True
method = http
port = 9100
path = /metrics
interval = 15
timeout = 5

[mysqld_exporter]
enabled = True
method = http
port = 9104
path = /metrics
interval = 15
timeout = 5
```

- `[node_exporter]` - Der Name des Expoter.
- `enabled` - `True` or `False` - Bestimmt, ob der openITCOCKPIT-Agent diesen Prometheus-Exporter scrapen soll.
- `method` - `http` or `https`.
- `port` - Die vom Prometheus-Exporter verwendete Portnummer.
- `path` - Der Pfad, den der openITCOCKPIT-Agent durchsuchen soll.
- `interval` - Scrape-Intervall in Sekunden.
- `timeout` - Scrape-Timeout in Sekunden.

Um die Konfiguration anzuwenden, starten Sie den openITCOCKPIT Monitoring Agent neu.

### openITCOCKPIT Konfiguration

Um die Prometheus-Exporter über den openITCOCKPIT Agent abzufragen, müssen Sie über die openITCOCKPIT-Weboberfläche eine neue Exporter-Konfiguration erstellen.
Erstellen Sie für jeden Exporter eine neue Exporter-Konfiguration. In diesem Fall zwei:

#### openITCOCKPIT Agent - node_exporter

- Name: `openITCOCKPIT Agent - node_exporter`
- Metrics path: `/prometheus`
- Port: `3333` (Standard Port des openITCOCKPIT Agenten)
- Add port to targets: `Ja`

Der Parameter exporter: `[node_exporter]` ist wichtig. Er teilt dem openITCOCKPIT Monitoring Agent mit, welcher Exporter angesteuert werden soll. Es muss derselbe Name sein, den Sie in der `prometheus_exporters.ini` des Agenten definiert haben.

```yaml
params:
    exporter: [node_exporter]
scheme: https
tls_config:
    insecure_skip_verify: true
    ca_file: /opt/openitc/agent/server_ca.pem
    cert_file: /opt/openitc/agent/server_ca.pem
    key_file: /opt/openitc/agent/server_ca.key
```

![node_exporter through openITCOCKPIT Agent Proxy](/images/agent/node_exporter_proxy.png){ align=center }

#### openITCOCKPIT Agent - mysqld_exporter

- Name: `openITCOCKPIT Agent - mysqld_exporter`
- Metrics path: `/prometheus`
- Port: `3333` (Standard Port des openITCOCKPIT Agenten)
- Add port to targets: `Ja`

YAML config:

Der Parameter exporter: `[node_exporter]` ist wichtig. Er teilt dem openITCOCKPIT Monitoring Agent mit, welcher Exporter angesteuert werden soll. Es muss derselbe Name sein, den Sie in der `prometheus_exporters.ini` des Agenten definiert haben.

```yaml
params:
    exporter: [mysqld_exporter]
scheme: https
tls_config:
    insecure_skip_verify: true
    ca_file: /opt/openitc/agent/server_ca.pem
    cert_file: /opt/openitc/agent/server_ca.pem
    key_file: /opt/openitc/agent/server_ca.key
```

![mysqld_exporter through openITCOCKPIT Agent Proxy](/images/agent/mysqld_exporter_proxy.png){ align=center }

Bevor Sie fortfahren, aktualisieren Sie unbedingt Ihre Überwachungskonfiguration.
![Refresh monitoring configuration](/images/openITCOCKPIT-Refresh-Monitoring-Config.png)

Das ist alles! Jetzt können Sie mit der Überwachung beginnen. Weitere Informationen zur Verwendung von Prometheus mit openITCOCKPIT finden Sie in [dieser Dokumentation](/monitoring/prometheus/).

![Query Prometheus through openITCOCKPIT Agent Proxy](/images/agent/query_prometheus_via_agent_proxy.png){ align=center }


## Troubleshooting

Der API-Endpunkt `/prometheus` des Agenten gibt alle bekannten Prometheus-Exporteure zurück. Falls einige Metriken fehlen, stellen Sie sicher, dass der Exporter aktiviert und dem Agenten bekannt ist, indem Sie den API-Endpunkt abfragen.

```
$ curl -s -k https://<ip-address>:3333/prometheus --cacert /opt/openitc/agent/server_ca.pem --key /opt/openitc/agent/server_ca.key --cert /opt/openitc/agent/server_ca.pem | jq .
[
  "node_exporter",
  "mysqld_exporter"
]
```

Sie können auch einen bestimmten Exporter abfragen, indem Sie den Parameter `exporter` übergeben: `/prometheus?exporter=node_exporter`

```
$ curl -s -k https://<ip-address>:3333/prometheus?exporter=node_exporter --cacert /opt/openitc/agent/server_ca.pem --key /opt/openitc/agent/server_ca.key --cert /opt/openitc/agent/server_ca.pem
# HELP go_gc_duration_seconds A summary of the pause duration of garbage collection cycles.
# TYPE go_gc_duration_seconds summary
go_gc_duration_seconds{quantile="0"} 2.572e-05
go_gc_duration_seconds{quantile="0.25"} 3.904e-05
go_gc_duration_seconds{quantile="0.5"} 5.144e-05
go_gc_duration_seconds{quantile="0.75"} 5.7401e-05
go_gc_duration_seconds{quantile="1"} 0.00134869
go_gc_duration_seconds_sum 0.001892574
go_gc_duration_seconds_count 12
# HELP go_goroutines Number of goroutines that currently exist.
```

Falls Sie einen unbekannten Exporteur übergeben, antwortet der Agent mit `Unknown exporter`.
```
curl -s -k https://<ip-address>:3333/prometheus?exporter=foobar_exporter --cacert /opt/openitc/agent/server_ca.pem --key /opt/openitc/agent/server_ca.key --cert /opt/openitc/agent/server_ca.pem
Unknown exporter
```
