# Additionalplugin_database

## Linking core tables with plugin tables
In some cases, a link to an openITCOCKPIT core table object is required from a module's table object.

In this example, we want to delete the "additional notes" from the module table as soon as the associated host is deleted. To implement this, we do not need to modify any core code.

!!! warning
    Only core tables that use the `PluginManagerTableTrait` can be extended by modules.

```php
class HostsTable extends Table {
use PluginManagerTableTrait;
}
```
If you want to extend a core table that does not already use the PluginManagerTableTrait, do not hesitate to send us a pull request.

### config/associations.php
Create the file `/opt/openitc/frontend/plugins/ExampleModule/config/associations.php` to define a list of core tables to associate with your plugin tables.

```php
<?php
return [
    'Hosts' => [ //Core Table
        'ExampleModule.ExampleNotes' //Plugin Tables
    ]
];
```

### Defining the Table::bindCoreAssociations method

You now need to create the `bindCoreAssociations()` method in your Plugin-table class.

Within this method you can define table associations that would normally have been defined in the core `HostsTable` class.

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

### Testing associations

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


**Result**
![json result with hosts 2](/images/json-result-with-hosts-2.png)

## AclDependencies
By default, each individual controller action will create a new user permission.

![user permissions example](/images/user-permission-example.png)

However, some actions may depend on other actions and may affect the entire application if a user disables a particular permission.

To prevent this, you can define ACL-based dependencies if required.

AclDependencies are defined in the file `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/AclDependencies.php` definiert.
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

Actions marked as "always allowed" or set as "dependency" can no longer be selected by the user.

These are set automatically by the system.

Every time you make changes in `AclDependencies`, you must execute the following command

```bash
openitcockpit-update --no-system-files
```

## AdditionalLinks

`AdditionalLinks` can be used to extend core views with your own menu items.

Currently, the following views support this feature:

|Controller|Action|
|---|---|
|Hosts|index <br /> notMonitored <br /> disabled|
|Services|index <br /> notMonitored <br /> disabled|

If you need a link in a previously unsupported view, please open an [issue on GitHub](https://github.com/openITCOCKPIT/openITCOCKPIT/issues).

`AdditionalLinks` are defined in the file `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/AdditionalLinks.php` definiert.

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

**Result**

![AdditionalLinks example](/images/module-AdditionalLinks-example.png)

## AngularAssets
If you want to include your own CSS and Javascript (apart from AngularJS controllers, services and directives), you have to define them in the file `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/AngularAssets.php`.

!!! warning
    Make sure you have implemented the `AngularAssetsInterface`.

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

## Cron jobs
Cron jobs are CakePHP commands that implement the openITCOCKPIT `CronjobInterface`.

!!! warning
    Make sure you have implemented the `CronjobInterface`.

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
Plugins can also contain widgets that a user can place on the dashboard.

All widgets are defined in the file `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/AngularAssets.php`.

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
