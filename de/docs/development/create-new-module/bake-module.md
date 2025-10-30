# "Backen" des Moduls

Bevor Sie starten, stellen Sie sicher, dass Sie sich im Ordner `/opt/openitc/frontend` befinden und einen neuen git  Branch für ihre Entwicklung erstellt haben.

![new git branch](/images/prepare-for-new-module.png)

openITCOCKPIT besitzt ein eigenes CLI Tool "`oitc`", welches unter anderem ein neues "skeleton" eines neuen Moduls erstellen kann. Dies ist das sogenannte bake Kommando, welches auf dem CakePHP "[bake](https://book.cakephp.org/5/en/plugins.html#creating-a-plugin-using-bake)" Kommando basiert.

Um ein neues Modul zu erstellen, müssen Sie folgendes Kommando ausführen:
```bash
oitc bake plugin ExampleModule
```

!!! warning "Hinweis"
    Es ist wichtig, dass der Name ihres Moduls auf "Module" endet. Beispiele: Example**Module**, Autoreports**Module**, Mk**Module** und so weiter.

Das System wird Sie nach dem Pfad des Modules (Plugin) fragen.
```
Plugin Directory: /opt/openitc/frontend/plugins/ExampleModule
```
Dies bestätigen Sie bitte mit `y`.

Zudem werden Sie gefragt, ob Sie die `composer.json` Datei überschreiben möchten
```
/opt/openitc/frontend/composer.json
```
**Überschreiben Sie diese Datei nicht!** Überspringen Sie dies mit der Antwort `n`.

Beispiel zum Erstellen eines Moduls mit dem bake Befehl:
```bash
root @ /opt/openitc/frontend - [ExampleModule] # oitc bake plugin ExampleModule
Plugin Name: ExampleModule
Plugin Directory: /opt/openitc/frontend/plugins/ExampleModule
-------------------------------------------------------------------------------
Look okay? (y/n/q)
[y] > y
Generating .gitignore file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/.gitignore
Wrote `/opt/openitc/frontend/plugins/ExampleModule/.gitignore`
Generating README.md file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/README.md
Wrote `/opt/openitc/frontend/plugins/ExampleModule/README.md`
Generating composer.json file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/composer.json
Wrote `/opt/openitc/frontend/plugins/ExampleModule/composer.json`
Generating phpunit.xml.dist file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/phpunit.xml.dist
Wrote `/opt/openitc/frontend/plugins/ExampleModule/phpunit.xml.dist`
Generating src/Controller/AppController.php file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/src/Controller/AppController.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/src/Controller/AppController.php`
Generating src/Plugin.php file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/src/Plugin.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/src/Plugin.php`
Generating tests/bootstrap.php file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/tests/bootstrap.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/tests/bootstrap.php`
Generating webroot/.gitkeep file...

Creating file /opt/openitc/frontend/plugins/ExampleModule/webroot/.gitkeep
Wrote `/opt/openitc/frontend/plugins/ExampleModule/webroot/.gitkeep`
Modifying composer autoloader

File `/opt/openitc/frontend/composer.json` exists
Do you want to overwrite? (y/n/a/q)
[n] > n
Skip `/opt/openitc/frontend/composer.json`

Generating autoload files
Generated autoload files


/opt/openitc/frontend/src/Application.php modified
-------------------------------------------------------------------------------
Created: ExampleModule in /opt/openitc/frontend/plugins/ExampleModule


root @ /opt/openitc/frontend - [ExampleModule] #
```

## Dateiberechtigungen Reparieren

Immer wenn Sie den `oitc` Befehl zum Generieren von Dateien nutzen, ist es empfehlenswert, die Dateiberechtigungen dem
Webserver Benutzer `www-data` zuzuweisen.

openITCOCKPIT bietet ein eigenes Tool zum Setzen dieser Berechtigungen an.

```bash
oitc rights
```

![oitc rights](/images/oitc-rights.png)

## Aufräumen der src/Application.php Datei
Öffnen Sie die Datei `/opt/openitc/frontend/src/Application.php` und löschen Sie folgende Zeile:
```php
$this->addPlugin('ExampleModule');
```

openITCOCKPIT lädt seine Module automatisch. Es ist keine Manuelle aktion oder code notwendig.

## Routing ändern

Standardmäßig nutzt CakePHP einen Bindestrich (-) als CamelCase separator in der URL. Aufgrund historischer Umstände ist
es vonnöten, dass Sie diesen Separator durch einen Unterstrich (_) ersetzen.

Dazu öffnen Sie die Datei `/opt/openitc/frontend/plugins/ExampleModule/src/Plugin.php` und suchen nach dem folgenden Code.
```php
public function routes(RouteBuilder $routes): void
{
    $routes->plugin(
        'ExampleModule',
        ['path' => '/example-module'],
        function (RouteBuilder $builder) {
            // Add custom routes here
 
            $builder->fallbacks();
        }
    );
    parent::routes($routes);
}
```

Nun ändern Sie den Wert des `path` von `example-module` nach `example_module`.

```php
['path' => '/example_module'],
```

## Erstellen und Ausführen der Migrationen

Migrationen sind Dateien, die die Tabellen für die Anwendung in der Datenbank erstellen.

Erstellen der Verzeichnisse für die Migrationen

```bash
mkdir -p plugins/ExampleModule/config/Migrations
mkdir -p plugins/ExampleModule/config/Seeds

oitc rights
```

### Create 'Initial' migration file

```bash
OITC_DEBUG=1 oitc migrations create -p ExampleModule Initial
```

Dieses Kommando erstellt eine Migrationsdatei innerhalb des `/config/Migrations` Verzeichnisses.
Der Dateiname wird mit dem Zeitstempel gepräfixt und sieht folgendermaßen aus `20220928065505_Initial.php`.

``` php
<?php
// Copyright (C) <2015-present>  <it-novum GmbH>
//
// This file is dual licensed
//
// 1.
//     This program is free software: you can redistribute it and/or modify
//     it under the terms of the GNU General Public License as published by
//     the Free Software Foundation, version 3 of the License.
//
//     This program is distributed in the hope that it will be useful,
//     but WITHOUT ANY WARRANTY; without even the implied warranty of
//     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//     GNU General Public License for more details.
//
//     You should have received a copy of the GNU General Public License
//     along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
// 2.
//     If you purchased an openITCOCKPIT Enterprise Edition you can use this file
//     under the terms of the openITCOCKPIT Enterprise Edition license agreement.
//     License agreement and license key will be shipped with the order
//     confirmation.

declare(strict_types=1);

use Migrations\AbstractMigration;

class Initial extends AbstractMigration {

    /**
     * Change Method.
     *
     * More information on this method is available here:
     * https://book.cakephp.org/phinx/0/en/migrations.html#the-change-method
     * @return void
     */
    public function change(): void {
        $table = $this->table('myplugin_settings');
        $table->addColumn('webhook_url', 'string', [
            'default' => '',
            'limit'   => 255,
            'null'    => false,
        ]);
        $table->addColumn('created', 'datetime', [
            'default' => null,
            'null'    => false,
        ]);
        $table->addColumn('modified', 'datetime', [
            'default' => null,
            'null'    => false,
        ]);
        $table->create();
    }
}
```

### Migration ausführen

```bash
oitc migrations migrate -p ExampleModule
```

Wenn das Kommando ausgeführt wurde, sieht man eine neue "myplugin_settings" Tabelle in der Datenbank.
