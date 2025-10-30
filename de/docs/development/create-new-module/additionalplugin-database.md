# Additionalplugin_database

## Core Tabellen mit Plugin tabellen verlinken
In manchen Fällen wird ein link zu einem openITCOCKPIT core Tabellenobjekt von einem Tabellenobjekt eines Moduls benötigt.

In diesem Beispiel möchten wir die "additional notes" aus der Modul Tabelle löschen, sobald der zugehörige Host gelöscht
wird. Um dies zu Implementieren müssen wir keinerlei core Code anpassen.

!!! warning
    Es können ausschließlich core Tabellen, die den `PluginManagerTableTrait` nutzen von Modulen erweitert werden

```php
class HostsTable extends Table {
use PluginManagerTableTrait;
}
```
Sollten Sie eine core Tabelle erweitern, welche nicht bereits den `PluginManagerTableTrait` nutzt, zögern Sie nicht
und senden Sie uns einen Pull Request.

### config/associations.php
Erstellen Sie die Datei `/opt/openitc/frontend/plugins/ExampleModule/config/associations.php` um eine liste von core
Tabellen zu definieren, welche mit ihren Plugin-Tabellen assoziiert werden, sollen.

```php
<?php
return [
    'Hosts' => [ //Core Table
        'ExampleModule.ExampleNotes' //Plugin Tables
    ]
];
```

### Definieren der Table::bindCoreAssociations Methode
Nun müssen Sie die `bindCoreAssociations()` Methode in ihrer Plugin-table Klasse erstellen.

Innerhalb dieser Methode können Sie Tabellen associations definieren, die normalerweise in der core `HostsTable` Klasse
definiert worden wären.

`opt/openitc/frontend/plugins/ExampleModule/src/Model/Table/ExampleNotesTable.php`

```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Model\Table;
 
use App\Model\Table\HostsTable;
use Cake\Datasource\RepositoryInterface;
use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use Cake\ORM\Table;
use Cake\Validation\Validator;
 
class ExampleNotesTable extends Table {
    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
    public function initialize(array $config): void {
        parent::initialize($config);
 
        $this->setTable('example_notes');
        $this->setDisplayField('id');
        $this->setPrimaryKey('id');
 
        $this->belongsTo('Hosts', [
            'foreignKey' => 'host_id',
            'joinType'   => 'INNER',
            'className'  => 'Hosts',
        ]);
    }
 
 
    public function bindCoreAssociations(RepositoryInterface $coreTable) {
 
        // Link the Core HostsTable with the Plugin table without modifying core code.       
 
        switch ($coreTable->getAlias()) {
            case 'Hosts':
                $coreTable->hasOne('ExampleNote', [ //Singular => hasOne!
                    'className' => 'ExampleModule.ExampleNotes',
                    'dependent' => true
                ]);
                break;
        }
    }
}
```

### Association testen

**Code**
```php
//Query core Hosts Table to test Plugin associations
/** @var HostsTable $HostsTable */
$HostsTable = TableRegistry::getTableLocator()->get('Hosts');
$hosts = $HostsTable->find()
    ->select([
        'Hosts.id',
        'Hosts.name',
        'Hosts.uuid'
    ])
    ->contain([
        'ExampleNote' => function(Query $query){
        $query->select([
            'id',
            'host_id',
            'notes'
        ]);
            return $query;
        }
        //'ExampleNote' //Singular => hasOne!
    ])
    ->all();
```


**Ergebnis**
![json result with hosts 2](/images/json-result-with-hosts-2.png)

## AclDependencies
Standardmäßig wird jede einzelne Controller Action eine neue Benutzerberechtigung erzeugen.

![user permissions example](/images/user-permission-example.png)

Manche Actions hängen jedoch möglicherweise von anderen Actions ab und können die gesamte Applikation beeinträchtigen,
falls ein Benutzer eine bestimmte berechtigung deaktiviert.

Um dies zu verhindern, können Sie bei Bedarf "ACL Dependencies" definieren.

AclDependencies werden in der Datei `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/AclDependencies.php` definiert.
```php
<?php
namespace ExampleModule\Lib;
 
 
use App\Lib\PluginAclDependencies;
 
class AclDependencies extends PluginAclDependencies {
 
    public function __construct() {
        parent::__construct();
 
        // Add actions that should always be allowed.
        $this
            //      Controller name, Action mame
            ->allow('Test', 'foobar');
 
        ///////////////////////////////
        //    Add dependencies       //
        //////////////////////////////
 
        $this
            //           Controller name, Action name, depends on: Controller name, Action name
            ->dependency('Test', 'foo', 'Test', 'bar');
    }
}
```

Actions die als "always allowed" markiert oder als "dependency" gesetzt wurden, können nicht mehr durch den Benutzer
ausgewählt werden.

Diese werden durch das System automatisch gesetzt.

Wann immer Sie änderungen in den `AclDependencies` vorgenommen haben, müssen Sie anschließend folgenden Befehl ausführen
```bash
openitcockpit-update --no-system-files
```

## AdditionalLinks

`AdditionalLinks` können genutzt werden, um core Views mit eigenen Menüpunkten zu erweitern.

Aktuell unterstützen folgende Views dieses Feature:

|Controller|Action|
|---|---|
|Hosts|index <br /> notMonitored <br /> disabled|
|Services|index <br /> notMonitored <br /> disabled|

Benötigen Sie einen Link in einer bisher nicht unterstützen View, eröffnen Sie bitte ein [Issue auf GitHub](https://github.com/openITCOCKPIT/openITCOCKPIT/issues).

`AdditionalLinks` werden in der Datei `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/AdditionalLinks.php` definiert.

**Code**
```php
<?php
namespace ExampleModule\Lib;
 
use App\Lib\PluginAdditionalLinks;
 
/**
 * Class AdditionalLinks
 * @package itnovum\openITCOCKPIT\ExampleModule\AdditionalLinks
 */
class AdditionalLinks extends PluginAdditionalLinks {
 
    /**
     * @var array
     */
    private $links = [];
 
    /**
     * PluginAdditionalLinks constructor.
     */
    public function __construct() {
        // Add a link to hosts index drop down
        $this
            ->link(
                'hosts',
                'index',
                'list',
                'TestIndex({id: host.Host.id})',
                'fas fa-code',
                __('Module Link'),
                'test', //controller for permission check
                'index' //action for permission check
            );
    }
}
```

**Ergebnis**

![AdditionalLinks example](/images/module-AdditionalLinks-example.png)

## AngularAssets
Möchten Sie eigenes CSS und Javascript einbinden (abgesehen von AngularJS Controllern, Services und Directives) müssen
Sie diese in der Datei ` /opt/openitc/frontend/plugins/ExampleModule/src/Lib/AngularAssets.php` definieren.

!!! warning
    Stellen Sie sicher dass Sie das `AngularAssetsInterface` Implementieren

```php
<?php
 
namespace itnovum\openITCOCKPIT\ExampleModule\AngularAssets;
 
use itnovum\openITCOCKPIT\Core\AngularJS\AngularAssetsInterface;
use itnovum\openITCOCKPIT\Core\AngularJS\PluginAngularAssets;
 
class AngularAssets extends PluginAngularAssets implements AngularAssetsInterface {
 
    /**
     * @var array
     */
    protected $jsFiles = [
        'path/in/webroot/lib.min.js'
    ];
 
 
    protected $cssFiles = [
        '/path/in/webroot/app.css'
    ];
 
    /**
     * @return array
     */
    public function getJsFiles() {
        return $this->_getJsFiles('example_module');
    }
 
    /**
     * @return array
     */
    public function getCssFiles() {
        return $this->_getCssFiles('example_module');
    }
 
 
    /**
     * @return array
     */
    public function getJsFilesOnDisk() {
        return $this->_getJsFilesOnDisk('ExampleModule');
    }
 
    /**
     * @return array
     */
    public function getCssFilesOnDisk() {
        return $this->_getCssFilesOnDisk('ExampleModule');
    }
}
```

## Cronjobs
Cronjobs sind CakePHP commands die das openITCOCKPIT `CronjobInterface` implementieren.

!!! warning
    Stellen Sie sicher, dass Sie das `CronjobInterface` implementieren.

`src/Command/ExampleCronjobCommand.php`
```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Command;
 
use App\Model\Table\ProxiesTable;
use App\Model\Table\SystemsettingsTable;
use Cake\Console\Arguments;
use Cake\Console\Command;
use Cake\Console\ConsoleIo;
use Cake\ORM\TableRegistry;
use itnovum\openITCOCKPIT\Core\Interfaces\CronjobInterface;
 
 
/**
 * Class ExampleCronjobCommand
 * @package ExampleModule\Command
 */
class ExampleCronjobCommand extends Command implements CronjobInterface {
 
    /**
     * @param Arguments $args
     * @param ConsoleIo $io
     */
    public function execute(Arguments $args, ConsoleIo $io) {
        $io->setStyle('green', ['text' => 'green']);
        $io->setStyle('red', ['text' => 'red']);
 
        $io->out('This is an example', 0);
 
        $io->out('<green>   Ok</green>');
        $this->processQueue();
        $io->hr();
    }
}
```

## Widgets
Plugins können auch Widgets enthalten, welche ein Benutzer auf dem Dashboard platzieren kann.

Alle Widgets werden in der Datei `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/AngularAssets.php` definiert.

`src/Lib/AngularAssets.php`
```php
<?php
namespace ExampleModule\Lib;
 
use itnovum\openITCOCKPIT\Core\Dashboards\ModuleWidgetsInterface;
 
class Widgets implements ModuleWidgetsInterface {
 
    /**
     * @var array
     */
    private $ACL_PERMISSIONS = [];
 
    /**
     * Widgets constructor.
     * @param $ACL_PERMISSIONS
     */
    public function __construct($ACL_PERMISSIONS) {
        $this->ACL_PERMISSIONS = $ACL_PERMISSIONS;
    }
 
    /**
     * @return array
     */
    public function getAvailableWidgets() {
        $widgets = [];
        //Check for user permissions
        if (isset($this->ACL_PERMISSIONS['examplemodule']['test']['index'])) {
            $widgets[] = [
                'type_id'   => 900, //A unique identify
                'title'     => __('Example Overview'),
                'icon'      => 'fas fa-code',
                'directive' => 'examplemodule-widget',
                'width'     => 4,
                'height'    => 13
            ];
        }
 
        return $widgets;
    }
 
}
```