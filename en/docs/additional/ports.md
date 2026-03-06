# Ports

See the table below for the list of ports that openITCOCKPIT assigns by default:


| Port  | Address   | Enabled by default | Communicates via | Component                              |
|-------|-----------|--------------------|------------------|----------------------------------------|
| 22    | 0.0.0.0   | No                 | Port             | SSH Server                             |
| 80    | 0.0.0.0   | Yes                | Port             | Nginx                                  |
| 443   | 0.0.0.0   | Yes                | Port             | Nginx                                  |
| 161   | 0.0.0.0   | No                 | Port             | snmpd                                  |
| 1234  | 127.0.0.1 | Yes                | Port             | Checkmk (Docker)                       |
| 2003  | 127.0.0.1 | Yes                | Port             | carbon-cache / carbon-c-relay (Docker) |
| 3033  | 127.0.0.1 | Yes                | Port             | Grafana (Docker)                       |
| 3306  | 127.0.0.1 | Yes                | Port             | MySQL                                  |
| -     | -         | Yes                | Socket           | MySQL                                  |
| 3333  | 0.0.0.0   | No                 | Port             | openITCOCKPIT Agent                    |
| 4730  | 127.0.0.1 | Yes                | Port             | gearmand                               |
| 6379  | 127.0.0.1 | Yes                | Port             | redis-server                           |
| 6556  | 0.0.0.0   | No                 | Port             | xinetd (Checkmk Agent)                 |
| 7473  | 127.0.0.1 | Yes                | Port             | nsta                                   |
| 7474  | 127.0.0.1 | Yes                | Port             | nsta                                   |
| 8081  | 127.0.0.1 | Yes                | Port             | php (sudo_server)                      |
| 8083  | 127.0.0.1 | Yes                | Port             | php (push_notifications)               |
| 8084  | 127.0.0.1 | Yes                | Port             | nodejs_server                          |
| 8085  | 127.0.0.1 | Yes                | Port             | Nginx (Grafana Auth Proxy)             |
| 8428  | 127.0.0.1 | Yes                | Port             | victoria-metrics (Docker)              |
| 8888  | 127.0.0.1 | Yes                | Port             | graphite-web (Docker)                  |
| 9090  | 127.0.0.1 | Yes                | Port             | Prometheus                             |
| 9949  | 127.0.0.1 | Yes                | Port             | Event-Collectd                         |
| 11211 | 127.0.0.1 | Yes                | Port             | memcached                              |

