# Windows Service Configuration

Several settings can't be configured via `config.ini` but passed as a CLI parameter. On Windows the Agent usually runs as Windows Service. You can set the following parameters via the Windows Registry.

Path: `HKEY_LOCAL_MACHINE\SOFTWARE\openitcockpit\InstalledProducts\openitcockpit-agent`

There you can add the following additional configuration keys. All keys must be of type string (`String Value` / `Zeichenfolge`), even when the values are numeric!

| Key               | Default                    | Possible              |
|-------------------|----------------------------|-----------------------|
| InstallLocation   |                            | **Never change this** |
| ConfigurationPath | InstallLocation/config.cnf | Any valid path        |
| LogPath           | InstallLocation/agent.log  | Any valid path        |
| LogRotate         | 3                          | 0 - N (0 == disable)  |
| Verbose           | 0                          | 0 or 1                |
| Debug             | 0                          | 0 or 1                |

openITCOCKPIT agents installed before version 3.6.0 use the registry path `HKEY_LOCAL_MACHINE\SOFTWARE\it-novum\InstalledProducts\openitcockpit-agent`.