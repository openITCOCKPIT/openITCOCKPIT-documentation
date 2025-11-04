# Database access

openITCOCKPIT uses the [CakePHP ORM](https://book.cakephp.org/5/en/orm.html) to access the database. **Always be sure to use the ORM – never write your own plain SQL queries.**

This example builds on the [openITCOCKPIT ExampleModule Repository](https://github.com/openITCOCKPIT/openITCOCKPIT-ExampleModule/tree/master). Feel free to have a look at the code there.

## Creating a new table in the database

To manage schema updates, openITCOCKPIT uses the [CakePHP Migrations plugin](https://book.cakephp.org/migrations/3/en/index.html)

### Creating a new table

Let's assume you want to store additional information about a host. To do this, we would create a new table to store this additional data.

!!! danger
    NEVER attempt to manipulate any existing tables!

To create a new, empty "migration" file, please execute the following command:
```bash
oitc migrations create -p ExampleModule Initial
```

Sample command output:

```bash
root @ /opt/openitc/frontend/plugins/ExampleModule - [ExampleModule] # oitc migrations create -p ExampleModule Initial
using migration paths
- /opt/openitc/frontend/plugins/ExampleModule/config/Migrations
using seed paths
- /opt/openitc/frontend/plugins/ExampleModule/config/Seeds
using migration base class Migrations\AbstractMigration
using alternative template /opt/openitc/frontend/vendor/cakephp/migrations/templates/Phinx/create.php.template
created config/Migrations/20200331090547_initial.php
renaming file in CamelCase to follow CakePHP convention...
renaming file in CamelCase to follow CakePHP convention...
File successfully renamed to /opt/openitc/frontend/plugins/ExampleModule/config/Migrations/20200331090547_Initial.php
root @ /opt/openitc/frontend/plugins/ExampleModule - [ExampleModule] #
```

To set the file permissions, it is also recommended that you execute the following command:
```bash
oitc rights
```

The system will create a new, empty "migration" file under the following path: 
`/opt/openitc/frontend/plugins/ExampleModule/config/Migrations/<timestamp>_Initial.php`

![new migration file](/images/new-migration.png)

You can now define the schema for your new table in this file.

`plugins/ExampleModule/config/Migrations/20200331090547_Initial.php`
```php
<?php
declare(strict_types=1);
 
use Migrations\AbstractMigration;
 
/**
 * Class Initial
 *
 * Created via:
 * oitc migrations create -p ExampleModule Initial
 */
class Initial extends AbstractMigration {
 
    /**
     * Whether the tables created in this migration
     * should auto-create an `id` field or not
     *
     * This option is global for all tables created in the migration file.
     * If you set it to false, you have to manually add the primary keys for your
     * tables using the Migrations\Table::addPrimaryKey() method
     *
     * @var bool
     */
    public $autoId = false;
 
    /**
     * Change Method.
     *
     * More information on this method is available here:
     * https://book.cakephp.org/phinx/0/en/migrations.html#the-change-method
     * @return void
     */
    public function change() : void {
 
        $this->table('example_notes')
            ->addColumn('id', 'integer', [
                'autoIncrement' => true,
                'default'       => null,
                'limit'         => 11,
                'null'          => false,
            ])
            ->addPrimaryKey(['id'])
            ->addColumn('host_id', 'integer', [
                'default' => null,
                'limit'   => 11,
                'null'    => false,
            ])
            ->addColumn('notes', 'string', [
                'default' => null,
                'limit'   => 255,
                'null'    => false,
            ])
            ->create();
    }
}
```

In this example, the new table "example_notes" is created and contains the fields id, host_id and notes.

To create this new table in the database, execute the following command:

```bash
openitcockpit-update --no-system-files
```

You can use the MySQL CLI or phpMyAdmin to check this.

Table:
```bash
$ # mysql --defaults-file=/opt/openitc/etc/mysql/mysql.cnf
mysql> show tables like 'example_%';
+-------------------------------------+
| Tables_in_openitcockpit (example_%) |
+-------------------------------------+
| example_module_phinxlog             |
| example_notes                       |
+-------------------------------------+
2 rows in set (0.00 sec)

mysql>
```

Table schema:

```sql
mysql> show create table example_notes\G
*************************** 1. row ***************************
       Table: example_notes
Create Table: CREATE TABLE `example_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host_id` int(11) NOT NULL,
  `notes` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
1 row in set (0.00 sec)
 
mysql>
```

### Inserting sample data

To make the development process less abstract and thus more meaningful, we recommend inserting some sample data into the new table. You can use the following SQL statement to create an entry for each host.

```sql
INSERT INTO `example_notes` (`host_id`, `notes`) SELECT id, CONCAT('Notes for the host: ', name) FROM `hosts`;
```

## Creating a new table object (CakePHP)

To access a database table via the CakePHP ORM, a table object is required.

```bash
oitc bake model ExampleNotes -p ExampleModule
```

Sample command output:
```bash
oot @ /opt/openitc/frontend/plugins/ExampleModule - [ExampleModule] # oitc bake model ExampleNotes -p ExampleModule

One moment while associations are detected.

Baking table class for ExampleNotes...

Creating file /opt/openitc/frontend/plugins/ExampleModule/src/Model/Table/ExampleNotesTable.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/src/Model/Table/ExampleNotesTable.php`

Baking entity class for ExampleNote...

Creating file /opt/openitc/frontend/plugins/ExampleModule/src/Model/Entity/ExampleNote.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/src/Model/Entity/ExampleNote.php`

Baking test fixture for ExampleNotes...

Creating file /opt/openitc/frontend/plugins/ExampleModule/tests/Fixture/ExampleNotesFixture.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/tests/Fixture/ExampleNotesFixture.php`
Bake is detecting possible fixtures...

Baking test case for ExampleModule\Model\Table\ExampleNotesTable ...

Creating file /opt/openitc/frontend/plugins/ExampleModule/tests/TestCase/Model/Table/ExampleNotesTableTest.php
Wrote `/opt/openitc/frontend/plugins/ExampleModule/tests/TestCase/Model/Table/ExampleNotesTableTest.php`
Done

root @ /opt/openitc/frontend/plugins/ExampleModule - [ExampleModule] #
```

```bash
oitc rights
```

The system has now automatically created a new [Table](https://book.cakephp.org/4/en/orm/table-objects.html) and [Entity](https://book.cakephp.org/4/en/orm/entities.html) object.

Now open the file
`/opt/openitc/frontend/plugins/ExampleModule/src/Model/Table/ExampleNotesTable.php`

```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Model\Table;
 
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
            'className'  => 'ExampleModule.Hosts',
        ]);
    }
 
    //... more code ...
 
}
```

The system has detected an [association](https://book.cakephp.org/4/en/orm/associations.html) between the new table and the hosts table and created a [belongsTo](https://book.cakephp.org/4/en/orm/associations.html) association from it.

To use the hosts table from the core, remove the `ExampleModule` prefix.

```php
$this->belongsTo('Hosts', [
    'foreignKey' => 'host_id',
    'joinType'   => 'INNER',
    'className'  => 'Hosts',
]);
```

## Querying tables via table objects

Open the code for your TestController to query the table.

!!! tip
    Writing queries directly as in the following example is not recommended. You should always create a separate method for each query. This helps structure the code.

```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Controller;
 
 
use Cake\ORM\TableRegistry;
use ExampleModule\Model\Table\ExampleNotesTable;
 
class TestController extends AppController {
 
    public function index() {
        if (!$this->isApiRequest()) {
            // The requested URL was: /example_module/test/index.html
            // The controller only sends the HTML template to the client browser / AngularJS
 
            /**********************************************************/
            /* DO NOT RUN ANY DATABASE QUERY HERE!                    */
            /* THIS CODE IS ONLY TO SHIP THE TEMPLATE                 */
            /**********************************************************/
 
            // Pass the variable "message" with the content "Hello World (HTML)" to the view for .html requests
            $this->set('message', 'Hello World (HTML)');
            return;
        }
 
        // This get executed for API requests
        //  The requested URL was: /example_module/test/index.json
 
        //Load ExampleNotesTable
        /** @var ExampleNotesTable $ExampleNotesTable */
        $ExampleNotesTable = TableRegistry::getTableLocator()->get('ExampleModule.ExampleNotes');
 
        //Query data
        $result = $ExampleNotesTable->find()
            ->order([
                'ExampleNotes.id' => 'asc'
            ])
            ->all();
 
 
        // Pass the variable "message" with the content "Hello World" to the JSON view
        // Pass the variable "result" to the JSON view
        $this->set('message', 'Hello World');
        $this->set('result', $result);
 
        // Add the variable "message" to .json output
        $this->viewBuilder()->setOption('serialize', ['message', 'result']);
    }
 
}
```

Load the URL `https://example.org/example_module/test/index.json` to display the result in the browser.

![json result](/images/json-result.png)

### Joining tables
As long as you cleanly define your associations, you can always join your tables using the [contain](https://book.cakephp.org/4/en/orm/retrieving-data-and-resultsets.html#eager-loading-associations-via-contain) method.

To join the Hosts table, you simply need to "contain" the "Host" table object:

**Code**
```php
/** @var ExampleNotesTable $ExampleNotesTable */
$ExampleNotesTable = TableRegistry::getTableLocator()->get('ExampleModule.ExampleNotes');
 
//Query data
$result = $ExampleNotesTable->find()
    ->order([
        'ExampleNotes.id' => 'asc'
    ])
    ->contain([
        'Hosts' => function (Query $query) {
            $query
                ->disableAutoFields()
                ->select([
                    'Hosts.id',
                    'Hosts.name',
                    'Hosts.uuid',
                ]);
            return $query;
        }
    ])
    ->all();
```

**Result**
![json result with hosts](/images/json-result-with-hosts.png)

## Querying host and service status

openITCOCKPIT supports several database backends in which status information can be stored. For this reason, related tables must always be loaded via the [DbBackend](https://github.com/openITCOCKPIT/openITCOCKPIT/blob/development/src/itnovum/openITCOCKPIT/Core/DbBackend.php) object.

The DbBackend object is available by default in every controller.

```php
// Load Hoststatus table
$HoststatusTable = $this->DbBackend->getHoststatusTable();
 
// Select fields to load
$HoststatusFields = new HoststatusFields($this->DbBackend);
$HoststatusFields
    ->currentState()
    ->output();
 
//Query Hoststatus Table
$hoststatus = $HoststatusTable->byUuids(
    Hash::extract($result->toArray(), '{n}.host.uuid'),
    $HoststatusFields
);
```

**Code**
```php
<?php
declare(strict_types=1);
 
namespace ExampleModule\Controller;
 
 
use Cake\ORM\Query;
use Cake\ORM\TableRegistry;
use Cake\Utility\Hash;
use ExampleModule\Model\Table\ExampleNotesTable;
use itnovum\openITCOCKPIT\Core\HoststatusFields;
 
class TestController extends AppController {
 
    public function index() {
        if (!$this->isApiRequest()) {
            // The requested URL was: /example_module/test/index.html
            // The controller only sends the HTML template to the client browser / AngularJS
 
            /**********************************************************/
            /* DO NOT RUN ANY DATABASE QUERY HERE!                    */
            /* THIS CODE IS ONLY TO SHIP THE TEMPLATE                 */
            /**********************************************************/
 
            // Pass the variable "message" with the content "Hello World (HTML)" to the view for .html requests
            $this->set('message', 'Hello World (HTML)');
            return;
        }
 
        // This get executed for API requests
        //  The requested URL was: /example_module/test/index.json
 
        //Load ExampleNotesTable
        /** @var ExampleNotesTable $ExampleNotesTable */
        $ExampleNotesTable = TableRegistry::getTableLocator()->get('ExampleModule.ExampleNotes');
 
        // Load Hoststatus table
        $HoststatusTable = $this->DbBackend->getHoststatusTable();
 
        //Query data
        $result = $ExampleNotesTable->find()
            ->order([
                'ExampleNotes.id' => 'asc'
            ])
            ->contain([
                'Hosts' => function (Query $query) {
                    $query
                        ->disableAutoFields()
                        ->select([
                            'Hosts.id',
                            'Hosts.name',
                            'Hosts.uuid',
                        ]);
                    return $query;
                }
            ])
            ->all();
 
        // Select fields to load
        $HoststatusFields = new HoststatusFields($this->DbBackend);
        $HoststatusFields
            ->currentState()
            ->output();
 
        //Query Hoststatus Table
        $hoststatus = $HoststatusTable->byUuids(
            Hash::extract($result->toArray(), '{n}.host.uuid'),
            $HoststatusFields
        );
 
        // Pass the variable "message" with the content "Hello World" to the JSON view
        // Pass the variable "result" to the JSON view
        $this->set('message', 'Hello World');
        $this->set('result', $result);
        $this->set('hoststatus', $hoststatus);
 
        // Add the variable "message" to .json output
        $this->viewBuilder()->setOption('serialize', ['message', 'result', 'hoststatus']);
    }
 
}
```


**Result**
![hoststatus example](/images/hoststatus-example.png)



## Using your own database
If you need to store data that is not related to openITCOCKPIT data, we recommend you store it in a separate database. Modules can create and manage their own database connections.

### Defining a new database connection
Create the file `/ExampleModule/config/datasource.php`

```php
<?php
$mcp = new \App\itnovum\openITCOCKPIT\Database\MysqlConfigFileParser();
$ini_file = $mcp->parse_mysql_cnf('/opt/openitc/etc/mysql/mysql.cnf');
 
return [
    'Datasources' => [
        'plugin_connection' => [
            'className' => 'Cake\Database\Connection',
            'driver' => 'Cake\Database\Driver\Mysql',
            'persistent' => true,
            'host' => $ini_file['host'],
            'username' => $ini_file['user'],
            'password' => $ini_file['password'],
            'database' => 'plugin_database',
             /**
              * You do not need to set this flag to use full utf-8 encoding (internal default since CakePHP 3.6).
              */
            'encoding' => 'utf8mb4',
            'timezone' => 'UTC',
            'flags' => [],
            'cacheMetadata' => true,
            'log' => false,
 
            /**
             * Set identifier quoting to true if you are using reserved words or
             * special characters in your table or column names. Enabling this
             * setting will result in queries built using the Query Builder having
             * identifiers quoted when creating SQL. It should be noted that this
             * decreases performance because each query needs to be traversed and
             * manipulated before being executed.
             */
            'quoteIdentifiers' => true,
            ]
    ]
];
```

This example uses the username, password and host configuration of openITCOCKPIT's `mysql.cnf`. You can also enter your own username and password combinations in the file.

### Loading and using your own database configuration
Open the file `/ExampleModule/src/Plugin.php` and load the new database configuration inside the `bootstrap()` method. You can copy and paste the code below:

```php
<?php
class Plugin extends BasePlugin {
    public function bootstrap(PluginApplicationInterface $app): void {
        Configure::load('DistributeModule.datasource');
        $datasources = Configure::consume('Datasources');
 
        //Check if configuration is already loaded to avoid:
        // => Cannot reconfigure existing key "plugin_test"
        if(ConnectionManager::getConfig(key($datasources)) === null) {
            ConnectionManager::setConfig($datasources);
        }
    }
}
```

In this final step, you must enter the database configuration in all `table` classes that use their own database connection. 
`src/SomeTable.php`
```php
<?php
class ExampleNotesTable extends Table {
    public static function defaultConnectionName(): string {
        //debug(Configure::read('Datasources.plugin_test')); // Returns the config
        return 'plugin_connection';
    }
}
```

!!! warning
    The `defaultConnectionName()` method must be `static`!
