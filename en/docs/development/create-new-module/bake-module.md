## Baking the Module

Before you begin, make sure you are in the `/opt/openitc/frontend` directory and have created a new Git branch for your development work.

```bash
cd /opt/openitc/frontend
git checkout -b example_module
```

![new git branch](/images/prepare-for-new-module.png)

openITCOCKPIT provides its own CLI tool, `oitc`, which can generate a "skeleton" for a new module. This process is called **baking** and is based on the CakePHP [`bake`](https://book.cakephp.org/5/en/plugins.html#creating-a-plugin-using-bake) command.

To create a new module, run the following command:

```bash
oitc bake plugin ExampleModule
```

!!! warning "Note"
    Your module name **must** end with `Module`. Examples: `ExampleModule`, `AutoreportsModule`, `MkModule`, etc.

The system will ask you to confirm the plugin directory:

```text
Plugin Directory: /opt/openitc/frontend/plugins/ExampleModule
```

Confirm by entering `y`.

Next, you will be asked whether you want to overwrite the following file:

```text
/opt/openitc/frontend/composer.json
```

**Do not overwrite this file.** Enter `n` to skip this step.

Example output of the bake command:

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

Whenever you use the `oitc` command to generate files, it is recommended to assign the generated files to the web server user `www-data`.

openITCOCKPIT provides a built-in command for setting the correct file permissions.

```bash
oitc rights
```

![oitc rights](/images/oitc-rights.png)

### Cleaning Up `Application.php`

Open `/opt/openitc/frontend/src/Application.php` and remove the following line:

```php
$this->addPlugin('ExampleModule');
```

openITCOCKPIT automatically loads all modules, so no manual registration is required.

### Changing the Routing

By default, CakePHP uses a hyphen (`-`) as the CamelCase separator in URLs. However, for historical reasons, openITCOCKPIT requires an underscore (`_`) instead.

Open `/opt/openitc/frontend/plugins/ExampleModule/src/Plugin.php` and locate the following code:

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

Change the `path` value from `example-module` to `example_module`:

```php
['path' => '/example_module'],
```

## Baking the Controller

```bash
oitc bake controller Test -p ExampleModule
```

This creates a new controller where you can implement your API endpoints.

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

### Assigning Permissions to the "Administrator" Role

By default, access to all API actions is denied.

To automatically assign all permissions to the **Administrator** role, run:

```bash
openitcockpit-update --no-system-files
```

If your current user is **not** part of the **Administrator** role, navigate to:

`Administration -> User Management -> Manage User Roles`

and assign the required permissions manually.

![grant permissions](/images/grant-user-role-permissions.png)

### AclDependencies

By default, every controller action creates its own user permission.

![user permissions example](/images/user-permission-example.png)

Some actions depend on other actions, and disabling a specific permission could affect the functionality of the entire application.

To prevent this, you can define ACL dependencies.

ACL dependencies are configured in:

`/opt/openitc/frontend/plugins/ExampleModule/src/Lib/AclDependencies.php`

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

Actions marked as **always allowed** or defined as **dependencies** can no longer be configured individually for user roles. These permissions are managed automatically by the system.

Whenever you modify `AclDependencies`, run:

```bash
openitcockpit-update --no-system-files
```

## Menu Items

By default, the openITCOCKPIT menu is divided into four categories ([MenuHeadline](https://github.com/openITCOCKPIT/openITCOCKPIT/blob/development/src/itnovum/openITCOCKPIT/Core/Menu/Menu.php#L32-L35)):

- Overview
- Monitoring
- Administration
- System Configuration

You can either add menu entries to these categories or create your own custom category.

All menu definitions for your module are located in:

`/opt/openitc/frontend/plugins/ExampleModule/src/Lib/Menu.php`

### Adding a Menu Entry to an Existing Heading

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

Run the following command to update the menu:

```bash
openitcockpit-update --no-system-files
```

### Creating Menu Items Under a New Heading

If required, you can also create your own menu headings.

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

Run the following command to update the menu:

```bash
openitcockpit-update --no-system-files
```

## Database Access

### Creating a Migration

Migrations are used to modify your database schema. They allow you to create, alter, and remove tables or columns without writing SQL manually.

```bash
oitc migrations create -p ExampleModule Initial
```

This creates a new, empty migration file at:

`/opt/openitc/frontend/plugins/ExampleModule/config/Migrations/<timestamp>_Initial.php`

Example migration:

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

### Running the Migration

Creating a migration is only the first step. To apply it, execute:

```bash
oitc migrations migrate -p ExampleModule
```

You can verify the new table using the MySQL CLI or phpMyAdmin.

An entry is also added to the `phinxlog` table to ensure the migration is not executed again.

### Creating Models

With the database table in place, you can now generate the corresponding model classes.

CakePHP's ORM handles creating, reading, updating, and deleting records, so you don't need to write SQL manually.

Generate the model and entity classes:

```bash
oitc bake model -p ExampleModule MypluginSettings
```

This command creates an Entity class and a Table class in:

- `plugins/ExampleModule/src/Model/Entity`
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

- `plugins/ExampleModule/src/Model/Table`
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

Your controller can now read from or update the settings table.

Example implementation for `TestController`:

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

With all of this in place, you're ready to start building the Angular frontend.