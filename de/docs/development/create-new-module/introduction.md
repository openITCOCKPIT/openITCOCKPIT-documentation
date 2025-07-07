# Ein neues openITCOCKPIT Modul erstellen

Für diesen Artikel benötigen Sie eine openITCOCKPIT Entwicklungsumgebung. Lesen Sie [diesen Guide um sich eine
openITCOCKPIT Entwicklungsumgebung zu erstellen](../../setup-dev-env/#openitcockpit-entwicklungsumgebung-erstellen)

Dieser Artikel enthält die Best-Practices, um neue Features in openITCOCKPIT über ein eigenes Modul hinzuzufügen.
Die Entwicklung eines eigenen Moduls stellt sicher, dass ihr System durch unsere Experten aktualisierbar sowie wartbar 
bleibt.

## Einstieg in die Entwicklung

Das Backend von openITCOCKPIT ist in PHP geschrieben und nutzt das Framework [CakePHP 4](https://book.cakephp.org/4/en/index.html).

Das Frontend basiert auf einem [Angular](https://angular.dev/) und [CoreUI](https://coreui.io) Stack.

Als IDE empfehlen wir [JetBrains PHPStorm](https://www.jetbrains.com/phpstorm/) und [Mozilla Firefox](https://www.mozilla.org/en-US/firefox/new/) als Browser.


Der Beispielcode ist auf GitHub verfügbar: <https://github.com/openITCOCKPIT/openITCOCKPIT-ExampleModule>

### Voraussetzungen

Dieses Dokument beschreibt ausschließlich die Entwicklung von Modulen für openITCOCKPIT.

Es wird vorausgesetzt, dass Sie erfahrung mit CakePHP und AngularJS besitzen.

### Arbeitsverzeichnis
Das Arbeitsverzeichnis von openITCOCKPIT ist `/opt/openitc/frontend`.

Stellen Sie sicher, dass Sie sich in diesem Ordner befinden bevor Sie starten.

Es wird zudem empfohlen, git zu nutzen, um ihre änderungen nachzuverfolgen.

## Debug Modus aktivieren

!!! danger "Wichtig"
    Seien Sie sich im Klaren darüber, dass das Aktivieren des debug Modus zu Datenlecks und dem verlust von sensitiven
    Informationen führen kann.

Standardmäßig läuft openITCOCKPIT im Production Modus. Um Fehlermeldungen angezeigt zu bekommen und unkomprimiertes
(nicht minified) JavaScript zu erhalten, müssen Sie den Debug Modus aktivieren.

Dazu öffnen Sie die Datei `/etc/nginx/openitc/master.conf` und setzen den Parameter `OITC_DEBUG` von `0` auf `1`.

```
fastcgi_param OITC_DEBUG 1;
```

Damit ihre änderungen aktiv werden, müssen Sie folgenden Befehl ausführen:

```bash
openitcockpit-update --no-system-files
```

!!! danger "Wichtig"
    Nochmal: Seien Sie sich im Klaren darüber, dass das Aktivieren des debug Modus zu Datenlecks und dem verlust von sensitiven
    Informationen führen kann.

### Debug Modus deaktivieren
Um den Debug Modus in openITCOCKPIT zu deaktivieren, müssen Sie folgenden Befehl ausführen:

```bash
openitcockpit-update
```
