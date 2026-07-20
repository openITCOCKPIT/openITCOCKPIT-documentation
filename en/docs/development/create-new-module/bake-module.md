## "Baking" the Module

Before you start, make sure you are in the `/opt/openitc/frontend` folder and have created a new git branch for your development work.

```bash
cd /opt/openitc/frontend
git checkout -b example_module
```

![new git branch](/images/prepare-for-new-module.png)

openITCOCKPIT has its own CLI tool "`oitc`", which can, among other things, create a "skeleton" for a new module. This is referred to as the bake command, which is based on the CakePHP "[bake](https://book.cakephp.org/5/en/plugins.html#creating-a-plugin-using-bake)" command.

To create a new module, you must execute the following command:
```bash
oitc bake plugin ExampleModule
```

!!! warning "Note"
    It is important that your module name ends in "Module". Examples: Example**Module**, Autoreports**Module**, Mk**Module** etc.

The system will ask you for the module path (plugin).
```
Plugin Directory: /opt/openitc/frontend/plugins/ExampleModule
```
Please confirm this with y.

You will also be asked if you want to overwrite the `composer.json`
```
/opt/openitc/frontend/composer.json
```
**Do not overwrite this file!** Skip over this by typing `n`.

An example of creating a module with the bake command:
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

### Repairing File Permissions

Whenever you use the `oitc` command to generate files, it is recommended you assign the file permissions to the web
server user `www-data`.

openITCOCKPIT offers its own tool for setting these permissions.

```bash
oitc rights
```

![oitc rights](/images/oitc-rights.png)

### Cleaning up Application.php File
Open the file `/opt/openitc/frontend/src/Application.php` and remove the following line from it:
```php
$this->addPlugin('ExampleModule');
```

openITCOCKPIT loads its modules automatically. No manual action or additional code is required.

### Changing Routing

By default, CakePHP uses a hyphen (-) as the CamelCase separator in the URL. However, due to historical reasons, it is
necessary to replace this separator with an underscore (_).

To do this, open the file `/opt/openitc/frontend/plugins/ExampleModule/src/Plugin.php` and search for the following code.
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

Now change the value of the `path` from `example-module` to `example_module`.

```php
['path' => '/example_module'],
```

## Baking the Controller
```bash
oitc bake controller Test -p ExampleModule
```

Now you have a new Controller file where you can put your APIs endpoints.
```php
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

namespace ExampleModule\Controller;

use ExampleModule\Model\Table\MypluginSettingsTable;

class TestController extends AppController {
    public function index() {
        // More code to come...
    }
}
```

### Assigning Permissions for the "Administrator" User Role

By default, all access to the API actions is denied. You can have openITCOCKPIT assign all permissions to the "
Administrator" user by executing the following command:

```bash
openitcockpit-update --no-system-files
```

If your current user is not part of the "Administrator" group, you must navigate
to `Administration -> User Management -> Manage User Roles` and assign the permissions manually.

![grant permissions](/images/grant-user-role-permissions.png)

### AclDependencies
By default, each individual controller action will create a new user permission.

![user permissions example](/images/user-permission-example.png)

However, some actions may depend on other actions and may affect the entire application if a user disables a particular permission.

To prevent this, you can define ACL-based dependencies if required.

AclDependencies are defined in the file `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/AclDependencies.php`.
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

Actions marked as "always allowed" or set as "dependency" can no longer be changed per user role. These are set automatically by the system.

Every time you make changes in `AclDependencies`, you must execute the following command

```bash
openitcockpit-update --no-system-files
```

## Menu Item

By default, the openITCOCKPIT menu is divided into four
categories ([MenuHeadline](https://github.com/openITCOCKPIT/openITCOCKPIT/blob/development/src/itnovum/openITCOCKPIT/Core/Menu/Menu.php#L32-L35)):
Overview, Monitoring, Administration and System Configuration.

You can either create links in these categories or create your own categories.

All menu entries for your module are defined in the file `/opt/openitc/frontend/plugins/ExampleModule/src/Lib/Menu.php`
definiert.

### Menu Entry for an Existing Heading

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
        $Overview = new MenuHeadline(\itnovum\openITCOCKPIT\Core\Menu\Menu::MENU_OVERVIEW);
        $Overview
            //Create a new Sub-Category of the Overview Headline
            ->addCategory((new MenuCategory(
                'ExampleModule',
                __('Example Module'),
                1000,
                ['fas', 'burn']
            ))
                //Add new Link to Sub-Category
                ->addLink(new MenuLink(
                    __('Hello world'),
                    'TestIndex', // Name of the NG-State, historically needed but may be deprecated in the future
                    'Test', // Name of the PHP Controller
                    'index', // Name of the PHP action
                    'ExampleModule', //Name of the Module
                    ['fas', 'code'], //Menu Icon
                    [],
                    1,
                    true,
                    'example_module/index' //URL to the action
                ))
            );
 
        return [$Overview];
    }
 
}
```

**Result**

![new menu entry](/images/new-menu-entry.png)

Now execute the following command to update the display for the views that have been edited.

```bash
openitcockpit-update --no-system-files
```

### Menu Items Under a new Heading

If needed, you can also create your own headings.

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
                'fas burn'
            ))
                //Add new Link to Sub-Category
                ->addLink(new MenuLink(
                    __('Hello world'),
                    'TestIndex', // Name of the NG-State, historically needed but may be deprecated in the future
                    'Test', //Name of the PHP Controller
                    'index', //Name of the PHP action
                    'ExampleModule', //Name of the Module
                    ['fas', 'code'], //Menu Icon
                    [],
                    1,
                    true,
                    'example_module/index' //URL to the action
                ))
            );
 
        return [$ExampleModuleHeadline];
    }
}
```

**Result**

![](/images/new-menu-headline.png)

Now execute the following command to update the display for the views that have been edited.

```bash
openitcockpit-update --no-system-files
```

## Database Access

### Baking the Migration
Migrations are required to perform changes to your database structure. They will CREATE/DROP and ALTER tables and columns, as you wish. But you won't write SQL directly. 

```bash
oitc migrations create -p ExampleModule Initial
```
The system will create a new, empty "migration" file under the following path:
`/opt/openitc/frontend/plugins/ExampleModule/config/Migrations/<timestamp>_Initial.php`

Have a look at our migration for the ExampleModule:
```php
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

### Migrating Your Database
Creating a migration is one thing. Now, you need to tell openITOCKPIT to run all migrations of the ExampleModule. So you need to run:
```bash
oitc migrations migrate -p ExampleModule
```

Now you can use either MySQL CLI or phpMyAdmin to verify that the table is created correctly. Also, there will be an entry to phinxlog which prevents the same migration from being executed again.

### Creating Models
Having the database table now set up, you will have to create Model objects.

To create, read, update and delete entries to tables, you will also not write SQL yourself. This will be handled by the CakePHP ORM.

So we run this command to first create the Model and Entity objects.
```bash
oitc bake model -p ExampleModule MypluginSettings
```
This command will create a Entity objet and a Table object, located in
`plugins/ExampleModule/src/Model/Table` and `plugins/ExampleModule/src/Model/Entity`.

Entity/MypluginSetting.php
```php
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

namespace ExampleModule\Model\Entity;

use Cake\ORM\Entity;

/**
 * MypluginSetting Entity
 *
 * @property int $id
 * @property string $webhook_url
 * @property \Cake\I18n\FrozenTime $created
 * @property \Cake\I18n\FrozenTime $modified
 */
class MypluginSetting extends Entity {
    /**
     * Fields that can be mass assigned using newEntity() or patchEntity().
     *
     * Note that when '*' is set to true, this allows all unspecified fields to
     * be mass assigned. For security purposes, it is advised to set '*' to false
     * (or remove it), and explicitly make individual fields accessible as needed.
     *
     * @var array<string, bool>
     */
    protected $_accessible = [
        'webhook_url' => true,
        'created'     => true,
        'modified'    => true,
    ];
}
```

`MypluginSettingsTable.php`
```php
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

namespace ExampleModule\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

/**
 * MypluginSettings Model
 *
 * @method \ExampleModule\Model\Entity\MypluginSetting newEmptyEntity()
 * @method \ExampleModule\Model\Entity\MypluginSetting newEntity(array $data, array $options = [])
 * @method \ExampleModule\Model\Entity\MypluginSetting[] newEntities(array $data, array $options = [])
 * @method \ExampleModule\Model\Entity\MypluginSetting get($primaryKey, $options = [])
 * @method \ExampleModule\Model\Entity\MypluginSetting findOrCreate($search, ?callable $callback = null, $options = [])
 * @method \ExampleModule\Model\Entity\MypluginSetting patchEntity(\Cake\Datasource\EntityInterface $entity, array $data, array $options = [])
 * @method \ExampleModule\Model\Entity\MypluginSetting[] patchEntities(iterable $entities, array $data, array $options = [])
 * @method \ExampleModule\Model\Entity\MypluginSetting|false save(\Cake\Datasource\EntityInterface $entity, $options = [])
 * @method \ExampleModule\Model\Entity\MypluginSetting saveOrFail(\Cake\Datasource\EntityInterface $entity, $options = [])
 * @method \ExampleModule\Model\Entity\MypluginSetting[]|\Cake\Datasource\ResultSetInterface|false saveMany(iterable $entities, $options = [])
 * @method \ExampleModule\Model\Entity\MypluginSetting[]|\Cake\Datasource\ResultSetInterface saveManyOrFail(iterable $entities, $options = [])
 * @method \ExampleModule\Model\Entity\MypluginSetting[]|\Cake\Datasource\ResultSetInterface|false deleteMany(iterable $entities, $options = [])
 * @method \ExampleModule\Model\Entity\MypluginSetting[]|\Cake\Datasource\ResultSetInterface deleteManyOrFail(iterable $entities, $options = [])
 *
 * @mixin \Cake\ORM\Behavior\TimestampBehavior
 */
class MypluginSettingsTable extends Table {
    /**
     * Initialize method
     *
     * @param array $config The configuration for the Table.
     * @return void
     */
    public function initialize(array $config): void {
        parent::initialize($config);

        $this->setTable('myplugin_settings');
        $this->setDisplayField('webhook_url');
        $this->setPrimaryKey('id');

        $this->addBehavior('Timestamp');
    }

    /**
     * Default validation rules.
     *
     * @param \Cake\Validation\Validator $validator Validator instance.
     * @return \Cake\Validation\Validator
     */
    public function validationDefault(Validator $validator): Validator {
        $validator
            ->scalar('webhook_url')
            ->maxLength('webhook_url', 255)
            ->notEmptyString('webhook_url');

        return $validator;
    }

    public function getSettingsEntity() {
        $result = $this->find()
            ->where([
                'id' => 1
            ])
            ->first();

        if (empty($result)) {
            $entity = $this->newEmptyEntity();
            $entity->set('id', 1);
            $entity->setAccess('id', false);
            return $entity;
        }

        $result->setAccess('id', false);
        return $result;
    }
}
```

### Querying the Table
So in our Controller, we want to either read or update an entry on that settings table we created. See our example code for the TestController:

```php
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

namespace ExampleModule\Controller;

use ExampleModule\Model\Table\MypluginSettingsTable;

class TestController extends AppController {
    public function index() {
        /** @var MypluginSettingsTable $myPluginSettingsTable */
        $myPluginSettingsTable = $this->getTableLocator()->get('ExampleModule.MypluginSettings');
        $settingsEntity = $myPluginSettingsTable->getSettingsEntity();

        if ($this->request->is('post')) {
            $settingsEntity = $myPluginSettingsTable->patchEntity($settingsEntity, $this->request->getData(null, []));

            $myPluginSettingsTable->save($settingsEntity);
            if ($settingsEntity->hasErrors()) {
                $this->response = $this->response->withStatus(400);
                $this->set('error', $settingsEntity->getErrors());
                $this->viewBuilder()->setOption('serialize', ['error']);
                return;
            }

            $this->set('teamsSettings', $settingsEntity);
            $this->viewBuilder()->setOption('serialize', [
                'teamsSettings'
            ]);
        }

        $this->set('settings', $settingsEntity);
        $this->viewBuilder()->setOption('serialize', ['settings']);
    }
}
```

With all this set up, your next step will be creating the Angular Front-End.