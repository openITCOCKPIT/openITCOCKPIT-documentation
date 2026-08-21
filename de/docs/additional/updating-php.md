# PHP aktualisieren (nur EL)

!!! danger "Nur für Enterprise-Linux-Benutzer"
    Diese Dokumentation beschreibt den Aktualisierungsprozess der verwendeten PHP-Version. Diese Dokumentation ist **nur für Benutzer von Enterprise-Linux-Distributionen** relevant (RHEL, AlmaLinux, Rocky Linux, Oracle Linux).
    Debian und Ubuntu haben eine aktuelle PHP-Version in ihren Repositories. Das Aktualisieren der PHP-Version auf **Debian oder Ubuntu wird nicht unterstützt** und in dieser Dokumentation nicht behandelt.


## Unterstützte Distributionen

Diese Dokumentation behandelt die folgenden Enterprise-Linux-Versionen:

- RHEL 8
- RHEL 9
- RHEL 10

### Sie verwenden Debian oder Ubuntu?
Wenn Sie Debian oder Ubuntu verwenden, müssen Sie auf die nächste Hauptversion Ihrer Distribution aktualisieren, um eine unterstützte PHP-Version zu erhalten.
Folgen Sie dazu bitte unserer [Upgrade-Dokumentation](/update/ubuntu-jammy-to-noble/). **Das Ändern der PHP-Version über Drittanbieter-Repositories wird nicht unterstützt und führt zu einem fehlerhaften System.**

## Welche PHP-Version verwendet mein System?

Um zu sehen, welche PHP-Version aktuell auf Ihrem System installiert ist, navigieren Sie zu `System tools` → `Debugging`.
openITCOCKPIT zeigt die aktuelle PHP-Version im Bereich `Server information` an.

openITCOCKPIT zeigt außerdem eine Warnung an, wenn die PHP-Version zu alt ist und aktualisiert werden muss.

![PHP version and warning](/images/php/openitcockpit-current-php-version.png)

Sie sollten außerdem sicherstellen, dass die openITCOCKPIT-Oberfläche und die CLI dieselbe PHP-Version verwenden. Sie können dies mit folgendem Befehl prüfen:

```bash
php -v
```

Es sollte dieselbe Version wie in der openITCOCKPIT-Oberfläche angezeigt werden. Zum Beispiel:
```bash
[root@oitc-rhel8 ~]# php -v
PHP 8.1.34 (cli) (built: May  7 2026 07:54:01) (NTS gcc x86_64)
Copyright (c) The PHP Group
Zend Engine v4.1.34, Copyright (c) Zend Technologies
    with Zend OPcache v8.1.34, Copyright (c), by Zend Technologies
```

## Warum die Aktualisierung von PHP wichtig ist

openITCOCKPIT benötigt eine Mindestversion von PHP aus Gründen der Kompatibilität und Sicherheit. Der Betrieb mit einer veralteten PHP-Version kann zu unerwartetem Verhalten, Sicherheitslücken und fehlender Unterstützung für neue Funktionen führen.
Das PHP-Team stellt auf der [Seite zu unterstützten Versionen](https://www.php.net/supported-versions.php) einen Überblick über aktuell unterstützte PHP-Versionen bereit.


## PHP aktualisieren

openITCOCKPIT **erfordert** PHP in Version 8.3 oder neuer.

Aufgrund der Komplexität des Supports bei Enterprise-Linux-Systemen ist nur die [openITCOCKPIT Enterprise Edition](https://openitcockpit.io/editions/) für
Red Hat Enterprise Linux und RHEL-basierte Distributionen wie Rocky Linux, AlmaLinux oder Oracle Linux verfügbar.

Bitte nehmen Sie [Kontakt mit uns auf](https://avendis.com/kontakt/), wenn Sie Unterstützung bei der Aktualisierung Ihrer openITCOCKPIT-Installation benötigen.


Bevor Sie starten, stellen Sie sicher, dass Sie die neuesten Updates für Ihr System installiert haben:
```bash
dnf --refresh check-update

dnf update
```

Dieses Dokument setzt voraus, dass Sie PHP aus [Remis RPM-Repository](https://rpms.remirepo.net/) installiert haben.

Um Ihre PHP-Version zu aktualisieren, führen Sie bitte den folgenden Befehl aus:

```
dnf module switch-to php:remi-8.3
```

Dadurch wird Ihr System auf die neueste Version von PHP 8.3 umgestellt.


!!! warning "Wichtig"
    Wenn Sie eine openITCOCKPIT-Version älter als **5.7.0** verwenden, müssen Sie die folgenden Verzeichnisse und symbolischen Links manuell erstellen. Spätere Versionen von openITCOCKPIT erstellen diese Verzeichnisse und symbolischen Links automatisch.
    ```bash
    mkdir -p "/etc/php/8.3/fpm"
    ln -s /etc/php-fpm.conf "/etc/php/8.3/fpm/php-fpm.conf"
    ln -s /etc/php.d "/etc/php/8.3/fpm/conf.d"
    ln -s /etc/php-fpm.d "/etc/php/8.3/fpm/pool.d"
    ```

Um das Upgrade abzuschließen, führen Sie bitte den folgenden Befehl aus:

```bash
openitcockpit-update
```

Es wird außerdem empfohlen, das System neu zu starten.

```bash
reboot
```

### PHP-Version überprüfen

Nachdem das System neu gestartet wurde, können Sie die PHP-Version überprüfen, indem Sie in der openITCOCKPIT-Oberfläche zu `System tools` → `Debugging` navigieren. Die aktuelle PHP-Version sollte nun als 8.3 oder neuer angezeigt werden.

![PHP version after update](/images/php/openitcockpit-php-version-update.png)

Bitte prüfen Sie außerdem, dass die openITCOCKPIT-Oberfläche und die CLI dieselbe PHP-Version verwenden.

```bash
[root@oitc-rhel8 ~]# php -v
PHP 8.3.33 (cli) (built: Jul 28 2026 17:56:10) (NTS gcc x86_64)
Copyright (c) The PHP Group
Zend Engine v4.3.33, Copyright (c) Zend Technologies
    with Zend OPcache v8.3.33, Copyright (c), by Zend Technologies
```
