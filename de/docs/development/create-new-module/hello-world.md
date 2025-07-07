# Hello World
## Hello World - Backend

Die Struktur ihres neuen Moduls sollte aussehen wie in diesem Beispiel:

![modul structure](/images/module-structure.png)

Ein guter Einstiegspunkt wäre die erstellung ihrer ersten Seite mit der ausgabe "Hello World".

### Einen neuen Controller erstellen

CakePHP [Controller](https://book.cakephp.org/4/en/controllers.html) enthalten die gesamte Businesslogik und stellt die
API Endpunkte für das Frontend dar.

In diesem Beispiel erstellen wir den "TestController"

Erstellen Sie die Datei `/opt/openitc/frontend/plugins/ExampleModule/src/Controller/TestController.php` mit folgendem
Inhalt:

```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Controller;
 
 
class TestController extends AppController {
     
}
```

#### Eine neue Action erstellen

[Actions](https://book.cakephp.org/4/en/controllers.html#controller-actions) enthalten die Logik Ihres API endpunktes.

Wir erstellen nun eine Action mit dem namen `index` um die Nachricht `Hello World` auszugeben.

```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Controller;
 
 
class TestController extends AppController {
 
    public function index() {
        if (!$this->isApiRequest()) {
            // The requested URL was: /example_module/test/index.html
            // The controller only sends the HTML template to the client browser / AngularJS
 
            // Pass the variable "message" with the content "Hello World (HTML)" to the view for .html requests
            $this->set('message', 'Hello World (HTML)');
            return;
        }
 
        // This get executed for API requests
        //  The requested URL was: /example_module/test/index.json
 
        // Pass the variable "message" with the content "Hello World" to the view
        $this->set('message', 'Hello World');
 
        // Add the variable "message" to .json output
        $this->viewBuilder()->setOption('serialize', ['message']);
    }
 
}
```

#### Erstellen der View

Die [View](https://book.cakephp.org/4/en/views.html) wird in ihrem Browser gerendert. openITCOCKPIT unterstützt zwei
View Typen:

Die HTML View wird von AngularJS geladen und enthält die Statische HTML Struktur mit Platzhaltern für Informationen der
aktuellen [Action](#eine-neue-action-erstellen).

Die JSON View enthält die Daten für die Platzhalter der aktuellen [Action](#eine-neue-action-erstellen).

##### HTML View erstellen

Erstellen Sie die Datei `/opt/openitc/frontend/plugins/ExampleModule/templates/Test/index.php` mit folgendem Inhalt:

```php
<?php
/**
 * @var \App\View\AppView $this
 * @var string $message
 */
?>
 
<div class="row">
    <div class="col-xl-12">
        <div id="panel-1" class="panel">
            <div class="panel-hdr">
                <h2>
                    <?php echo __('Example Module'); ?>
                    <span class="fw-300"><i><?php echo __('Hello World'); ?></i></span>
                </h2>
            </div>
            <div class="panel-container show">
                <div class="panel-content">
 
                    <!-- Output "Hello World (HTML)" that was set by the controller -->
                    <?= h($message); ?>
 
                </div>
            </div>
        </div>
    </div>
</div>
```

!!! info 
    AngularJS wird das Template einmal laden und dann Cachen. Nutzen Sie kein `<?php foreach($data as $record): ?>`
    um Daten auszugeben.

##### JSON View erstellen

Die JSON View wird automatisch vom CakePHP Framework generiert.

Mehr zu diesem Thema erfahren Sie in
der [CakePHP Dokumentation](https://book.cakephp.org/4/en/views/json-and-xml-views.html).

#### Berechtigungen für "Administrator" Benutzerrolle zuweisen

Standardmäßig wird jeder Zugriff auf die API Actions verweigert. openITCOCKPIT weist dem "Administrator" Benutzer alle
Berechtigungen zu mit der Ausführung des folgenden Kommandos:

```bash
openitcockpit-update --no-system-files
```

Ist ihr aktueller Benutzer kein Teil der "Administrator" Gruppe, müssen Sie
nach `Verwaltung -> Benutzerverwaltung -> Verwalte Benutzerrollen`
Navigieren und die Berechtigungen manuell zuweisen.

![grant permissions](/images/grant-user-role-permissions.png)

#### Action abfragen

Sie sollten nun in der Lage sein, die `.html` und `.json` Actions anzufragen.

Navigieren Sie in ihrem Webbrowser nach `/example_module/test/index.html` um die HTML Action zu bekommen.

![hello world html browser](/images/hello-world-html.png)

Es ist normal, dass an diesem Punkt keinerlei CSS oder Javascript geladen wird.

Via `/example_module/test/index.json` erhalten Sie die JSON repräsentation der Action.

![hello world json browser](/images/hello-world-json.png)

## Hello World - Frontend

### Neuer Menüeintrag

Standardmäßig ist das Menü von openITCOCKPIT in vier Kategorien
unterteilt ([MenuHeadline](https://github.com/openITCOCKPIT/openITCOCKPIT/blob/development/src/itnovum/openITCOCKPIT/Core/Menu/Menu.php#L32-L35)):
Übersicht, Monitoring, Verwaltung und Systemkonfiguration.

Sie können entweder Links in diesen Kategorien, oder aber eigene Kategorien erstellen.

Alle Menüeinträge ihres Moduls werden in der Datei `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/Menu.php`
definiert.

#### Menüeintrag in vorhandener Überschrift

**PHP Code**

```bash
<?php
 
namespace ExampleModule\Lib;
 
 
use itnovum\openITCOCKPIT\Core\Menu\MenuCategory;
use itnovum\openITCOCKPIT\Core\Menu\MenuHeadline;
use itnovum\openITCOCKPIT\Core\Menu\MenuInterface;
use itnovum\openITCOCKPIT\Core\Menu\MenuLink;
 
class Menu implements MenuInterface {
 
    /**
     * @return array
     */
    public function getHeadlines() {
        $Overview = new MenuHeadline(\itnovum\openITCOCKPIT\Core\Menu\Menu::MENU_OVERVIEW);
        $Overview
            //Create a new Sub-Category of the Overview Headline
            ->addCategory((new MenuCategory(
                'ExampleModule',
                __('Example Module'),
                1000,
                'fas fa-burn'
            ))
                //Add new Link to Sub-Category
                ->addLink(new MenuLink(
                    __('Hello world'),
                    'TestIndex', //Name of the NG-State
                    'Test', //Name of the PHP Controller
                    'index', //Name of the PHP action
                    'ExampleModule', //Name of the Module
                    'fas fa-code', //Menu Icon
                    [],
                    1
                ))
            );
 
        return [$Overview];
    }
 
}
```

**Ergebnis**

![new menu entry](/images/new-menu-entry.png)

**PHPStorm**

![new entry phpstorm](/images/new-menu-entry-phpstorm.png)

Danach führen Sie den Befehl aus, um die Anzeige der editierten Views zu aktualisieren.

```bash
openitcockpit-update --no-system-files
```

#### Menüeintrag unter neuer Überschrift

Falls benötigt, können Sie auch eigene Überschriften erstellen.

**PHP Code**

```php
<?php
 
namespace ExampleModule\Lib;
 
 
use itnovum\openITCOCKPIT\Core\Menu\MenuCategory;
use itnovum\openITCOCKPIT\Core\Menu\MenuHeadline;
use itnovum\openITCOCKPIT\Core\Menu\MenuInterface;
use itnovum\openITCOCKPIT\Core\Menu\MenuLink;
 
class Menu implements MenuInterface {
 
    /**
     * @return array
     */
    public function getHeadlines() {
        $ExampleModuleHeadline = new MenuHeadline(
            'ExampleModuleHeadline',
            __('Example Module')
        );
        $ExampleModuleHeadline
            //Create a new Sub-Category of the Overview Headline
            ->addCategory((new MenuCategory(
                'ExampleModule',
                __('Example Module'),
                1000,
                'fas fa-burn'
            ))
                //Add new Link to Sub-Category
                ->addLink(new MenuLink(
                    __('Hello world'),
                    'TestIndex', //Name of the NG-State
                    'Test', //Name of the PHP Controller
                    'index', //Name of the PHP action
                    'ExampleModule', //Name of the Module
                    'fas fa-code', //Menu Icon
                    [],
                    1
                ))
            );
 
        return [$ExampleModuleHeadline];
    }
 
}
```

**Ergebnis**

![](/images/new-menu-headline.png)

**PHPStorm**

![](/images/new-menu-headline-phpstorm.png)

Danach führen Sie den Befehl aus, um die Anzeige der editierten Views zu aktualisieren.

```bash
openitcockpit-update --no-system-files
```

### Neue NG-State / AngularJS Route erstellen

Die Weboberfläche von openITCOCKPIT ist auf dem AngularJS Framework aufgebaut. Jede API Action benötigt einen eigenen
AngularJS State und Controller.

Alle States werden in der Datei `/opt/openitc/frontend/plugins/ExampleModule/webroot/js/scripts/ng.states.js` definiert.

```Javascript
openITCOCKPIT.config(function($stateProvider){
    $stateProvider
        .state('TestIndex', { // Name of the NG-State => Same as in Menu.php
            url: '/example_module/test/index', // URL the browser should display
            templateUrl: '/example_module/test/index.html', // URL of the .html Template for AngularJS
            controller: 'TestIndexController' // Name of the AngularJS Controller. Convention: Controller name + Action Name + 'Controller'
        });
});
```

#### AngularJS Controller erstellen

Jede Action kapselt seine JavaScript logik innerhalb eines AngularJS Controllers. Controller führen immer nur eine
Action aus. **Jede Action benötigt einen eigenen Controller**. Möchten Sie denselben Code in unterschiedlichen
Controllern, erstellen Sie einen [AngularJS Service](https://docs.angularjs.org/guide/services).

Erstellen Sie nun ihren "TestIndexController" unter dem
Verzeichnis: `/opt/openitc/frontend/plugins/ExampleModule/webroot/js/scripts/controllers/Test/TestIndexController.js`.
Konvention: `/opt/openitc/frontend/plugins/ExampleModule/webroot/js/scripts/controllers/<PHPController name>/<Controller Name><Action Name>Controller.js`
.

```Javascript
angular.module('openITCOCKPIT')
    .controller('TestIndexController', function($scope, $http){

        //Name TestIndexController same as in ng.states.js
        //Convention: Controller name + Action Name + 'Controller' = TestIndexController


        console.log('TestIndexController is loaded');

    });
```

Sie können nun auf ihren Menüeintrag klicken und das Ergebnis sehen.

![new module page](/images/new-module-page.png)
