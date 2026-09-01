# Mobile App <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

![openITCOCKPIT iOS App auf einem iPhone 16e](/images/mobile-app/openitcockpit-ios-app.png){ align=center }
*Grafik: openITCOCKPIT iOS App auf einem iPhone 16e*


## Voraussetzungen

- openITCOCKPIT 5.6.1 oder höher
- iOS 17.5 oder höher
- Der openITCOCKPIT-Server muss vom mobilen Endgerät aus erreichbar sein (z. B. über VPN oder eine öffentliche IP-Adresse)
- Ein gültiges HTTPS-Zertifikat ist erforderlich. Selbstsignierte Zertifikate funktionieren in der Regel nicht.


## App herunterladen
Die App kann über die jeweiligen App Stores heruntergeladen werden. Bitte beachten Sie, dass die App derzeit nur für iOS verfügbar ist. Die Android-Version wird in Kürze veröffentlicht.

**Die App ist kostenlos und kann mit jedem openITCOCKPIT-Server verwendet werden, unabhängig von der Edition (Community oder Enterprise).**

### iOS
[Apple App Store](https://apps.apple.com/de/app/openitcockpit/id6783364695)

<a href="https://apps.apple.com/de/app/openitcockpit/id6783364695" target="_blank">
  <img src="/images/mobile-app/Download_on_the_App_Store_Badge_US-UK_RGB_blk_092917.svg" alt="Download on the App Store" width="120">
</a>

### Android
Google Play Store (Bald verfügbar)


## Push-Benachrichtigungen einrichten

Ein großer Vorteil der Mobile App im Vergleich zur webbasierten Variante ist die Möglichkeit, Push-Benachrichtigungen für Alarme zu erhalten.
Um dies zu aktivieren, müssen Sie Ihren openITCOCKPIT-Server so konfigurieren, dass Benachrichtigungen über den **von der AVENDIS GmbH bereitgestellten Push Gateway Service** gesendet werden.
Dieser Service ist für openITCOCKPIT-Nutzer kostenlos.

1. Navigieren Sie zu `Systemkonfiguration -> System -> Push Notification Settings`
2. Setzen Sie die Relay-Adresse auf `https://pushrelay.openitcockpit.io`
3. Setzen Sie den Port auf `443`
4. Klicken Sie auf `Request and test Auth-Key`.

openITCOCKPIT fordert nun einen Authentifizierungsschlüssel beim Push Gateway Service an. Der Push Gateway Service verwendet die übermittelte System-ID,
um Ihren openITCOCKPIT-Server zu identifizieren und erzeugt einen neuen Authentifizierungsschlüssel für Ihren Server.

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

Die openITCOCKPIT-App erfordert, dass Ihr Gerät in der Lage ist, direkt eine Verbindung zum openITCOCKPIT-Server herzustellen. Dies kann über eine öffentliche Adresse, einen [Reverse Proxy](/additional/behind-reverse-proxy/) oder eine VPN-Verbindung erfolgen.
Außerdem ist ein gültiges HTTPS-Zertifikat erforderlich. Selbstsignierte Zertifikate funktionieren höchstwahrscheinlich nicht, oder Sie müssen das CA-Zertifikat auf Ihrem mobilen Gerät installiert haben.

![Mobile App Connectivity](/images/mobile-app/app_openitcockpit_connection.png)

## Web Application Firewall (WAF) / Reverse Proxy <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

!!! info "Info"
    Die Web Application Firewall ist **nicht erforderlich**, um die openITCOCKPIT Mobile App zu nutzen. Sie ist eine optionale Erweiterung für Benutzer, die Ihren openITCOCKPIT-Server mit einer zusätzlichen Sicherheitsebene absichern möchten.

Um eine zusätzliche Sicherheitsebene bereitzustellen, bieten wir eine optionale Web Application Firewall (WAF) / Reverse-Proxy-Konfiguration für die openITCOCKPIT Mobile App an. Diese Konfiguration basiert auf Nginx und kann genutzt werden, um Ihren openITCOCKPIT-Server vor bösartigen Anfragen zu schützen.

Die Funktionsweise ist wie folgt: Die openITCOCKPIT App sendet alle Anfragen an die WAF. Diese prüft die Anfrage und leitet sie bei Gültigkeit an den openITCOCKPIT-Server weiter.
Wird eine Anfrage von der WAF blockiert, wird eine Antwort mit **406 Not Acceptable** zurückgegeben.

Die WAF hostet zudem die Web-App-Version der openITCOCKPIT App, die über einen Webbrowser aufgerufen werden kann. Das ist besonders hilfreich für Benutzer, die die openITCOCKPIT Mobile Website von einem Desktop-Computer aus nutzen möchten oder die openITCOCKPIT App nicht auf ihrem mobilen Endgerät installieren wollen.

![WAF Firewall](/images/mobile-app/WAF-Firewall.drawio.png)

### Installation

Die WAF ist für den Betrieb in einem Docker-Container ausgelegt. Daher stellen wir vorgefertigte Docker-Images für die Architekturen `amd64` und `arm64` bereit.

### Authentifizierung und Download des Images
Bevor Sie das Docker-Image herunterladen können, müssen Sie sich an unserer Docker Registry authentifizieren:

```bash
docker login https://cr.openitcockpit.io
```

Der Befehl fordert Sie zur Eingabe eines Benutzernamens und eines Passworts auf.
Als Benutzername geben Sie bitte die E-Mail-Adresse an, die mit Ihrem openITCOCKPIT Enterprise-Lizenzschlüssel verknüpft ist. Als
Passwort geben Sie bitte Ihren Lizenzschlüssel ein.

Nach erfolgreicher Authentifizierung können Sie das Docker-Image herunterladen:

```bash
docker pull cr.openitcockpit.io/openitcockpit-mobile-waf:latest
```

### Docker-Container starten

- **OITC_SERVER** muss auf den Hostnamen (z. B. `demo.openitcockpit.io`) oder die IP-Adresse (`192.168.56.2`) Ihres openITCOCKPIT-Servers gesetzt werden. Die WAF leitet alle Anfragen an diesen Server weiter.
- **SSL_CERT_PATH** und **SSL_CERT_KEY_PATH** müssen auf den Pfad Ihres SSL-Zertifikats und Schlüssels **innerhalb des Containers** gesetzt werden. Sie können ein Verzeichnis vom Host in den Container einbinden, um Zertifikat und Schlüssel bereitzustellen.

Sie können den Container mit folgendem Befehl starten:

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
cr.openitcockpit.io/openitcockpit-mobile-waf:latest
```

Die WAF unterstützt ausschließlich HTTPS-Verbindungen. Daher müssen Sie ein gültiges SSL-Zertifikat und den passenden Schlüssel bereitstellen. Für Testzwecke können Sie ein selbstsigniertes Zertifikat verwenden, für Produktivumgebungen empfehlen wir jedoch ein gültiges Zertifikat von einer vertrauenswürdigen CA.

### Konfigurationsoptionen

Die Konfiguration der WAF erfolgt über Umgebungsvariablen. Folgende Optionen stehen zur Verfügung:

| Umgebungsvariable | Beschreibung | Zulässige Werte | Standardwert |
|-------------------|--------------|-----------------|-------------|
| `WEB_APP_ENABLED` | Web App aktivieren oder deaktivieren | `0` oder `1` | `1` |
| `OITC_SERVER` | URL des openITCOCKPIT-Servers | IP-Adresse oder Hostname | `192.168.56.2` |
| `DNS_RESOLVER` | Von Nginx verwendeter DNS-Resolver | IP-Adresse | `9.9.9.9 8.8.8.8` |
| `SSL_CERT_PATH` | Pfad zum SSL-Zertifikat | Dateipfad | `/etc/nginx/certs/fullchain.pem` |
| `SSL_CERT_KEY_PATH` | Pfad zum SSL-Zertifikatsschlüssel | Dateipfad | `/etc/nginx/certs/privkey.pem` |
| `SSL_PROTOCOLS` | Zu verwendende SSL-Protokolle | Nginx-kompatible Liste von SSL-Protokollen | `TLSv1.2 TLSv1.3` |
| `SSL_CIPHERS` | Unterstützte SSL-Chiffren | Nginx-kompatible Liste unterstützter SSL-Chiffren | `ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305` |
| `SSL_PREFER_SERVER_CIPHERS` | Bevorzugung von Server-Chiffren gegenüber Client-Chiffren aktivieren oder deaktivieren | `on` oder `off` | `on` |
| `LOGIN_BACKGROUND_IMAGE` | Hintergrundbild für die Anmeldeseite | Dateiname | `(empty string)` [Siehe Abschnitt Benutzerdefinierte Bilder](#benutzerdefiniertes-logo-und-hintergrundbild)  |
| `LOGIN_LOGO_IMAGE` | Logo für die Anmeldeseite | Dateiname | `(empty string)` |

### Web App

Die WAF prüft bei eingehenden Anfragen an `/`, ob der `Accept`-Header `text/html` oder `application/xhtml+xml` enthält und leitet die Anfrage dann zur Web App unter `/app/` weiter.
Falls diese Weiterleitung nicht funktioniert, sendet Ihr Browser wahrscheinlich einen anderen `Accept`-Header. In diesem Fall rufen Sie bitte direkt `/app/` auf, um auf die Web App zuzugreifen.

![openITCOCKPIT Mobile Web App in einem Webbrowser](/images/mobile-app/waf_desktop_example.png)

### HTTP 406 Not Acceptable

Wenn die WAF eine Anfrage blockiert, sendet sie als Antwort den HTTP-Statuscode **406 Not Acceptable** zurück. Dies kann passieren, im Regelwerk der WAF eine Route oder eine Request-Methode blockiert ist. In der openITCOCKPIT App wird in diesem Fal eine Fehlermeldung angezeigt.

![Anfrage wurde durch die WAF blockiert](/images/mobile-app/waf_blocked_request.png)

### WAF hinter einem Reverse Proxy

Die WAF selbst kann ebenfalls hinter einem Reverse Proxy betrieben werden. Das ist sinnvoll, wenn Sie innerhalb des WAF-Containers selbstsignierte Zertifikate verwenden möchten, nach außen hin jedoch ein gültiges Zertifikat einsetzen wollen. In diesem Fall übernimmt der Reverse Proxy die SSL-Terminierung und leitet die Anfragen per HTTPS an die WAF weiter.

```
Mobiles Endgerät --> Reverse Proxy (gültiges SSL-Zertifikat) --> WAF (selbstsigniertes SSL-Zertifikat) --> openITCOCKPIT-Server
```

#### Apache2-Beispiel

Dieses Beispiel zeigt, wie ein Apache2-Reverse-Proxy vor der WAF konfiguriert werden kann. Der Reverse Proxy übernimmt die SSL-Terminierung und leitet die Anfragen per HTTPS an die WAF weiter.
In diesem Beispiel läuft die WAF auf demselben Server wie der Reverse Proxy unter `127.0.0.1:5555` und der Reverse Proxy lauscht auf `waf.example.org`.

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

Für das oben gezeigte Apache2-Beispiel wurde die WAF mit den folgenden Befehlen gestartet:

```sh
# Selbstsigniertes Zertifikat für die WAF erstellen.
apt-get install ssl-cert
mkdir -p /root/openitcockpit-waf/certs
cp /etc/ssl/certs/ssl-cert-snakeoil.pem /root/openitcockpit-waf/certs/
cp /etc/ssl/private/ssl-cert-snakeoil.key /root/openitcockpit-waf/certs/

# WAF-Container mit dem selbstsignierten Zertifikat starten, hörend auf Port 5555.
# Der Apache2-Reverse-Proxy übernimmt die SSL-Terminierung und leitet die Anfragen per HTTPS an die WAF weiter.
docker run --rm -it \
--name openitcockpit-mobile-waf \
-p 5554:80 \
-p 5555:443 \
-e WEB_APP_ENABLED=1 \
-e OITC_SERVER=demo.openitcockpit.io \
-e SSL_CERT_PATH=/etc/nginx/certs/ssl-cert-snakeoil.pem \
-e SSL_CERT_KEY_PATH=/etc/nginx/certs/ssl-cert-snakeoil.key \
-v /root/openitcockpit-waf/certs:/etc/nginx/certs:ro \
cr.openitcockpit.io/openitcockpit-mobile-waf:latest
```

## Microsoft Entra ID

Es ist möglich, Microsoft Entra ID zu verwenden, um Ihren openITCOCKPIT-Server oder die WAF vor unbefugtem Zugriff zu schützen. Wenn Microsoft Entra ID aktiviert ist, benötigen Benutzer einen **openITCOCKPIT API-Schlüssel** und ein **Microsoft Entra Konto**, um auf die openITCOCKPIT-App oder die Web App zuzugreifen. Die Microsoft Entra ID Anmeldeseite wird vor der openITCOCKPIT-Anmeldeseite angezeigt.

Um Microsoft Entra ID zu aktivieren, müssen Sie zuerst eine Anwendung im Microsoft Entra Portal erstellen. Aktivieren Sie in der openITCOCKPIT-App die Option `Enable Microsoft Entra ID` und füllen Sie die Felder `Tenant ID` und `Client ID` (auch bekannt als `Application ID`) mit den Werten aus dem Microsoft Entra Portal aus.

Die Anmeldeschaltfläche ändert sich dann zu `Sign in with Microsoft` und der Benutzer wird zur Microsoft Entra Anmeldeseite weitergeleitet.

![openITCOCKPIT-App mit Microsoft Entra Anmeldung](/images/mobile-app/openitcockpit-app-enable-microsoft-entra.png)

### Microsoft Entra ID einrichten

Navigieren Sie im Microsoft Entra Portal zu `App registrations` und klicken Sie auf `New registration`. Dies ist ein erforderlicher Schritt, um die `Tenant ID` und `Client ID` für die openITCOCKPIT-App zu erhalten.

![Microsoft Entra App-Registrierung](/images/mobile-app/microsoft-entra-app-registration.png)

Stellen Sie bitte sicher, dass die `Redirect URI` für `Mobile and desktop applications` auf den folgenden Wert gesetzt ist:

```text
openitcockpit://auth-callback
```

**Ändern Sie die `Redirect URL` nicht. Sie muss exakt wie oben angegeben sein, sonst funktioniert die Microsoft Entra Anmeldung in der openITCOCKPIT-App nicht.**

![Microsoft Entra - Redirect URI konfigurieren](/images/mobile-app/microsoft-entra-redirect-url.png)


!!! info
    Die `Tenant ID` und `Client ID` (auch bekannt als `Application ID`) **sind keine Geheimnisse** und können mit jedem geteilt werden.

    - **Tenant ID**: Diese identifiziert einfach Ihre konkrete Organisation bzw. Ihre Microsoft Entra Verzeichnisinstanz.
    - **Application ID**: Diese identifiziert eine bestimmte Anwendung innerhalb des Verzeichnisses des Tenants. Sie teilt Microsoft mit, welche App eine Anmeldung anfordert.

## Mobile Device Management (MDM)

Die openITCOCKPIT-App kann über Mobile Device Management (MDM) Lösungen wie _Microsoft Intune_ konfiguriert werden. Dadurch können Sie die App für Ihre Benutzer vorkonfigurieren und bestimmte Einstellungen erzwingen, z. B. die Serveradresse oder Microsoft Entra ID-Anmeldedaten. Der Einrichtungsprozess hängt von der verwendeten MDM-Lösung ab.

Diese Dokumentation verwendet _Microsoft Intune_ als Referenz, der Ablauf sollte jedoch bei anderen MDM-Lösungen ähnlich sein.

### iOS

Die Konfiguration wird über ein XML-basiertes Profil gesteuert. Alle Felder sind optional. Falls Sie ein Feld nicht konfigurieren möchten, lassen Sie es leer, z. B. `<string></string>`.

```XML
<dict>
    <key>apiKey</key>
    <string>API_KEY_OR_EMPTY_STRING</string>
    
    <key>serverAddress</key>
    <string>https://your.openitcockpit.server</string>
    
    <key>enableMicrosoftEntraID</key>
    <true/>
    
    <key>microsoftTenantId</key>
    <string>ae3ff2c9-56df-4e36-98bd-37f9f52f3185</string>
    
    <key>microsoftClientId</key>
    <string>ad785d3e-6bd7e-4e30-b16a-e18dc85edb09</string>

    <key>hideMicrosoftEntraConfig</key>
    <false/>
</dict>
```

!!! note
    Einstellungen, die über das MDM gesteuert werden, können vom Benutzer in der App nicht geändert werden. Wenn beispielsweise `serverAddress` per MDM gesetzt ist, kann der Benutzer diesen Wert in der App nicht ändern.


Für _Microsoft Intune_ müssen Sie zuerst eine neue iOS-/iPadOS-App erstellen.
![Microsoft Intune - Neue iOS/iPadOS-App erstellen](/images/mobile-app/microsoft-intune-ios-app.png)
Diese App ist dann für Ihre Benutzer über das _Microsoft Intune Unternehmensportal_ verfügbar.

Im nächsten Schritt können Sie die App mit der obigen XML-Konfiguration konfigurieren. Stellen Sie sicher, dass Sie die Option `Managed configuration` auswählen und die XML-Konfiguration in das Textfeld einfügen.
![Microsoft Intune - Verwaltete Konfiguration](/images/mobile-app/microsoft-intune-ios-app-config.png)

Sobald die App auf dem Gerät des Benutzers installiert ist, wird die Konfiguration automatisch angewendet. Alle vom MDM gesteuerten Felder werden gesperrt und können vom Benutzer nicht geändert werden.
Wenn ein Profil aktiv ist, sieht der Benutzer die Meldung `Some settings are managed by your organization`.

![openITCOCKPIT-App - MDM-Beispiel](/images/mobile-app/ios-mdm-example.png)

!!! danger
    **Bevor** Sie die App Konfiguration im MDM **löschen**, müssen Sie eine leere Konfiguration mit den gleichen Feldern auf die Geräte der Benutzer pushen.
    Anderenfalls werden die vom MDM gesteuerten Felder in der App gesperrt und **können nicht mehr geändert werden**.
    
    Dies ist eine bekannte Einschränkung von iOS/iPadOS und hat nichts mit der openITCOCKPIT-App zu tun.
    ```XML
    <dict>
      <key>apiKey</key>
      <string></string>

      <key>serverAddress</key>
      <string></string>

      <key>enableMicrosoftEntraID</key>
      <false/>

      <key>microsoftTenantId</key>
      <string></string>

      <key>microsoftClientId</key>
      <string></string>

      <key>hideMicrosoftEntraConfig</key>
      <false/>
    </dict>
    ```
    Erst **nachdem** die leere Konfiguration auf **alle Geräte der Benutzer gepusht wurde**, können Sie die App-Konfiguration im MDM löschen.

## Konfiguration per QR-Code

Dies ist eine alternative Möglichkeit zur Konfiguration der openITCOCKPIT-App für Benutzer, die keine Mobile Device Management im Einsatz haben. Anstatt die Serveradresse oder Microsoft Entra ID-Anmeldedaten manuell einzugeben, kann der Benutzer einen QR-Code scannen, um die App automatisch zu konfigurieren.

!!! info
    Der einfachste Weg zur Erstellung des QR-Codes ist die Nutzung unseres [QR Code Generators](https://openitcockpit.io/app_qr_generator/) auf unserer Website.


Falls Sie den QR-Code manuell erzeugen möchten, verwenden Sie bitte die folgende JSON-Struktur:

```JSON
{
   "serverAddress":"https://your.openitcockpit.server",
   "apiKey":"<API_KEY_OR_EMPTY_STRING>",
   "remember_me":true,
   "enable_microsoft_entra_id":false,
   "microsoft_tenant_id":"ae3ff2c9_OR_EMPTY_STRING",
   "microsoft_client_id":"ad785d3e_OR_EMPTY_STRING"
}
```
Sie können jeden QR-Code-Generator verwenden, um den QR-Code aus der obigen JSON-Struktur zu erstellen. Das Feld `serverAddress` muss auf die URL Ihres openITCOCKPIT-Servers gesetzt werden. `microsoft_tenant_id` und `microsoft_client_id` sind optional und nur relevant, wenn `enable_microsoft_entra_id` auf `true` gesetzt ist.

Wenn Sie Microsoft Entra ID nicht verwenden möchten, setzen Sie `enable_microsoft_entra_id` auf `false` und lassen Sie die anderen beiden Felder leer.

Das Feld `apiKey` kann ebenfalls leer bleiben, da der Benutzer seinen persönlichen API-Schlüssel nach dem Scannen des QR-Codes mit der App-Konfiguration eingeben kann.

Der Ablauf sieht wie folgt aus:

1. Der Benutzer scannt den QR-Code, der die Konfiguration für die openITCOCKPIT-App enthält.
2. Der Benutzer scannt seinen persönlichen QR-Code, der den API-Schlüssel des Benutzers enthält.
3. Auf "Login" tippen, um sich in der openITCOCKPIT-App anzumelden.

![openITCOCKPIT-App QR-Code-Scanner](/images/mobile-app/openitcockpit-qr-code-scanner.png){ width=350px }

## Benutzerdefiniertes Logo und Hintergrundbild

Das Logo auf dem Anmeldebildschirm und das Hintergrundbild können angepasst werden. Die Bilder werden im WAF-Container gespeichert und müssen nach `/usr/share/nginx/html/custom_images` gemountet werden. Es werden nur **PNG**- und **JPG**-Bilder unterstützt. Die Dateinamen der Bilder müssen über die Umgebungsvariablen `LOGIN_LOGO_IMAGE` und `LOGIN_BACKGROUND_IMAGE` gesetzt werden. Bitte stellen Sie sicher, dass in den Dateinamen keine Sonderzeichen oder Leerzeichen verwendet werden. Beispiel: `LOGIN_BACKGROUND_IMAGE="sunflowers-background.jpg"`.

![Beispiel für benutzerdefinierten Hintergrund und Logo](/images/mobile-app/web-custom-background-and-logo.png)

Leider ist das Laden benutzerdefinierter Bilder in der nativen openITCOCKPIT-App nur möglich, wenn die `serverAddress` per MDM gesetzt wird. Das liegt daran, dass die App die benutzerdefinierten Bilder von einer spezifischen URL laden muss, was nur möglich ist, wenn die Serveradresse bekannt ist. Wenn die Serveradresse per QR-Code oder manuell gesetzt wird, kann die App die benutzerdefinierten Bilder nicht vorab laden.

Wenn jedoch ein MDM zum Setzen der Serveradresse verwendet wird, lädt die App die benutzerdefinierten Bilder automatisch von der WAF.


![iOS MDM benutzerdefinierte Bilder](/images/mobile-app/ios-mdm-custom-images.png){ width=350px }

Beispiel für einen Docker-`run`-Befehl mit benutzerdefinierten Bildern:
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
-v /path/on/host/custom_images:/usr/share/nginx/html/custom_images:ro \
-e LOGIN_BACKGROUND_IMAGE="sunflowers-background.jpg" \
-e LOGIN_LOGO_IMAGE="cat-logo.png" \
cr.openitcockpit.io/openitcockpit-mobile-waf:latest
```

## Debug-Menü

Die openITCOCKPIT-App besitzt ein verstecktes Debug-Menü auf dem Anmeldebildschirm, das durch 5-maliges Tippen auf das openITCOCKPIT-Logo innerhalb von 1,5 Sekunden geöffnet werden kann.
Im Debug-Menü können Sie den App-Speicher leeren und bekommen die installierte App-Version angezeigt.

![openITCOCKPIT-App Debug-Menue](/images/mobile-app/openitcockpit-app-debug.png){ width=350px }


