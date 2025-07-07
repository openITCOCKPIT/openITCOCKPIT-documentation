# Monitoring with the openITCOCKPIT agent

Monitoring a host's basic parameters should never be a difficult or tedious task.
The [openITCOCKPIT Monitoring Agent](https://openitcockpit.io/download_agent/) is available for Windows, Linux and macOS
and is able to collect metrics such as CPU, memory, disk usage, network status, temperatures etc. right out-of-the-box.

The openITCOCKPIT Monitoring Agent is adaptable and expandable because it is 100% compatible with the Nagios plugin API.
Therefore, no additional software like NRPE or check_by_ssh is needed to run plugins on the target system.

Communication is encrypted by HTTPS by default.

## Downloading and installing the openITCOCKPIT Monitoring Agent

Before you start, install the openITCOCKPIT Monitoring Agent on the target system you want to monitor.

To download the agent, we recommend using the [official download site](https://openitcockpit.io/download_agent/).

The source code is available via the GitHub repository: :fontawesome-brands-github: [https://github.com/openITCOCKPIT/openitcockpit-agent-go](https://github.com/openITCOCKPIT/openitcockpit-agent-go)

## Monitoring a host with the openITCOCKPIT Monitoring Agent

In the context menu of the hosts, select the option :fontawesome-solid-user-secret: openITCOCKPIT Agent Discovery.

![select agent discovery](/images/select-agent-discovery.png)

A wizard-based configuration process will guide you through all the steps.

### The main differences between push and pull mode

Before you begin, you need to decide whether you want to monitor your host in push or pull mode.

- In **Pull** mode, the openITCOCKPIT **server** connects regularly via HTTPS on port `3333` **to the agent** and
  fetches the verification results
- In **Push** mode, the openITCOCKPIT monitoring **agent** connects regularly and "pushes" its monitoring results via
  HTTPS on port 443 **to** the openITCOCKPIT **server**. This is perfect if your target system is behind a NAT.

## Pull mode

Both modes are easy to set up. For purposes of this tutorial we will use **Pull mode**. Click here
for [Push mode](#push-mode)

![push or pull](/images/agent-push-or-pull.png)

The second step is basically a graphical configuration generator used for modifying the openITCOCKPIT Monitoring Agent
configuration file. You just need to select the operating system you want to monitor and then click the "Next" button.

!!! info
    "Connection Type: Auto-TLS"
    It is strongly recommended that you select Auto-TLS as the connection type. This will automatically secure and encrypt
    the connection between the openITCOCKPIT Server and the openITCOCKPIT Monitoring Agent. More information about the
    security of the openITCOCKPIT Monitoring Agent can be found in
    the [documentation](https://github.com/openITCOCKPIT/openitcockpit-agent-go/wiki/Agent-Overview).

![pull config](/images/agent-basic-pull-configuration.png)

In the third step, you will be shown where you can [download](https://openitcockpit.io/download_agent/) the
openITCOCKPIT Monitoring Agent and store the configuration file.

For the purposes of this tutorial, you can continue using the default configuration. For our next step, click on the "
Next" button.

![agent install config](/images/agent-install-config.png)

The openITCOCKPIT Server will connect to the openITCOCKPIT Monitoring Agent on the target system and perform a TLS
certificate exchange. A unique certificate is generated for each openITCOCKPIT Monitoring Agent. This certificate is
required for encryption and authentication purposes.

Click "Next" to continue.

![cert exchange](/images/certificate-exchange.png)

The system will collect basic health metrics like CPU, memory and swap by default. You can, of course, also select other
processes and services that you want to monitor. Once you have selected the desired services, click on "Done" to
complete the openITCOCKPIT Monitoring Agent setup.

![create services](/images/agent-create-services.png)

The last step will remind you to update the monitoring configuration. Please click
on [Update monitoring configuration](../create-first-host/#updating-the-monitoring-configuration)

![services create successfully](/images/agent-services-created-successfully.png)

Once this has been done, the system will begin monitoring the selected services a few seconds later. It will also
generate graphs whenever this is possible.

![agent services monitored](/images/agent-services-monitored.png)

## Determining host status (optional)

By default, openITCOCKPIT will ping the target system to determine the host status. However, instead of a ping it is
possible to use the results of the openITCOCKPIT Monitoring Agent to determine the host status. For more information,
please see the
documentation: [https://github.com/openITCOCKPIT/openitcockpit-agent-go/wiki/Determining-the-host-status](https://github.com/openITCOCKPIT/openitcockpit-agent-go/wiki/Determining-the-host-status)

## Push mode

Select Push mode to continue.

![agent push or pull use push](/images/agent-push-or-pull-use-push.png)

The second step is basically a graphical configuration generator used for modifying the openITCOCKPIT Monitoring Agent
configuration file. You just need to select the operating system you want to monitor and then click the "Next" button.

Enter the public IP address or FQDN of your openITCOCKPIT server in the `openITCOCKPIT server address` field and enter
the API key that the agent should use in the `openITCOCKPIT API key` field.

Click `Next` to continue.

!!! danger "Security Note!"
    It is strongly recommended to create a new user with very few privileges and use an API key for unprivileged users. No
    special authorisations via user roles are required to transfer check results.

![agent push config](/images/agent-basic-push-configuration.png)

In the third step, you will be shown where you can [download](https://openitcockpit.io/download_agent/) the
openITCOCKPIT Monitoring Agent and store the configuration file.

Copy the configuration file displayed to the specified path and restart the openITCOCKPIT Monitoring Agent service. The
commands and file paths will depend on the operating system used. Click `Next` to continue.

![agent config push](/images/agent-install-config-push.png)

Each agent sends a unique identifier to the openITCOCKPIT server. To prevent unauthorised agents from submitting check
results, all agents running in Push mode must be manually assigned to a host. Click `Next` to continue.

![host to agent mapping](/images/map-host-to-agent.png)

The system will collect basic health metrics like CPU, memory and swap by default. You can, of course, also select other
processes and services that you want to monitor. Once you have selected the desired services, click on "Done" to
complete the openITCOCKPIT Monitoring Agent Setup.

!!! Info
    Because the agent runs in push mode, it is possible that openITCOCKPIT will not have received any data yet and
    therefore will not display any services. If this is the case, click :fontawesome-solid-arrow-left: to return to the
    previous step, wait 30 seconds, and then click the `Next` button again.

![create services push](/images/agent-create-services-push.png)

The last step will remind you to update the monitoring configuration. Please click
on [Update monitoring configuration](../create-first-host/#updating-the-monitoring-configuration)

![services created push export](/images/agent-services-created-successfully-push.png)

Once this has been done, the system will begin monitoring the selected services a few seconds later. It will also
generate graphs whenever this is possible.

![agent services monitored push](/images/agent-services-monitored-push.png)

## Determining host status (optional but recommended)

By default, openITCOCKPIT will ping the target system to determine the host status. However, in most cases it is not
possible to ping the target system when using Push mode.

Because of this, please edit the host and select the host template `openITCOCKPIT Agent - Push` and save. Don't forget
to update (export) the monitoring engine configuration after you have completed this step.

openITCOCKPIT will now evaluate the timestamp for the last message received from the openITCOCKPIT Monitoring Agent and
determine whether the host is available or not.

For more information, please see the
documentation: [https://github.com/openITCOCKPIT/openitcockpit-agent-go/wiki/Determining-the-host-status](https://github.com/openITCOCKPIT/openitcockpit-agent-go/wiki/Determining-the-host-status)

![agent push host status](/images/agent-push-host-status.png)
