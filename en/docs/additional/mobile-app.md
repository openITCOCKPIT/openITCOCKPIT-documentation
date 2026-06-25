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

## Web Application Firewall (WAF) / Reverse Proxy

For adding an extra layer of security, we provide an optional Web Application Firewall (WAF) / Reverse Proxy configuration for the openITCOCKPIT Mobile App. This configuration is based on Nginx and can be used to protect your openITCOCKPIT server from malicious requests.

TBD
