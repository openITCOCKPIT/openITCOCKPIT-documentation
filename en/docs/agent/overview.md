# Agent Overview

Cross-Platform Monitoring Agent for openITCOCKPIT written in Go

## What is the openITCOCKPIT Monitoring Agent
Based on the programming language Go, the openITCOCKPIT Monitoring Agent is a cross-platform application to gather basic information and metrics about the operating system, running services, programs and sensors.

This involves usage information such as CPU, memory, SWAP or disk usage and IO information about disks and network interfaces.

By default, the system polls new values every 30 seconds. Since the openITCOCKPIT Monitoring Agent does not have to provide historical data, but only the current status of the system, outdated information is regularly overwritten with new information and is not saved.

In order to enable your own checks or the execution of existing Nagios plugins, a configuration file can be used to specify which commands (command or path to an executable file) are to be executed at specific time intervals and with defined timeouts. These checks are called [custom checks](/agent/define-customchecks/).

Using this method, pre existing Naemon, Nagios, Shinken, Icinga 1 and Sensu plugins can be easily integrated into the openITCOCKPIT Monitoring Agent.


The openITCOCKPIT Monitoring Agent is available and tested for Windows (32 and 64 bit), macOS (Intel and Apple Silicon) and the common Linux
 distributions such as Debian, Ubuntu, Red Hat Linux, CentOS, SLES and openSUSE (amd64 and arm64).

Please visit the [release page](https://github.com/openITCOCKPIT/openitcockpit-agent-go/releases) to download the latest or older versions.

## Communication methods
The openITCOCKPIT Monitoring Agent can operate in Pull or Push Mode. By default the communication is encrypted by TLS and transferred via HTTPS. You don't have to manually create TLS certificates openITCOCKPIT will take care of this.

### Pull Mode
Pull mode is the recommended and the most common used type of monitoring. In Pull Mode, the openITCOCKPIT Monitoring Agent will start a web server on port `3333`. 

The openITCOCKPIT Monitoring Server will query the Agent every 60 seconds and process all check results.

Communication way: `openITCOCKPIT Monitoring Server => openITCOCKPIT Monitoring Agent (HTTPS)`

### Push Mode
In Push Mode, the openITCOCKPIT Monitoring Agent will push the check results every 60 seconds to the openITCOCKPIT Monitoring Server. The Push Mode is neat whenever the openITCOCKPIT Monitoring Server is not able to reach the target device like in an NAT or cloud based environment.

By default, the connections gets secured by HTTPS with self-signed certificates.
We recommend to use valid certificates like from [Let’s Encrypt](https://letsencrypt.org/) for this use case, but it is not required.

The Agent's in-build web server is disabled in Push mode. You can enable it via the [config.ini](https://github.com/openITCOCKPIT/openitcockpit-agent-go/blob/83ae5bafc4219fcd9e059437a0d25497de0fb268/example/config_example.ini#L165-L168) if you like.

Communication way: `openITCOCKPIT Monitoring Agent => openITCOCKPIT Monitoring Server (HTTPS)`

## Security concept
Unlike most other tools, **we decided to enable encryption by default**. All Agents are independent from each other so you can choose the perfect communication and encryption method for each Agent.

### Auto-TLS (Pull Mode)
Auto-TLS is the recommended communication type for Agents running in Pull Mode. The openITCOCKPIT Monitoring Server pull an 
Certificate Signing Request (CSR) from the Agent and sign a unique certificate for the particular Agent. As soon as the _certificate handshake_ was successful the openITCOCKPIT Server will never ever again send an unencrypted connection to the openITCOCKPIT Monitoring Agent.

In addition the certificate will be used for authentication purpose (TLS Client Certificate Authentication). Only the openITCOCKPIT Monitoring Server can query the check results from the openITCOCKPIT Monitoring Server.

### HTTPS (Pull Mode)
If you don't want to use Auto-TLS it is also possible to provide own certificates for HTTPS. In this case you have to enable [Basic Authentication](#basic-authentication) to protect the Agent from unauthorized access.

### HTTPS (Push Mode)
In Push Mode the communication gets encrypted by the HTTPS configuration of the openITCOCKPIT Monitoring Server. By default, the Agent will not verify the certificates to enable the usage of self-signed certificates. Certificate validation can be enabled in the `config.ini` of the Agent.
```ini
# Enable this option when your openITCOCKPIT server uses valid TLS certificates
# like from Let's Encrypt
verify-server-certificate = False
```
The Agent's in-build web server is disabled in Push Mode. If you enable it enable [Basic Authentication](#basic-authentication) to protect the Agent from unauthorized access.

### HTTP (Pull mode - not recommended)
It is also possible to use an unencrypted plaintext HTTP communication, but you explicitly have to enable it by yourself. You can enable [Basic Authentication](#basic-authentication) to protect the Agent from unauthorized access.

### Basic Authentication
HTTP Basic Authentication can be enabled in the `config.ini`
```ini
# Enable HTTP Basic Authentication
# Disabled if blank
# Example: auth = user:password
auth = user:password
```

### TLS configuration

TLS supports different versions and cipher suites, not all of them are secure anymore.

To be compatible with as many systems as possible, without making the configuration too complicated, we decided to introduce three preconfigured levels of security:

- `lax`
- `intermediate`
- `modern`

The TLS security level can be configured in the `config.ini` using the `tls_security_level` directive.


!!! info
    If no `tls_security_level` is configured, the Agent will fall back to `lax`.

#### lax
Enforce minimum TLS 1.2 but does not restrict usage of cipher suites.
Was the default behavior before openITCOCKPIT Agent Version 3.1.

#### intermediate
Enforce minimum TLS 1.2 and restrict usage of cipher suites to:
```
TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256, TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256, TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384, TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305, TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305
```

#### modern
Enforce minimum TLS 1.3 and does not restrict usage of cipher suites.

## Start Monitoring
Open the openITCOCKPIT web interface and navigate to `openITCOCKPIT Agent -> Agent Wizard` and select the host you want to monitor. Follow the wizard to monitor your target system with the openITCOCKPIT Monitoring Agent in 5 steps. The wizard covers everything from choosing the communication method over installing and configuring the Agent up to service creation.

The [openITCOCKPIT Beginners guide](/beginners/openitcockpit-agent/) covers all steps in detail.
