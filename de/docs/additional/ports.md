# Ports

In der folgenden Tabelle finden Sie die Liste der Ports, die openITCOCKPIT standardmäßig nutzt:


| Port  | Adresse   | Standardmäßig aktiviert | Kommuniziert über | Komponente                             |
|-------|-----------|-------------------------|-------------------|----------------------------------------|
| 22    | 0.0.0.0   | Nein                    | Port              | SSH Server                             |
| 80    | 0.0.0.0   | Ja                      | Port              | Nginx                                  |
| 443   | 0.0.0.0   | Ja                      | Port              | Nginx                                  |
| 161   | 0.0.0.0   | Nein                    | Port              | snmpd                                  |
| 1234  | 127.0.0.1 | Ja                      | Port              | Checkmk (Docker)                       |
| 2003  | 127.0.0.1 | Ja                      | Port              | carbon-cache / carbon-c-relay (Docker) |
| 3033  | 127.0.0.1 | Ja                      | Port              | Grafana (Docker)                       |
| 3306  | 127.0.0.1 | Ja                      | Port              | MySQL                                  |
| -     | -         | Ja                      | Socket            | MySQL                                  |
| 3333  | 0.0.0.0   | Nein                    | Port              | openITCOCKPIT Agent                    |
| 4730  | 127.0.0.1 | Ja                      | Port              | gearmand                               |
| 6379  | 127.0.0.1 | Ja                      | Port              | redis-server                           |
| 6556  | 0.0.0.0   | Nein                    | Port              | xinetd (Checkmk Agent)                 |
| 7473  | 127.0.0.1 | Ja                      | Port              | nsta                                   |
| 7474  | 127.0.0.1 | Ja                      | Port              | nsta                                   |
| 8081  | 127.0.0.1 | Ja                      | Port              | php (sudo_server)                      |
| 8083  | 127.0.0.1 | Ja                      | Port              | php (push_notifications)               |
| 8084  | 127.0.0.1 | Ja                      | Port              | nodejs_server                          |
| 8085  | 127.0.0.1 | Ja                      | Port              | Nginx (Grafana Auth Proxy)             |
| 8428  | 127.0.0.1 | Ja                      | Port              | victoria-metrics (Docker)              |
| 8888  | 127.0.0.1 | Ja                      | Port              | graphite-web (Docker)                  |
| 9090  | 127.0.0.1 | Ja                      | Port              | Prometheus                             |
| 9949  | 127.0.0.1 | Ja                      | Port              | Event-Collectd                         |
| 11211 | 127.0.0.1 | Ja                      | Port              | memcached                              |


