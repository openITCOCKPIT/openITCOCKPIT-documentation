# Updating openITCOCKPIT

Updates of openITCOCKPIT are done via the package manager of the used linux distribution.

This page describes how to update openITCOCKPIT itself - for example from version 5.8 to 5.9.
For an upgrade of the operating system use one of the guides below "Update", for example
[Update Debian Bookworm (12) to Debian Trixie (13)](debian-bookworm-to-trixie.md).

!!! danger "Backup"
    Before you start, make sure you have a **working backup** of your system!

!!! warning "E-Mail Configuration"
    If you made changes in e-mail configuration make sure to backup **/opt/openitc/frontend/config/email.php** before you update and restore it afterwards.

Please make sure to run all commands as `root` user.

## Ubuntu / Debian

Update package sources

```bash
apt update
```

Update

```bash
apt -y full-upgrade
```

## Red Hat Enterprise Linux

!!! danger
    openITCOCKPIT expects the Linux default umask to be set to `022` (default for most Linux distributions).
    If you are unsure change the umask to `022` before you continue with the update.

    ```bash
    umask 0022
    ```

Update package sources

```bash
dnf --refresh check-update
```

Update

```bash
dnf update
```
