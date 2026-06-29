# Mobile App <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

!!! info "Closed Beta"
    The openITCOCKPIT Mobile App for iOS and Android is currently in closed beta.
    When reading this, the app maybe is not yet available in the App Store or Google Play Store.

![openITCOCKPIT iOS App running on an iPhone 16e](/images/mobile-app/openitcockpit-ios-app.png){ align=center }
*Graphic: openITCOCKPIT iOS App running on an iPhone 16e*


## Requirements

- openITCOCKPIT 5.6.1 or higher
- iOS 17.5 or higher
- The openITCOCKPIT server must be reachable from the mobile device (e.g. via VPN or public IP address)
- A valid HTTPS certificate is required. Self-signed certificates will most likely not work.


## Download the App

- Apple App Store
- Google Play Store

(Links will be added once the app is available in the stores)

## Setup Push Notifications

A huge benefit of the mobile app, compared to its web-based counterpart is, the ability to receive push notifications for alerts.
To enable this, you need to configure your openITCOCKPIT server to send notifications though the **Push Gateway Service provided by AVENDIS GmbH**.
This service is free of charge for openITCOCKPIT users.

1. Navigate to `System configuration -> System -> Push Notification Settings`
2. Set Relay address to `https://pushrelay.openitcockpit.io`
3. Set Port to `443`
4. Click on `Request and test Auth-Key`.

openITCOCKPIT will now request an authentication key from the Push Gateway Service. The Push Gateway Service will use the provided System ID
to identify your openITCOCKPIT server and will generate a new authentication key for your server.

To complete the setup, make sure to click on `Save configuration` after the key has been generated.

![Request Auth-Key](/images/mobile-app/setup-push-gateway.png)

### Assign Users to Contacts

It is important to assign your openITCOCKPIT user one (or more) contact(s) in order to receive push notifications for alerts.

First, navigate to `Monitoring -> Objects -> Contacts` and select the contact you want to assign to your user, or create a new contact.

Make sure to select your openITCOCKPIT user in the `Users` field of the contact configuration.
Also tick the checkbox `Push notifications to browser` for hosts and services. This option will now send Notifications to both, the web interface and the mobile app.

![Assign Users to Contacts](/images/mobile-app/assign-users-to-contacts.png)

To apply the changes, make sure to save the contact configuration and refresh the monitoring configuration.

![Refresh monitoring configuration](/images/openITCOCKPIT-Refresh-Monitoring-Config.png)

## Setup the Mobile App

Once the app is installed on your mobile devices, you can start the app and enter the URL of your openITCOCKPIT server.
The app uses the openITCOCKPIT API for authentication, so you have to [create an API key first](../../development/api/#api-keys).

![Mobile App Login](/images/mobile-app/iphone-login-docs.png)

For convenience, you can also scan the QR code from the openITCOCKPIT web interface to automatically fill in the API key.

## Web Application Firewall (WAF) / Reverse Proxy <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

!!! info "Info"
    The Web Application Firewall is **not required** to use the openITCOCKPIT Mobile App. It is an optional feature for users who want to add an extra layer of security to their openITCOCKPIT server.

For adding an extra layer of security, we provide an optional Web Application Firewall (WAF) / Reverse Proxy configuration for the openITCOCKPIT Mobile App. This configuration is based on Nginx and can be used to protect your openITCOCKPIT server from malicious requests.

The way it works is, the openITCOCKPIT App will send all requests to the WAF, which will check the request and forward it to the openITCOCKPIT server if it is valid.
In case the request got blocked by the WAF, a **406 Not Acceptable** response will be returned.

The WAF also hosts the Web App version of the openITCOCKPIT App, which can be accessed via a web browser. This is useful for users who want to access the openITCOCKPIT Mobile Website from a desktop computer or without installing the openITCOCKPIT App to their mobile devices.

![WAF Firewall](/images/mobile-app/WAF-Firewall.drawio.png)

### Installation

The WAF is designed to run in a Docker container, therefore we provide pre-built Docker images for `amd64` and `arm64` architectures.

### Authentication and downloading the image
Before you can download the Docker image, you must register with our Docker Registry:

```bash
docker login https://cr.openitcockpit.io
```

The command prompts you to enter a username as well as a password.
As username please enter the e-mail address which is registered with your openITCOCKPIT Enterprise license key. As
password enter your license key.

After successful authentication you can download the Docker image:

```bash
docker pull cr.openitcockpit.io/openitcockpit/openitcockpit-mobile-waf:latest
```

### Starting the Docker container

- **OITC_SERVER** must be set to the hostname (e.g. `demo.openitcockpit.io`) or IP address (`192.168.56.2`) of your openITCOCKPIT server. The WAF will forward all requests to this server.
- **SSL_CERT_PATH** and **SSL_CERT_KEY_PATH** must be set to the path of your SSL certificate and key **inside the container**. You can mount a directory from the host to the container to provide the certificate and key.

You can start the container with the following command:

```bash
docker run --rm -it \
--name openitcockpit-mobile-waf \
-p 80:80 \
-p 443:443 \
-e WEB_APP_ENABLED=1 \
-e OITC_SERVER=demo.openitcockpit.io \
-e SSL_CERT_PATH=/etc/nginx/certs/local.crt \
-e SSL_CERT_KEY_PATH=/etc/nginx/certs/local.key \
-v /path/on/host/certs:/etc/nginx/certs:ro \
cr.openitcockpit.io/openitcockpit/openitcockpit-mobile-waf:latest
```

The WAF only supports HTTPS connections, therefore you must provide a valid SSL certificate and key. You can use a self-signed certificate for testing purposes, but we recommend using a valid certificate from a trusted CA for production environments.

### Configuration options

The configuration of the WAF can be done via environment variables. The following options are available:

| Environment Variable | Description | Valid Values | Default Value |
|----------------------|-------------|---------------|---------------|
| `WEB_APP_ENABLED` | Enable or disable the Web App | `0` or `1`  | `1` |
| `OITC_SERVER` | The URL of the openITCOCKPIT server | IP address or hostname| `192.168.56.2` |
| `DNS_RESOLVER` | DNS resolver used by Nginx | IP address| `9.9.9.9 8.8.8.8` |
| `SSL_CERT_PATH` | Path to the SSL certificate | File path| `/etc/nginx/certs/fullchain.pem` |
| `SSL_CERT_KEY_PATH` | Path to the SSL certificate key | File path| `/etc/nginx/certs/privkey.pem` |
| `SSL_PROTOCOLS` | SSL protocols to use | Nginx compatible list of SSL protocols | `TLSv1.2 TLSv1.3` |
| `SSL_CIPHERS` | Supported SSL ciphers | Nginx compatible list of supported SSL ciphers |`ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305` |
| `SSL_PREFER_SERVER_CIPHERS` | Enable or disable the preference of server ciphers over client ciphers  | `on` or `off` | `on` |


### Web App

The WAF check the Accept header of of incoming requests to `/` for `text/html` or `application/xhtml\+xml` and will redirect the request to the Web App at `/app/`.
In case this redirect is not working, your Browser is probably sending a different Accept header. In this case, please navigate to `/app/` directly to access the Web App.

![openITCOCKPIT Mobile Web App running in a web browser](/images/mobile-app/waf_desktop_example.png)

#### WAF behind a reverse proxy

The WAF itself can also be placed behind a reverse proxy. This is useful, if you want to use self-signed certificates inside of the WAF container, but want to use a valid certificate for the outside world. In this case, the reverse proxy will handle the SSL termination and forward the requests to the WAF via HTTPS.

```
Mobile Device --> Reverse Proxy (valid SSL cert) --> WAF (self-signed SSL cert) --> openITCOCKPIT Server
```

##### Apache2 example

This example shows how to configure an Apache2 reverse proxy in front of the WAF. The reverse proxy will handle the SSL termination and forward the requests to the WAF via HTTPS.
In this example, the WAF is running on the same server as the reverse proxy `127.0.0.1:5555` and the reverse proxy is listening on `waf.example.org`.

```apache
<VirtualHost 207.154.223.22:80>
  ServerName waf.example.org
  Redirect / https://waf.example.org/

  ErrorLog ${APACHE_LOG_DIR}/openitcockpit_waf_error.log
  CustomLog ${APACHE_LOG_DIR}/openitcockpit_waf_access.log combined
</VirtualHost>

<VirtualHost 207.154.223.22:443>
    ServerName waf.example.org
    ServerAdmin info@example.org
    DocumentRoot "/var/www/html"

    SSLEngine On
    SSLCertificateChainFile  /etc/letsencrypt/live/example.org/fullchain.pem
    SSLCertificateKeyFile    /etc/letsencrypt/live/example.org/privkey.pem
    SSLCertificateFile       /etc/letsencrypt/live/example.org/cert.pem

    ErrorLog ${APACHE_LOG_DIR}/openitcockpit_waf_error.log
    CustomLog ${APACHE_LOG_DIR}/openitcockpit_waf_access.log combined

    SSLProxyEngine On
    ProxyPreserveHost On
    ProxyPass / https://127.0.0.1:5555/
    ProxyPassReverse / https://127.0.0.1:5555/
    SSLProxyCheckPeerName Off
    #RequestHeader set X-Forwarded-Proto "https"
    #RequestHeader set X-Forwarded-Port "443"
    #RequestReadTimeout header=7200 body=7200

    Include /etc/letsencrypt/options-ssl-apache.conf

</VirtualHost>
```

For the given Apache2 example above, the WAF was started with the following commands:

```sh
# Create a self-signed certificate for the WAF.
apt-get install ssl-cert
mkdir -p /root/openitcockpit-waf/certs
cp /etc/ssl/certs/ssl-cert-snakeoil.pem /root/openitcockpit-waf/certs/
cp /etc/ssl/private/ssl-cert-snakeoil.key /root/openitcockpit-waf/certs/

# Start the WAF container with the self-signed certificate listening on port 5555.
# The Apache2 reverse proxy will handle the SSL termination and forward the requests to the WAF via HTTPS.
docker run --rm -it \
--name openitcockpit-mobile-waf \
-p 5554:80 \
-p 5555:443 \
-e WEB_APP_ENABLED=1 \
-e OITC_SERVER=demo.openitcockpit.io \
-e SSL_CERT_PATH=/etc/nginx/certs/ssl-cert-snakeoil.pem \
-e SSL_CERT_KEY_PATH=/etc/nginx/certs/ssl-cert-snakeoil.key \
-v /root/openitcockpit-waf/certs:/etc/nginx/certs:ro \
cr.openitcockpit.io/openitcockpit/openitcockpit-mobile-waf:latest
```
