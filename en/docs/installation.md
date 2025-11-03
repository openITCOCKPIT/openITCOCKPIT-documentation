# Installation

openITCOCKPIT is installed via the package manager of your respective Linux distribution.

## Supported operating systems

- Ubuntu
    - Noble (24.04)
    - Jammy (22.04)
- Debian
    - Trixie (13)
    - Bookworm (12)
- Enterprise Linux
    - Red Hat 9
    - Red Hat 8

## arm64 / Raspberry Pi
openITCOCKPIT and all components are also available for arm64 processors and the Raspberry Pi.

The installation is the same as for a 64-bit system with an AMD or Intel processor. If you want to use a Raspberry Pi system, the [64-Bit version of the Raspberry Pi OS](https://downloads.raspberrypi.org/raspios_arm64/images/) must be used.

## Adding the repository
### Ubuntu

```
add-apt-repository universe
apt-get install apt-transport-https curl gnupg2 ca-certificates

mkdir -p /etc/apt/keyrings
curl https://packages5.openitcockpit.io/repokey.txt | tee /etc/apt/keyrings/openitcockpit-keyring.asc
echo "deb [signed-by=/etc/apt/keyrings/openitcockpit-keyring.asc] https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/stable $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
apt-get update
```

#### Docker for Ubuntu

openITCOCKPIT requires Docker. Alternatively, you can follow the [official instructions](https://docs.docker.com/engine/install/ubuntu/).

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
```

### Debian

#### Trixie

Ensure you have enabled `contrib` and `non-free` repositories in `/etc/apt/sources.list.d/debian.sources`
```
Types: deb deb-src
URIs: mirror+file:///etc/apt/mirrors/debian.list
Suites: trixie trixie-updates trixie-backports
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb deb-src
URIs: mirror+file:///etc/apt/mirrors/debian-security.list
Suites: trixie-security
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
```

#### Bookworm

Ensure you have enabled `contrib` and `non-free` repositories in `/etc/apt/sources.list.d/debian.sources`
```
Types: deb deb-src
URIs: mirror+file:///etc/apt/mirrors/debian.list
Suites: bookworm bookworm-updates bookworm-backports
Components: main contrib non-free non-free-firmware

Types: deb deb-src
URIs: mirror+file:///etc/apt/mirrors/debian-security.list
Suites: bookworm-security
Components: main contrib non-free non-free-firmware
```


Enable openITCOCKPIT repository
```
apt-get install apt-transport-https curl gnupg2 ca-certificates

mkdir -p /etc/apt/keyrings
curl https://packages5.openitcockpit.io/repokey.txt | tee /etc/apt/keyrings/openitcockpit-keyring.asc
echo "deb [signed-by=/etc/apt/keyrings/openitcockpit-keyring.asc] https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/stable $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
apt-get update
```

#### Docker for Debian

openITCOCKPIT requires Docker. Alternatively, you can follow the [official instructions](https://docs.docker.com/engine/install/debian/).

```
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
```

## Installing openITCOCKPIT

!!! danger
    openITCOCKPIT expecteds the Linux default umask to be set to `022` (default for most Linux distributions).
    If you are unsure change the umask to `022` before you continue with the update.
    ```
    umask 0022
    ```

The actual installation is carried out by executing the following command:
```
apt-get install openitcockpit
```

You will now need to perform  the basic configuration. During this process, for example, the first user for the web interface will be created. The rest of the configuration is then carried out via the openITCOCKPIT web interface.

```
/opt/openitc/frontend/SETUP.sh
```

## Registering the openITCOCKPIT Community Edition

This step is optional and voluntary. You can expand your openITCOCKPIT installation's range of functions through the addition of modules. Several are available for free. In order to gain access to the community modules, you must first enter the openITCOCKPIT community key. To do this, click on `System -> Registration` and insert the following key: `e5aef99e-817b-0ff5-3f0e-140c1f342792`.

No further information is required.

![Valid license](/images/openITCOCKPIT-v4-valid-license.png){ align=center }

After being successfully activated, the community modules will be available under `System Tools -> Package Manager`.

## Installing phpMyAdmin

This step is optional and voluntary. The openITCOCKPIT system uses a MySQL database. Generally speaking, end users will not directly interact with the database. Experienced users, however, can install the `phpMyAdmin` tool for managing the database.

```
apt-get install phpmyadmin
```

The web server will be configured automatically. The phpMyAdmin interface can then be reached via `https://xxx.xxx.xxx.xxx/phpmyadmin`.

## System requirements

- Ubuntu Linux 64 bit,  Debian Linux 64 bit, RHEL 64 bit
- 2 CPU cores (x86-64 or arm64)
- 4 GB RAM
- 60 GB of free hard disk space
