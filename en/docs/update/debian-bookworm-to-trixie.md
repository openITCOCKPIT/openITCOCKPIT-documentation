# Upgrade from Debian Bookworm (12) to Debian Trixie (13)

!!! danger "Backup"
    Before you begin, make sure you have created a **working backup** of your system!

Run all commands as the `root` user.

To always use the latest version of openITCOCKPIT, it is important to keep the underlying operating system up to date.  
With this guide, you can upgrade your Debian Bookworm system to Debian Trixie.

---

## Requirements
- openITCOCKPIT version 5.x
- No packages containing `lxd`
- Internet access to download Docker repository keys

---

## Remove all `lxd` packages
If `lxd` packages are installed on your system, they must be removed first. You can check with:

```bash
apt list --installed | grep lxd
```

If packages are installed, remove them with:

```bash
apt -y remove lxd*
```

---

## Add Docker repository
To install Docker from the official sources, the repository must be added:

```bash
# Create keyring directory
install -d -m 0755 /etc/apt/keyrings

# Store Docker GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc

# Add repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
| tee /etc/apt/sources.list.d/docker.list > /dev/null
```

---

## Install all updates (still on Bookworm)
Before starting the upgrade to Debian Trixie, make sure all available updates are installed:

```bash
apt update
apt -y full-upgrade
```

---

## Stop PHP-FPM service
Before the upgrade, PHP-FPM 8.2 should be stopped to avoid conflicts:

```bash
systemctl stop php8.2-fpm.service
```

---

## Identify openITCOCKPIT packages
Next, gather all installed openITCOCKPIT packages and store them in a variable:

```bash
openitcockpit_upd=$(apt-mark showmanual | grep openitcockpit | xargs echo)" "$(apt-mark showauto | grep openitcockpit | xargs echo)
```

---

## Update package sources
The Debian package sources now need to be adjusted to the new Trixie release:

```bash
sed -i 's/bookworm/trixie/g' /etc/apt/sources.list /etc/apt/sources.list.d/*.list
sed -ri 's/\bbookworm-security\b/trixie-security/g; s/\bbookworm-updates\b/trixie-updates/g; s/\bbookworm\b/trixie/g' /etc/apt/sources.list.d/debian.sources
```

---

## Perform the upgrade
Now start the actual upgrade:

```bash
apt update

# Simulation (check only)
apt -s full-upgrade $openitcockpit_upd

# Perform the upgrade
apt -y full-upgrade $openitcockpit_upd
```

---

## Remove unnecessary packages
```bash
apt autoremove
```

---

## Start PHP after the upgrade
```bash
systemctl restart php8.4-fpm.service
```

---

## Update configuration
As the last step, update and regenerate all configuration files if needed.

### openITCOCKPIT Master
If you are performing the update on an openITCOCKPIT Master system, use the following command:
```
openitcockpit-update --cc
```

### openITCOCKPIT Satellite
On an openITCOCKPIT Satellite, use the following command:
```
/opt/openitc/frontend/UPDATE.sh
```

---

## Reboot
To complete the update, a reboot is recommended:
```bash
reboot
```
