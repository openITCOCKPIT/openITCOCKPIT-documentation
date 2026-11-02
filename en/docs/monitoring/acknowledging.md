# Acknowledging

Acknowledgement - Confirm status: temporarily suppresses status notifications

Depending on the configuration, notifications are sent for hosts and services in the event of a non-UP/OK status. Depending on the notification period and interval, this will occur as often and as long as the host or service remains in a non-UP/OK status or changes to another non-UP/OK status. These notifications can also be temporarily switched off - that is, for any currently displayed non-UP/OK status, these notifications will be stopped, but will be sent again as soon as the host or service is again in a non-UP/OK status or changes to another non-UP/OK status.

### Sticky

Sticky acknowledgements stop the default behaviour of acknowledgements by preventing any notifications until an UP/OK status is reached. If a non-UP/OK status other than the current one is reached, no further notifications will be sent.
Example:

A service changes from an OK to a CRITICAL status. If this critical status is confirmed **without** being sticky, notifications are suppressed as long as the service is in this critical status. If it changes to a WARNING status, notifications will be sent again. If the service has been confirmed **with** sticky, no notifications are sent until the service has again returned an OK status.

### Notify

The Notify option sends a notification to all contacts for the host or service informing them that the current host or service problem has been confirmed.

## Confirming host status

To confirm an individual host's status, navigate to `Monitoring -> Hosts` and click on the name of the corresponding host. Once in the Host Browser, click the `Confirm Host Status` option in the coloured status bar.

![ack host status in browser](/images/hostbrowser-ackstatus.png)

You can also select whether only the status of the host itself or the status of the host as well as its services should be confirmed. In addition, you can leave a comment and set the options [Sticky](#sticky) and [Notify](#notify).

![ack host](/images/ackhost.png)

### Confirming multiple host statuses

To confirm several hosts at the same time, navigate to `Monitoring -> Host`. In the Host list that appears, select the hosts you want to confirm. Then click the `More Actions` button at the end of the list and select `Confirm Status`.

![host mass ack](/images/host-mass-ack.png)

## Confirming service statuses

To confirm an individual service status, navigate to `Monitoring -> Services` and click on the name of the corresponding service. Once in the Service Browser, click on the `Confirm Service` Status option in the status coloured bar.

![ack service status in browser](/images/servicebrowser-ackstatus.png)

There you can leave a comment and set the [Sticky](#sticky) and [Notify](#notify) options.

![ack service](/images/ackservice.png)

### Confirming multiple service statuses

To confirm several services at the same time, navigate to `Monitoring -> Services`. In the service list, select the services you want to confirm. Then click the `More Actions` button at the end of the list and select `Confirm Status`.

![service mass ack](/images/service-mass-ack.png)
