# Run Agent Service as normal user

This document describes to change the user account used by the openITCOCKPIT Monitoring Agent

## Linux

First of all you need to stop the openITCOCKPIT Monitoring Agent.
```bash
systemctl stop openitcockpit-agent.service
```

Now edit the Systemd service definition
```bash
systemctl edit --full openitcockpit-agent.service
```

Replace the `root` user with a non-privileged user of your choice like `monitoring` for example.

Then adjust the permissions on the agent folders and restart the agent

```bash
chown -R monitoring: /etc/openitcockpit-agent/
chown -R monitoring: /var/log/openitcockpit-agent/

systemctl start openitcockpit-agent.service
```



## Windows

### Folder Permissions

1. Open File Explorer
2. Change to `C:\Program Files\`
3. right click on folder `openitcockpit` (or `it-novum` for legacy installations)
4. Go to Properties -> Security -> Advanced 
5. Change Owner to the user which should run the Agent Services

### Perflib Permissions

To be able to access Performance Values, you need to add the user which should run the Agent Service
into the Group "Performance Monitor Users"

### Configuration of Windows Service

1. Open Windows Services
2. right click on the `openITCOCKPIT Agent` service
3. Go to Properties -> Log On
4. Change user to the user which should run the Agent Services

Finally restart the Agent Service
