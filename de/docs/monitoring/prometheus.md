# Überwachung mit Prometheus <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

## Was ist Prometheus?

Prometheus ist ein Open-Source Monitoring System, welches ursprünglich bei [SoundCloud](https://soundcloud.com/) 
entwickelt wurde. Heute ist es ein eigenständiges Projekt, welches unabhängig von einer Firma entwickelt wird.

Im Gegensatz zu Nagios gibt es bei Prometheus keinen Status der über einen Exitcode oder ähnliches erzeugt wird. 
Prometheus ist ein Monitoring-System welches ausschließlich zum Erfassen und überwachen von Metriken geschaffen wurde. 
Auf Deutsch: Es verarbeitet nur Zahlen.

Der Status ergibt sich aus Bedingungen und Abfragen gegen die Metriken mit 
[PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).

Eine typische Alert-Regel wäre zum Beispiel

```plaintext
- alert: ram_at_80_percent
  expr:  node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes * 100 > 80
  for: 15m
  labels:
    priority: "0"
    severity: "warning"
  annotations:
    summary: "RAM is filling up"
    description: "RAM on {{$labels.instance}} has been at 80% for 15 minutes."
```

Wenn die Metrik "belegter Arbeitsspeicher in %" für mehr als 15 Minuten über 80 % ist, verschicke einen "Warning" Alert.

### Exporter

Prometheus selber führt keine Plugins oder Checks aus. Auf dem zu überwachenden System müssen sogenannte 
[Exporter](https://prometheus.io/docs/instrumenting/exporters/) installiert werden.

Die Exporter sind kleine Programme, welche einen Webserver bereitstellen über den die Metriken von Prometheus abgefragt 
werden können. Ähnlich wie bei Nagios gibt es 
[unzählige von der Community entwickelte Exporter](https://github.com/prometheus/prometheus/wiki/Default-port-allocations) 
um Linux, Windows, MySQL, Oracle DB, AWS, UniFi und alles nur erdenkliche überwachen zu können.

### Voraussetzung

Um Prometheus mit openITCOCKPIT nutzen zu können, benötigen Sie eine Community Lizenz, sowie das PrometheusModule.

!!! info "openITCOCKPIT Community Lizenz wird benötigt"
Um Zugriff auf die Community Module zu erhalten, wird eine Registrierung Ihrer openITCOCKPIT Instanz mit der **
kostenlosen** Community Lizenz vorausgesetzt.


Zusätzlich müssen auf dem zu überwachenden System die entsprechenden Exporter installiert sein. Eine Liste mit 
verfügbaren Exporter gibt es auf der [Webseite von Prometheus](https://prometheus.io/docs/instrumenting/exporters/)

### Anlegen eines Exporters in openITCOCKPIT

Um einen Prometheus Exporter in openITCOCKPIT anzulegen, klicken Sie im Hauptmenü Monitoring → Prometheus → Exporters.

In der Übersicht klicken Sie auf die Schaltfläche "Neu".

Im Formular geben Sie zunächst einen Container und einen Namen für den Exporter an.

Das Scrape-Intervall definiert den Zeitabstand in dem Prometheus Daten vom Exporter anfordert.

Das Scrape-Zeitlimit definiert wie lange Prometheus auf die Antwort des Exporters wartet.

Das Feld Service ist eine Beschreibung die Prometheus als Tag zu den Metriken hinzufügt. Dies dient zur Unterscheidung, 
wenn zwei oder mehr Exporter denselben Namen für Metriken nutzen.

Metrik-Pfad definiert die URL auf der der Exporter des zu überwachenden Hosts die Metriken bereitstellt. Dieser Pfad ist
in der Regel immer `/metrics` .

Der Port gibt an auf welchem Port der Exporter läuft.

Manche Exporter benötigen Spezielle YAML Konfigurationen (bspw. Blackbox, SNMP und einige andere). Zu diesem Zweck gibt 
es das Feld "YAML Konfiguration".

![](/images/prometheusmodule-exportersedit.png)

### Überwachen eines Hosts mit Prometheus in openITCOCKPIT

Wie schon bei den Voraussetzungen beschrieben, muss ein entsprechender Exporter auf dem zu überwachenden Host 
installiert und in openITCOCKPIT angelegt worden sein (nur falls dieser von den bereits standardmäßig verfügbaren 
Exporter in openITCOCKPIT abweicht).

Um einen Host mit Prometheus zu überwachen, muss entweder ein neuer Host erstellt oder ein bestehender editiert werden.

Dort wird am Ende des Formulars die Konfiguration des Prometheus Exporters dargestellt.

![](/images/select-prometheus-exporters.png)

Hat man seinen Host entsprechend bearbeitet, speichert man ihn ab.

Danach sollte ein Export der Konfiguration stattfinden.

#### Metriken, Services und Benachrichtigungen

Im nächsten Schritt Navigiert man im Hauptmenü nach Monitoring → Prometheus → Abfrage und wählt dort seinen Host aus der
Auswahlliste aus.

Es werden alle durch den Exporter verfügbaren Metriken aufgelistet. Alle diese angezeigten Metriken werden nun von 
Prometheus erfasst und gespeichert.

![](/images/prometheus-queries.png)

##### Benachrichtigungen

Um Benachrichtigungen zu den Metriken einzurichten, muss ein oder mehrere Services aus den Metriken erstellt werden.

Dazu wählt man die entsprechende Metrik aus und erstellt die passende PromQL Abfrage.

![](/images/prometheus-promql.png)

Prometheus bietet auch die Möglichkeit mehrere Metriken miteinander zu verrechnen. So kann mann dann zum Beispiel die 
Memory Usage unter Linux abfragen:  
`node_memory_MemAvailable_bytes{uuid="d6e35fc3-3ea5-4580-9b31-7cc69e828fb2"} / node_memory_MemTotal_bytes{uuid="d6e35fc3-3ea5-4580-9b31-7cc69e828fb2"} * 100`

Weitere Beispiele dafür findet man unter der "PromQL hilfe" (oben rechts) als Modal. Die UUID ist dabei immer die vom 
aktuellen Host, sodas man die Beispiele einfach Kopieren und Einfügen kann.

Die Einzelnen "Services" findet mann dann unter Monitoring → Prometheus → Abfrage → Alarmregeln. Hier sind dann alle 
Queries pro Host aufgelistet. Wenn man mit der Maus über den Graphen geht, bekommt man den bekannten oITC Popover-Graph,
der dann die Abfrage an Prometheus schickt und die aktuellen Werte anzeigt:

![](/images/prometheus-alertrules.png)

Auf einem Host selbst kann man dann nicht mehr erkennen, durch was ein Service überwacht wird.

Deshalb haben wir den `Service type` eingeführt. Prometheus Services sind dabei auch ganz normale Nagios Services. Im 
Hintergrund läuft ein openITCOCKPIT Dienst `systemctl status prometheus_bridge.service`  
welche alle 15 Sekunden den Status von Prometheus abfragt und dann passiv an Naemon übergibt. Somit macht also 
Prometheus das Monitoring, und Naemon verschickt dann Benachrichtigungen damit wir weiterhin Features wie Downtimes und 
Acknowledgements haben und so ist es auch möglich Prometheus einfach in EVKs, Autoreports und allem anderen zu nutzen.

### Troubleshooting

Für Prometheus müssen folgende Dienste laufen

```plaintext
systemctl status prometheus.service
systemctl status prometheus_bridge.service
```
