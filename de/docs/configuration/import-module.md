# Import Modul <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

Das Import Modul ist eines der umfangreichsten und komplexesten Module in openITCOCKPIT. Über das Import Modul können Hosts aus anderen Systemen importiert werden. Dabei kann es sich um einen klassischen CSV Import handeln oder den Import aus einer Configuration Management Datenbank (CMDB) wie i-doit oder iTop handeln. Auch dient das Modul dem Import neuer openITCOCKPIT Agenten im Pushmodus. Für alle Importer ermöglicht es zudem die regelbasierte Zuweisung von Servicechecks. Dabei untersützt es diverse Methoden, bis hin zur Statusübernahme aus anderen Monitoringsystemen.

## Installation des Modules

Navigieren Sie zu `Verwaltung -> Systemwerkzeuge -> Paketmanager` und installieren Sie das *ImportModule*

## Host-Standardeinstellungen

In einem ersten Schritt muss unter *Host-Standardeinstellungen* mindestens eine Standarddefinition angelegt werden. Mit den Host-Standardeinstellungen werden die Parameter Hosttemplate, Container, Satellitensystem und zugewiesene Services festgelegt.

Navigieren Sie zu `Verwaltung -> Objektimport -> Host-Standardeinstellungen` und erstellen Sie über den Button **New** eine neue Definition.

![](/images/import-module/host_defaults.png)

Mit der Auswahl eines Containers wird festgelegt, in welchen Container die neuen Host importiert werden sollen. Mittels Hosttemplate kann definiert werden, welche Vorlage bei neu importierten Hosts als Basis genutzt werden soll. Durch die Auswahl weiterer Shared Container kann auch direkt ein Aufbau spezieller Sichten realisiert werden. Als letztes Hostdetail wird noch ausgewählt, ob die neuen Hosts auf dem Mastersystem oder einem Satelliten angelegt werden sollen.

In den optionalen Sektionen können schließlich die Regeln für die automatische Servicezuweisung definiert werden.

![](/images/import-module/servicetemplategroup_matches.png)

Das Bild zeigt exemplarische die Zuweisung von Servicetemplate Groups, bei denen eines der Attribute Hostname, Description, Address oder Software mit einem regulären Ausdruck verglichen wird. Sofern der reguläre Ausdruck gefunden wird, erfolgt eine Zuweisung der ausgewählten Servicetemplate Group.

## Importer

Über die Importer wird der eigentliche Datenimport realisiert. Dabei gibt es unterschiedliche Arten von Importern.

- **CSV**
    - Ermöglicht den Import von CSV-Dateien
- **openITCOCKPIT Agent**
    - Neben der Möglichkeit einen Host über Wizards aufzunehmen, kann der openITCOCKPIT Agent auch Datenquelle für einen Import sein.
- **CMDB**
    - Im Bereich der CMDBs ein Import aus iTop und i-doit ausgewählt werden
- **External monitoring Systems**
    - Neben klassischen CMDBs können auch andere Monitoringsystem, wie beispielsweise Icinga2, als Datenquellen genutzt werden. Die Besonderheit dabei ist, dass nicht nur die Hosts, sondern auch die Statusinformationen aus dem externen Monitoringsystem ermittelt und dargestellt werden.
- **CMDB + External monitoring System**
    - Eine Kombination der Methoden ist ebenfalls möglich, dabei erfolgt der Import auf Basis der Informationen aus der CMDB und wird mit den Informationen aus dem externen Monitoringsystem verglichen. Auch in diesem Fall werden nicht nur Hosts importiert, sondern auch die Statusinformationen aus dem externen Monitoring mit übernommen.

### CSV Import

Nach der Definition einer Host-Standardeinstellungen-Vorlage können direkt Importer für CSV-Dateien erstellt werden.

Navigieren Sie zu `Verwaltung -> Objektimport -> Importeure`

![](/images/import-module/csv_settings.png)

Wichtig sind insbesondere die richtigen Attribute im Mapping und die Auswahl einer Host-Standardeinstellungen-Vorlage, damit die Zuordnungen richtig erfolgen können.

![](/images/import-module/csv_mapping.png)

Eine funktionierende CSV-Datei für den Import könnte wie folgt aussehen:

```
hostname;address;description;software
srvweb04.itsm.love;127.10.10.1;Web server 1;Linux-local,nginx
srvweb05.itsm.love;127.10.10.2;Web server 2;Linux-local,nginx
srvmysqldb01.itsm.love;127.0.0.1;MySQL DB Server;Linux-local,mysql
```

### openITCOCKPIT Agent

Für den Import von openITCOCKPIT Agents benötigt man eine spezielle Host-Standardeinstellung. Hierbei erfolgt die Zuordnung über die Agent Checks. 

Navigieren Sie zu `Verwaltung -> Objektimport -> Host-Standardeinstellungen`

![](/images/import-module/agent_checks_matches.png)

Alle weiteren Parameter verhalten sich analog zu anderen Host-Standardeinstellungen und werden daher an dieser Stelle nicht mehr beschrieben.

Navigieren Sie zu `Verwaltung -> Objektimport -> Importeure`

Die Einstellungen des Importers sind dann ähnlichen denen eines CSV-Importers. Wichtig ist als Datenquelle den openITCOCKPIT Agent auszuwählen und bei den Host Default Zuweisungen das richtige Template auszuwählen.

![](/images/import-module/agent_host_defaults_assignment.png)

### CMDB

Bevor eine CMDB als Datenquelle dienen kann, muss diese zuerst als externes System erstellt werden.

Dabei müssen die CMDB spezifischen Verbindungsdaten eingeben werden.

Navigieren Sie zu `Verwaltung -> Objektimport -> Externe Systeme`

![](/images/import-module/ext_systems_conn_settings.png)

Darüber hinaus ist zu definieren, welche Objekttypen aus der CMDB in den Import mit einbezogen werden sollen.

![](/images/import-module/ext_systems_object_types.png)

Nachdem die CMDB als externes System eingerichtet wurde, kann der Importer wie gewohnt erstellt werden. Als Datenquelle ist die entsprechende CMDB (i-doit, iTop, ...) in Kombination mit dem Externen System, das abgefragt werden soll, auszuwählen.

Navigieren Sie zu `Verwaltung -> Objektimport -> Importeure`

![](/images/import-module/importer_cmdb_source.png)

!!! info "Hinweis"
    Durch den Import der Hosts werden die Hosts auch im Assetinformationen aus der CMDB erweitert.

### Externes Monitoring System

Wie schon bei der CMDB muss vor Erstellung eines Importers erst das externe Monitoring System angelegt werden.

Navigieren Sie zu `Verwaltung -> Objektimport -> Externes Monitoring`

Nachdem das System angelegt wurde, kann der Importer erzeugt werden.

Navigieren Sie zu `Verwaltung -> Objektimport -> Importeure`

![](/images/import-module/importer_ext_mon_source.png)

### CMDB + Externes Monitoring System

Die Kombination erfordert ein definiertes externes Monitoring System und ein externes System. Die Erstellung erfolgt entprechend den Punkten Externes Monitoring System und CMDB.

Navigieren Sie zu `Verwaltung -> Objektimport -> Importeure`

Der Importer kann nun mit beiden Datenquellen erstellt werden.

![](/images/import-module/importer_both_source.png)

## Import der Daten

Nachdem alle Vorbereitungen getroffen wurden, kann nun der Import durchgeführt werden.

Navigieren Sie zu `Verwaltung -> Objektimport -> Importierte Hosts`

Über den Button **Import starten** kann der gewünschte Importer ausgewählt werden.

![](/images/import-module/start_import.png)

Bei erfolgreicher Verbindung werden alle zu importierenden Systeme aufgelistet und man kann über den Button **Starte Datenimport** den Import beginnen.

![](/images/import-module/hosts_for_import.png)

Im nächsten Schritt erhält man eine Übersicht mit allen Hosts, den zugewiesenen Services und weiteren Informationen. Die Übernahme in das Monitoring erfolgt über den Button **Mit dem Monitoring-System synchronisieren**.

![](/images/import-module/import_sync_monitoring.png)

!!! info "Hinweis"
    Zur Aktivierung der Überwachung muss wie gewohnt ein Refresh der Monitoringkonfiguration erfolgen.

## Darstellung & Informationen

Im Rahmen des Imports werden bei den einzelnen Systemen weitere Informationen in openITCOCKPIT übertragen. Dabei kann es sich um Informationen aus Externen Monitoringsystemen oder Externen Systemen (wie CMDBs) handeln.

### Externe Monitoringsysteme
Bei dem Import aus externen Monitoringsystemen wird in der Regel nicht nur die Konfiguration importiert, sondern auch die Status- und Performancedaten übertragen.

#### Icinga2
Icinga2 verfügt über einen Eventbroker, von dem die Statusdaten in Echtzeit ermittelt werden können. 

![](/images/import-module/import_icinga2_oitc_1.png)

![](/images/import-module/import_icinga2_oitc_2.png)

Dadurch können sogar Acknowledgements und Downtimes in Echtzeit von Icinga2 in openITCOCKPIT übertragen werden.

![](/images/import-module/import_icinga2_oitc_3.png)

![](/images/import-module/import_icinga2_oitc_4.png)

#### PRTG

Für PRTG bietet das Importmodul die Möglichkeit Statusinformation und Performancendaten zu übertragen. Anders als bei Icinga2 müssen die Informationen über eine API abgefragt werden. Dadurch ist eine Echtzeitauswertung der Daten nicht möglich. Auch bietet die PRTG-API keine Möglichkeit Downtimes oder Acknowledgments auszulesen.

![](/images/import-module/import_prtg_oitc_1.png)

![](/images/import-module/import_prtg_oitc_2.png)

![](/images/import-module/import_prtg_oitc_3.png)

#### OpManager / ManageEngine

Der OpManager von ManageEngine kann ebenfalls über eine API angebunden werden. Auch hier ist eine Abfrage der API zur Ermittlung der Informationen notwendig, was eine Auswertung in Echtzeit nicht möglich macht. Zudem muss darauf geachtet werden, dass die Anzahl der API Calls limitiert ist und gegebenenfalls die Lizenz des OpManagers erweitert werden muss.

![](/images/import-module/import_opmanager_oitc_1.png)

![](/images/import-module/import_opmanager_oitc_2.png)

![](/images/import-module/import_opmanager_oitc_3.png)

![](/images/import-module/import_opmanager_oitc_4.png)

#### FlowChief

Aus dem [FlowChief Plantexplorer](https://facts.flowchief.de/de-de/Topics/Plantexplorer/Plantexplorer.htm) können einzelne Knoten mit ihren Prozessvariablen von openITCOCKPIT importiert werden.
Knoten werden dabei als Host und Prozessvariablen als Dienste erstellt. Statusänderungen werden über eine WebSocket Schnittstelle aboniert um keine zusätzliche Last auf dem FlowChief System zu erzeugen.

![](/images/import-module/FlowChief_data_in_openitcockpit.png)

#### LibreNMS

openITCOCKPIT kann `Geräte`, `Ports`, `Services` und `Alarme`, welche von LibreNMS überwacht und bereitgestellt werde importieren, um eine zentrale Übersicht zu ermöglichen.
Alle Informationen werden in regelmäßigen Abständen vom LibreNMS System über die HTTP API abgefragt. Sofern möglich, wird openITCOCKPIT auch Metriken in Form von Graphen speichern.

Aktive `Alarme` werden in openITCOCKPIT im Longoutput des Hosts angezeigt und können je nach Konfiguration den Hoststatus auf "Down" wechseln.
`Ports` und `Services` aus LibreNMS werden in openITCOCKPIT als Service erstellt. openITCOCKPIT versucht dabei den Namen des `Ports` so genau wie möglich nachzubilden.

![](/images/import-module/librenms_example_host.png)

![](/images/import-module/librenms_host_in_openitcockpit.png)

### Externe Systeme

Neben Informationen zu der Konfiguration, liefern externe Systeme in der Regel auch weitere Aspekte wie Assetinformationen und Abhängigkeitsbäume, die in openITCOCKPIT als zusätzliche Attribute dargestellt werden können.

#### i-doit

i-doit ist eines der Systeme, die auch Assetinformationen liefern können. Dabei werden Unterkategorien sogar auf einer Seite zusammengeführt und ansprechend dargestellt. Für weiterführende Informationen existiert eine Verlinkung, die direkt auf das Asset verweist.

![](/images/import-module/import_oitc_idoit_asset_1.png)

![](/images/import-module/import_oitc_idoit_asset_2.png)

Neben den Assetinformationen können auch Abhängigkeiten zwischen den einzelnen Assets als Servicebaum dargestellt werden.

#### iTop

Analog zu i-doit liefert iTop ebenfalls Assetinformationen, die bei den Hosts im Reiter CMDB dargestellt werden. Eine Verlinkung auf das entsprechende CI innerhalb von iTop ist ebenfalls vorhanden.

Und auch die Abhängigkeiten können ähnlich wie bei i-doit dargestellt werden.

![](/images/import-module/import_oitc_itop_tree_1.png)

![](/images/import-module/import_oitc_itop_tree_2.png)