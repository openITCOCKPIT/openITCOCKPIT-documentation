# Creating a new openITCOCKPIT module

For this article you will need an openITCOCKPIT development environment. Read [guide on how to create an openITCOCKPIT development environment.](../../setup-dev-env/#creating-an-openitcockpit-development-environment)

This article contains the best practices for adding new features to openITCOCKPIT by creating a custom module. Developing your own module ensures that your system remains updatable and maintainable by our experts.

## Getting started with development

The backend of openITCOCKPIT is written in PHP and uses the [CakePHP 4](https://book.cakephp.org/4/en/index.html) framework.

The frontend is based on an [Angular](https://angular.dev/) and [CoreUI](https://coreui.io) stack.

We recommend [JetBrains PHPStorm](https://www.jetbrains.com/phpstorm/) as your IDE and [Mozilla Firefox](https://www.mozilla.org/en-US/firefox/new/) as your Browser.

The sample code is available on GitHub: <https://github.com/openITCOCKPIT/openITCOCKPIT-ExampleModule>

### Prerequisites

This document exclusively describes the development of modules for openITCOCKPIT.
You must have experience with CakePHP and AngularJS before attempting to create any bespoke modules.

### Working directory

The working directory for openITCOCKPIT is `/opt/openitc/frontend`.

Make sure you are in this folder before you begin.

It is also recommended you use git for tracking your changes.

## Activating debug mode

!!! danger "Important"
    Be aware that enabling debug mode can lead to data leaks and the loss of sensitive information.

By default, openITCOCKPIT runs in production mode. To get error messages and uncompressed (not minified) JavaScript, you will have to enable debug mode.

To do this, open the file `/etc/nginx/openitc/master.conf` and set the parameter `OITC_DEBUG` from `0` to `1`.

```
fastcgi_param OITC_DEBUG 1;
```

In order for your changes to be enabled, you must execute the following command:

```bash
openitcockpit-update --no-system-files
```

!!! danger "Important"
    Again, be aware that enabling debug mode can lead to data leaks and the loss of sensitive information.

### Deactivating debug mode
To deactivate debug mode in openITCOCKPIT, you must execute the following command:

```bash
openitcockpit-update
```
