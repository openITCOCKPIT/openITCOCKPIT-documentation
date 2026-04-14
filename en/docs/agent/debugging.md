# Debugging

## Paths
### Linux
```
/etc/openitcockpit-agent/
/var/log/openitcockpit-agent/
```

### macOS
```
/Applications/openitcockpit-agent/
/Library/Logs/openitcockpit-agent/
```

### Windows
```
C:\Program Files\openitcockpit\openitcockpit-agent
```

Legacy path before version 3.6.0:
```
C:\Program Files\it-novum\openitcockpit-agent
```

Registry:
```
HKEY_LOCAL_MACHINE\SOFTWARE\openitcockpit\
```

Legacy path before version 3.6.0:
```
HKEY_LOCAL_MACHINE\SOFTWARE\it-novum\
```

## Start in foreground

### Linux
```
sudo systemctl stop openitcockpit-agent

sudo /usr/bin/openitcockpit-agent --config /etc/openitcockpit-agent/config.ini --log /tmp/agent.log --verbose --debug
```


### macOS
```
sudo su
/bin/launchctl stop io.openitcockpit.agent

/Applications/openitcockpit-agent/openitcockpit-agent --config /Applications/openitcockpit-agent/config.ini --log /tmp/agent.log --verbose --debug
```

Legacy command before version 3.6.0:
```
sudo /bin/launchctl stop com.it-novum.openitcockpit.agent
```

### Windows
Open a new `PowerShell` window. Administrator privileges are not required but recommended. Please see [Windows Service Configuration](/agent/windows-service/) how to enable `Verbose` and `Debug` options.

```ps1
cd "C:\Program Files\openitcockpit\openitcockpit-agent"
Stop-Service -Name openITCOCKPITAgent

$env:OITC_AGENT_DEBUG="1"
.\openitcockpit-agent.exe -c "$PWD\config.ini" -l "$env:TEMP\agent.log" --debug --verbose
```

## Query the Agent - Pull Mode with enabled AutoTLS
You can run this curl command on the openITCOCKPIT Monitoring Server to send an request to the Agent.
```
curl -k -v https://xxx.xxx.xxx.xxx:3333 --cacert /opt/openitc/agent/server_ca.pem --key /opt/openitc/agent/server_ca.key --cert /opt/openitc/agent/server_ca.pem
```

## Manual query and process check results - Pull Mode
You can run this command on the openITCOCKPIT Monitoring Server to send an request to the Agent and pass all check results to the Monitoring Engine

```
/opt/openitc/receiver/bin/poller.php poller -H <Host-UUID> -c /opt/openitc/receiver/etc/production.json --verbose
```

If you don't want to pass the check results to the Monitoring Engine add the option `--dryrun`

## Access submitted data - Push Mode
Open the openITCOCKPIT web interface and navigate to `openITCOCKPIT Agent -> Agents Overview -> Push` and select `Show received data` from the drop down menu.

If the entire Agent is missing from the list, please check the log file of the Agent for any errors.


## Windows Management Instrumentation (WMI)

On Windows Systems, the openITCOCKPIT Monitoring Agent relies on WMI to query system metrics. It is important that WMI is enabled and operational (default behavior).

In rare cases, the Agent faces some errors such as `could not query wmi for process perfdata list: Exception occurred. (Invalid query )` or `Win32_PerfFormattedData_PerfOS_Processor: WMI: Invalid class`.

First you should try to query WMI manually through PowerShell.
```powershell
Get-WmiObject Win32_PerfFormattedData_PerfOS_Processor
```

If this fails with an error message, you can restore the Windows Performance Counter settings to the defaults.

1. Open a CMD.

2. Restore Windows Performance Counter settings
```cmd
lodctr /R
```

3. Resync the counters with Windows Management Instrumentation (WMI):
```cmd
WINMGMT /RESYNCPERF
```

4. Restart the openITCOCKPIT Monitoring Agent Service.
