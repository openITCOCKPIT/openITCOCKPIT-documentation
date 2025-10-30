
# Agenten-Übersicht

Cross-Platform-Monitoring-Agent für openITCOCKPIT, geschrieben in Go

## Was ist der openITCOCKPIT Monitoring Agent
Der openITCOCKPIT Monitoring Agent, basierend auf der Programmiersprache Go, ist eine plattformübergreifende Anwendung, um grundlegende Informationen und Metriken zum Betriebssystem, laufenden Diensten, Programmen und Sensoren zu sammeln.

Dazu gehören Nutzungsinformationen wie CPU, Arbeitsspeicher, SWAP oder Festplattennutzung und IO-Informationen über Festplatten und Netzwerk-Schnittstellen.

Standardmäßig ruft das System alle 30 Sekunden neue Werte ab. Da der openITCOCKPIT Monitoring Agent keine historischen Daten bereitstellen muss, sondern nur den aktuellen Status des Systems, werden veraltete Informationen regelmäßig durch neue ersetzt und nicht gespeichert.

Um eigene Prüfungen oder die Ausführung vorhandener Nagios-Plugins zu ermöglichen, kann eine Konfigurationsdatei verwendet werden, um festzulegen, welche Befehle (Befehl oder Pfad zu einer ausführbaren Datei) zu bestimmten Zeitintervallen und mit definierten Zeitüberschreitungen ausgeführt werden sollen. Diese Prüfungen werden als [benutzerdefinierte Prüfungen](/agent/define-customchecks/) bezeichnet.

Mit dieser Methode können vorgefertigte Naemon-, Nagios-, Shinken-, Icinga 1- und Sensu-Plugins einfach in den openITCOCKPIT Monitoring Agent integriert werden.

Der openITCOCKPIT Monitoring Agent ist verfügbar und getestet für Windows (32 und 64 Bit), macOS (Intel und Apple Silicon) sowie die gängigen Linux-Distributionen wie Debian, Ubuntu, Red Hat Linux, CentOS, SLES und openSUSE (amd64 und arm64).

Bitte besuchen Sie die [Release-Seite](https://github.com/openITCOCKPIT/openitcockpit-agent-go/releases), um die neueste oder ältere Versionen herunterzuladen.

## Kommunikationsmethoden
Der openITCOCKPIT Monitoring Agent kann im Pull- oder Push-Modus betrieben werden. Standardmäßig ist die Kommunikation durch TLS verschlüsselt und wird über HTTPS übertragen. Sie müssen keine TLS-Zertifikate manuell erstellen, openITCOCKPIT kümmert sich darum.

### Pull-Modus
Der Pull-Modus ist der empfohlene und am häufigsten verwendete Monitoring-Typ. Im Pull-Modus startet der openITCOCKPIT Monitoring Agent einen Webserver auf Port `3333`. 

Der openITCOCKPIT Monitoring Server fragt alle 60 Sekunden den Agenten ab und verarbeitet alle Prüfergebnisse.

Kommunikationsweg: `openITCOCKPIT Monitoring Server => openITCOCKPIT Monitoring Agent (HTTPS)`

### Push-Modus
Im Push-Modus sendet der openITCOCKPIT Monitoring Agent alle 60 Sekunden die Prüfergebnisse an den openITCOCKPIT Monitoring Server. Der Push-Modus ist besonders nützlich, wenn der openITCOCKPIT Monitoring Server das Zielgerät nicht erreichen kann, z.B. in einer NAT- oder Cloud-basierten Umgebung.

Standardmäßig wird die Verbindung durch HTTPS mit selbstsignierten Zertifikaten gesichert.
Wir empfehlen die Verwendung gültiger Zertifikate, z.B. von [Let’s Encrypt](https://letsencrypt.org/), für diesen Anwendungsfall, aber es ist nicht zwingend erforderlich.

Der eingebaute Webserver des Agenten ist im Push-Modus deaktiviert. Sie können ihn bei Bedarf über die [config.ini](https://github.com/openITCOCKPIT/openitcockpit-agent-go/blob/83ae5bafc4219fcd9e059437a0d25497de0fb268/example/config_example.ini#L165-L168) aktivieren.

Kommunikationsweg: `openITCOCKPIT Monitoring Agent => openITCOCKPIT Monitoring Server (HTTPS)`

## Sicherheitskonzept
Im Gegensatz zu den meisten anderen Tools haben **wir uns entschieden, die Verschlüsselung standardmäßig zu aktivieren**. Alle Agenten sind unabhängig voneinander, sodass Sie für jeden Agenten die perfekte Kommunikations- und Verschlüsselungsmethode wählen können.

### Auto-TLS (Pull-Modus)
Auto-TLS ist der empfohlene Kommunikationstyp für Agenten, die im Pull-Modus laufen. Der openITCOCKPIT Monitoring Server zieht eine Certificate Signing Request (CSR) vom Agenten und signiert ein einzigartiges Zertifikat für den jeweiligen Agenten. Sobald das _Zertifikat-Handshake_ erfolgreich war, wird der openITCOCKPIT Server niemals wieder eine unverschlüsselte Verbindung zum openITCOCKPIT Monitoring Agenten senden.

Zusätzlich wird das Zertifikat für Authentifizierungszwecke verwendet (TLS-Client-Zertifikatauthentifizierung). Nur der openITCOCKPIT Monitoring Server kann die Prüfergebnisse vom openITCOCKPIT Monitoring Server abfragen.

### HTTPS (Pull-Modus)
Wenn Sie Auto-TLS nicht verwenden möchten, können Sie auch eigene Zertifikate für HTTPS bereitstellen. In diesem Fall müssen Sie [Basic Authentication](#basic-authentication) aktivieren, um den Agenten vor unbefugtem Zugriff zu schützen.

### HTTPS (Push-Modus)
Im Push-Modus wird die Kommunikation durch die HTTPS-Konfiguration des openITCOCKPIT Monitoring Servers verschlüsselt. Standardmäßig wird der Agent die Zertifikate nicht überprüfen, um die Verwendung von selbstsignierten Zertifikaten zu ermöglichen. Die Zertifikatsvalidierung kann in der `config.ini` des Agenten aktiviert werden.
```ini
# Aktivieren Sie diese Option, wenn Ihr openITCOCKPIT Server gültige TLS-Zertifikate
# wie von Let's Encrypt verwendet.
verify-server-certificate = False
```
Der eingebaute Webserver des Agenten ist im Push-Modus deaktiviert. Wenn Sie ihn aktivieren, aktivieren Sie [Basic Authentication](#basic-authentication), um den Agenten vor unbefugtem Zugriff zu schützen.

### HTTP (Pull-Modus - nicht empfohlen)
Es ist auch möglich, eine unverschlüsselte Klartext-HTTP-Kommunikation zu verwenden, aber Sie müssen dies explizit selbst aktivieren. Sie können [Basic Authentication](#basic-authentication) aktivieren, um den Agenten vor unbefugtem Zugriff zu schützen.

### Basic Authentication
Die HTTP Basic Authentication kann in der `config.ini` aktiviert werden.
```ini
# Aktivieren Sie die HTTP Basic Authentication
# Deaktiviert, wenn leer
# Beispiel: auth = user:password
auth = user:password
```

### TLS Konfiguration

TLS unterstützt verschiedene Versionen und Verschlüsselungssammlungen (Cipher Suite), von denen nicht alle als sicher gelten.
Um mit möglichst vielen Systemen kompatibel zu sein, ohne die Konfiguration zu kompliziert zu machen, haben wir uns entschieden, drei vorkonfigurierte Sicherheitsstufen einzuführen:

- `lax`
- `intermediate`
- `modern`


Die TLS-Sicherheitsstufe kann in der `config.ini` mit der Direktive `tls-security-level` konfiguriert werden.


!!! info
    Wenn kein `tls-security-level` gesetzt ist, wird der Agent die Einstellung `lax` verwenden.

#### lax
Erzwingt mindestens TLS 1.2, schränkt aber die Verwendung von Verschlüsselungssammlungen nicht ein.
War das Standardverhalten vor openITCOCKPIT Agent Version 3.1.

#### intermediate
Erzwingen Sie mindestens TLS 1.2 und beschränken Sie die Verwendung von Verschlüsselungssammlungen auf:
```
TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256, TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256, TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384, TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305, TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305
```

#### modern
Erzwingt mindestens TLS 1.3 und schränkt die Verwendung von Verschlüsselungssammlungen nicht ein.

## Monitoring starten
Öffnen Sie die openITCOCKPIT-Weboberfläche und navigieren Sie zu `openITCOCKPIT Agent -> Agenten-Assistent` und wählen Sie den Host aus, den Sie überwachen möchten. Folgen Sie dem Assistenten, um Ihr Zielsystem mit dem openITCOCKPIT Monitoring Agent in 5 Schritten zu überwachen. Der Assistent deckt alles ab, von der Auswahl der Kommunikationsmethode über die Installation und Konfiguration des Agenten bis hin zur Service-Erstellung.

Der [openITCOCKPIT Einsteiger-Guide](/beginners/openitcockpit-agent/) deckt alle Schritte im Detail ab.
