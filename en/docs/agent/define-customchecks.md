# Define custom checks

openITCOCKPIT Monitoring Agent is 100% compatible to the
[Monitoring Plugins Development Guidelines](https://www.monitoring-plugins.org/doc/guidelines.html)
So you can use all monitoring plugins that work with: Naemon, Nagios, Shinken, Icinga 1 and Sensu

The idea behind custom checks is to provide an easy method to get a deeper monitoring of specialized services like Database Servers etc.

## Set path to customchecks.ini
By default the Agent will search for an `customchecks.ini` in [the default directory](/agent/debugging/#paths).

You can change the location in the `config.ini`

```ini
# Remote Plugin Execution
# Path to config will where custom checks can be defined
# Comment to use the default value
#
# Linux: /etc/openitcockpit-agent/customchecks.ini
# Windows: C:\Program Files\it-novum\openitcockpit-agent\customchecks.ini
# macOS: /Applications/openitcockpit-agent/customchecks.ini
customchecks = /etc/openitcockpit-agent/customchecks.ini
```

## Define custom checks
The [default customchecks.ini](https://github.com/openITCOCKPIT/openitcockpit-agent-go/blob/main/example/customchecks_example.ini) provides a huge variety of how to define custom checks on Linux, macOS and Windows. It covers Bash-Scripts, Powershell-Scripts and Binaries.

## Add custom checks to the monitoring
Open the openITCOCKPIT web interface and navigate to `openITCOCKPIT Agent -> Agents Overview -> Pull / Push` and select `Edit` from the drop down menu. Follow the instructions and select all custom checks at the step `Create services`
