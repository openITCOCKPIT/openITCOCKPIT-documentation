# Mobile App <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

!!! info "Geschlossene Beta"
    Die openITCOCKPIT Mobile App für iOS und Android befindet sich derzeit in einer geschlossenen Beta-Phase.
    Zum Zeitpunkt des Lesens ist die App möglicherweise noch nicht im App Store oder im Google Play Store verfügbar.

![openITCOCKPIT iOS App auf einem iPhone 16e](/images/mobile-app/openitcockpit-ios-app.png){ align=center }
*Grafik: openITCOCKPIT iOS App auf einem iPhone 16e*


## Voraussetzungen

- openITCOCKPIT 5.6.1 oder höher
- iOS 17.5 oder höher
- Der openITCOCKPIT-Server muss vom mobilen Endgerät aus erreichbar sein (z. B. über VPN oder eine öffentliche IP-Adresse)
- Ein gültiges HTTPS-Zertifikat ist erforderlich. Selbstsignierte Zertifikate funktionieren in der Regel nicht.


## App herunterladen

- Apple App Store
- Google Play Store

(Links werden hinzugefügt, sobald die App in den Stores verfügbar ist)

## Push-Benachrichtigungen einrichten

Ein großer Vorteil der Mobile App im Vergleich zur webbasierten Variante ist die Möglichkeit, Push-Benachrichtigungen für Alarme zu erhalten.
Um dies zu aktivieren, müssen Sie Ihren openITCOCKPIT-Server so konfigurieren, dass Benachrichtigungen über den **von der AVENDIS GmbH bereitgestellten Push Gateway Service** gesendet werden.
Dieser Service ist für openITCOCKPIT-Nutzer kostenlos.

1. Navigieren Sie zu `Systemkonfiguration -> System -> Push Notification Settings`
2. Setzen Sie die Relay-Adresse auf `https://pushrelay.openitcockpit.io`
3. Setzen Sie den Port auf `443`
4. Klicken Sie auf `Request and test Auth-Key`.

openITCOCKPIT fordert nun einen Authentifizierungsschlüssel beim Push Gateway Service an. Der Push Gateway Service verwendet die übermittelte System-ID,
um Ihren openITCOCKPIT-Server zu identifizieren, und erzeugt einen neuen Authentifizierungsschlüssel für Ihren Server.

Um die Einrichtung abzuschließen, klicken Sie nach der Schlüsselerstellung auf `Konfiguration speichern`.

![Auth-Key anfordern](/images/mobile-app/setup-push-gateway.png)

### Benutzer Kontakten zuweisen

Es ist wichtig, Ihrem openITCOCKPIT-Benutzer einem oder mehreren Kontakten zuzuweisen, um Push-Benachrichtigungen für Alarme zu erhalten.

Navigieren Sie zunächst zu `Monitoring -> Objekte -> Kontakte` und wählen Sie den Kontakt aus, den Sie Ihrem Benutzer zuweisen möchten, oder erstellen Sie einen neuen Kontakt.

Stellen Sie sicher, dass Ihr openITCOCKPIT-Benutzer im Feld `Benutzer` der Kontaktkonfiguration ausgewählt ist.
Aktivieren Sie außerdem die Checkbox `Push-Benachrichtigungen an Browser` für Hosts und Services. Diese Option sendet Benachrichtigungen dann sowohl an die Weboberfläche als auch an die Mobile App.

![Benutzer Kontakten zuweisen](/images/mobile-app/assign-users-to-contacts.png)

Damit die Änderungen wirksam werden, speichern Sie die Kontaktkonfiguration und aktualisieren Sie die Monitoring-Konfiguration.

![Monitoring-Konfiguration aktualisieren](/images/openITCOCKPIT-Refresh-Monitoring-Config.png)

## Mobile App einrichten

Sobald die App auf Ihren mobilen Endgeräten installiert ist, können Sie die App starten und die URL Ihres openITCOCKPIT-Servers eingeben.
Die App verwendet die openITCOCKPIT-API für die Authentifizierung. Daher müssen Sie zuerst [einen API-Schlüssel erstellen](../../development/api/#api-keys).

![Mobile App Login](/images/mobile-app/iphone-login-docs.png)

Der Einfachheit halber können Sie auch den QR-Code aus der openITCOCKPIT-Weboberfläche scannen, um den API-Schlüssel automatisch zu übernehmen.

## Web Application Firewall (WAF) / Reverse Proxy

Für eine zusätzliche Sicherheitsebene stellen wir eine optionale Web Application Firewall (WAF) / Reverse-Proxy-Konfiguration für die openITCOCKPIT Mobile App bereit. Diese Konfiguration basiert auf Nginx und kann verwendet werden, um Ihren openITCOCKPIT-Server vor bösartigen Anfragen zu schützen.

TBD
