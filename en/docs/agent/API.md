# API

## Webserver API

This documentation descrips the API of the in-build web server of the openITCOCKPIT Monitoring Agent.

### GET /
Check results in json format. The result could be `{}` if the checks did not finish correctly or couldn't be serialized.


### GET /config
If config push mode is enabled it will return the following JSON

```json
{
    "configuration": "base64 string of the configuration file",
    "customcheck_configuration": "base64 string of the custom check configuration file or empty string if it does not exist"
}
```

### POST /config

Expects a JSON with the same format of `GET /config`

The base64 will be decoded and written to the current configuration paths.


### GET /autotls

Returns a certificate signing request (CSR) for Auto-TLS. This will generate a new private key if there's none.

```json
{
    "csr": "contents of the CSR in PEM format"
}
```

### POST /autotls

Stores a new ssl certificate and CA certificate for Auto-TLS.

```json
{
    "signed": "",
    "ca": ""
}
```

#### Auto-TLS

After Auto-TLS has been established further certificate updates are only possible from the openITCOCKPIT server, because it is then required to use a valid https connection. You can also enable basic auth if you want additional security for the first "handshake".

The `/autotls` endpoints are only available if `try-autossl=True` is enabled in `config.ini`

### GET /packages

Returns information about installed packages and available updates. The exact content of the response depends on the operating system and package manager used.

```json
{
  "Enabled": true,
  "Pending": false,
  "LastUpdate": 1770725707,
  "Stats": {
    "InstalledPackages": 86,
    "UpgradablePackages": 1,
    "SecurityUpdates": 1,
    "RebootRequired": true,
    "LastError": "",
    "OperatingSystem": "windows",
    "PackageManager": "windows-updates",
    "OsName": "Microsoft Windows Server 2022 Standard Evaluation",
    "OsVersion": "21H2 (10.0.20348.4648 Build 20348.4648)",
    "OsFamily": "windows",
    "AgentVersion": "3.5.0",
    "Uptime": 1132701
  },
  "LinuxPackages": [],
  "LinuxUpdates": [],
  "WindowsApps": [
    {
      "Name": "DigiCert ONE Clients 1.5.1",
      "Version": "1.5.1",
      "Publisher": "DigiCert, Inc."
    },
    {
      "Name": "Git",
      "Version": "2.52.0",
      "Publisher": "The Git Development Community"
    },
    ...
  ],
  "WindowsUpdates": [
    {
      "Title": "Security Intelligence-Update für Microsoft Defender Antivirus – KB2267602 (Version 1.443.1104.0) – Aktueller Kanal (Allgemein)",
      "Description": "Installieren Sie dieses Update, um die Dateien zu überarbeiten, die zum Erkenne",
      "KBArticleIDs": [
        "2267602"
      ],
      "IsInstalled": false,
      "IsSecurityUpdate": true,
      "IsOptional": false,
      "UpdateID": "2a4ed49f-8019-47f3-a1e4-fc73fa6cbe5f",
      "RevisionNumber": 200,
      "RebootRequired": false
    }
  ],
  "MacosApps": [],
  "MacosUpdates": []
}
```


## openITCOCKPIT API Endpoints

This documentation descrips the openITCOCKPIT API used by the Agent in Push mode.

### POST /agentconnector/register_agent.json
Used to register new Agent and to check authorization state.

#### Register new Agent
Request: POST `/agentconnector/register_agent.json`
```json
{
    "agentuuid": "<uuid>",
    "password": "", // Empty for new Agents
    "hostname": "<optional>",
    "ipaddress": "<optional>"
}
```
Response:
```json
Status: 201 Created
{
    "agentuuid": "<uuid>",
    "password": "32e8d6eefa9c50e07e9296cd0202126a5926dc4dd473400d3..."
}
```

#### Check authorization state of existing agents
Request: POST `/agentconnector/register_agent.json`
```json
Status: 200 OK
{
    "agentuuid": "<uuid>",
    "password": "32e8d6eefa9c50e07e9296cd0202126a5926dc4dd473400d3..."
}

```

#### Error states
```json
400 Bad Request
{
    "error": "Field uuid or password is missing in POST data"
}
```

```json
403 Forbidden
{
    "error": "The given UUID is already registed with a password!"
}
```

```json
404 Not Found
{
    "error": "No Agent found for given UUID and password"
}
```

```json
405 Method Not Allowed
{
    "message": "Method Not Allowed",
    "url": "\/agentconnector\/register_agent.json",
    "code": 405
}
```

---

### POST /agentconnector/submit_checkdata.json
Used to push check result data to openITCOCKPIT Monitoring Server

#### Push check results
Request: POST `/agentconnector/submit_checkdata.json`
```json
{
    "agentuuid": "<uuid>",
    "password": "32e8d6eefa9c50e07e9296cd0202126a5926dc4dd473400d3...",
    "checkdata": {
        "agent":        {},
        "cpu":          {},
        "customchecks": {},
        "disk_io":      {},
        "disks":        {},
        ...
    }
}
```
Response:
```json
Status: 200 OK
{
    "received_checks": 10
}
```

##### Error states
```json
400 Bad Request
{
    "error": "Invalid credentials or host not found"
}
```

```json
405 Method Not Allowed
{
    "message": "Method Not Allowed",
    "url": "\/agentconnector\/submit_checkdata.json",
    "code": 405
}
```