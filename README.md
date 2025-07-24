# [Work in progress] openITCOCKPIT-documentation

This repository contains the documentation of [openITCOCKPIT](https://github.com/openITCOCKPIT/openITCOCKPIT)
in German and English language.

## For users

The latest version of the documentation is available at
[https://docs.openitcockpit.io/](https://docs.openitcockpit.io/)

## For contributors

Did you find a typo or do you want to improve the documentation?
Feel free to send a pull request.


### Setup your local copy via Docker

1. Clone this repository
```
git clone https://github.com/openITCOCKPIT/openITCOCKPIT-documentation.git
cd openITCOCKPIT-documentation/
```

2. Build Docker image
```
docker build . -t openitcockpit/mkdocs
```

3. Run Docker Container (German Docs [🇩🇪])
```
docker run --rm -it -v "$PWD":/docs -w /docs/de -p 8000:8000 openitcockpit/mkdocs
```

3. Run Docker Container (English Docs [🇺🇸])
```
docker run --rm -it -v "$PWD":/docs -w /docs/en -p 8000:8000 openitcockpit/mkdocs
```

4. Open in Web Browser
```
http://127.0.0.1:8000/
```

5. Edit the files

You can edit the files with your favorite editor. Docker will copy changed files automatically into the container. No manual effort required.

### Deploy static files to a web server
This part describes how to deploy the documentation as static HTML files. This is useful if you plan to host a copy of the documentation locally.

> :information_source: If you only want to improve the documentation, please use the Docker setup as descripted above.

1. Clone this repository
```
git clone https://github.com/openITCOCKPIT/openITCOCKPIT-documentation.git
cd openITCOCKPIT-documentation/
```

2. Build Docker image
```
docker build . -t openitcockpit/mkdocs
```

3. Build all languages
```
docker run --rm -it -v "$PWD":/docs -w /docs/de -p 8000:8000 openitcockpit/mkdocs /usr/bin/mkdocs build
docker run --rm -it -v "$PWD":/docs -w /docs/en -p 8000:8000 openitcockpit/mkdocs /usr/bin/mkdocs build

mkdir htdocs
cp -r de/site/. htdocs/

mkdir htdocs/en
cp -r en/site/. htdocs/en
```

4. Deploy

Copy the content of the `htdocs` folder to your web servers document root.

To documentation does **not require** any server side programing languages like php, python or java. 

You can also use an Apache2 web server running inside of a Docker container like in this example:
```
docker run --rm -it --name my-apache-app -p 8080:80 -v "$PWD/htdocs":/usr/local/apache2/htdocs/ httpd:2.4
```

Go to `http://127.0.0.1:8080/`


## License
```
Copyright (C) 2015-2025  it-novum GmbH
Copyright (C) 2025-today Allgeier IT Services GmbH


openITCOCKPIT is dual licensed

1)
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3 of the License.


This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.


You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

2)
If you purchased an openITCOCKPIT Enterprise Edition you can use this file
under the terms of the openITCOCKPIT Enterprise Edition licence agreement.
Licence agreement and licence key will be shipped with the order
confirmation.
```
