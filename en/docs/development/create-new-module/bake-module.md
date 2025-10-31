# "Baking" the module

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

## Repairing file permissions

Whenever you use the `oitc` command to generate files, it is recommended you assign the file permissions to the web
server user `www-data`.

openITCOCKPIT offers its own tool for setting these permissions.

```bash
oitc rights
```

![oitc rights](/images/oitc-rights.png)

## Cleaning up the src/Application.php file
Open the file `/opt/openitc/frontend/src/Application.php` and remove the following line from it:
```php
$this->addPlugin('ExampleModule');
```

openITCOCKPIT loads its modules automatically. No manual action or additional code is required.

## Changing routing

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

## Create and run migration

Migrations modify the database structure for an application. Hence, we will use one to create our own database table.

Create the folders for the migration's files.

```bash
mkdir -p plugins/ExampleModule/config/Migrations
mkdir -p plugins/ExampleModule/config/Seeds

oitc rights
```

### Create 'Initial' migration file

```bash
OITC_DEBUG=1 oitc migrations create -p ExampleModule Initial
```

This command will create a migration file inside `/config/Migrations` folder.
File name will be prefixed with the timestamp value and look like `20220928065505_Initial.php`.

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

### Run migration

```bash
oitc migrations migrate -p ExampleModule
```

After the command has finished, you will see the table `myplugin_settings` in the database.
