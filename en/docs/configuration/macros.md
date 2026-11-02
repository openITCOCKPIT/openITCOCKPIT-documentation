# Macros

Macros are variables that can be used in openITCOCKPIT, for example to store path information for check plugins or login data.

Macros always begin and end with a $ sign.

## Custom macros

Custom macros are by far the most commonly used type of macros in openITCOCKPIT. The name of the macro is always `USER` followed by a number, for example `$USER1$`

This macro type is often used to store path information, passwords and SNMP communities.

It is possible to hide values, e.g. to not make passwords directly visible. To do this, either select the "Hide value" option when creating or editing a macro or click on the button on the overview page. 

![Screenshot: Custom macros](/images/UserDefinedMacros-hideValue.png)

![Overview about User defined macros](/images/UserDefinedMacros-Overview.png)

!!! info
    Up to 256 user-defined macros can be saved.

## Contact macros

Contact macros can be stored with contacts to save login data for a ticketing system or other use cases.
The macros always follow the structure `$_CONTACT<macro-name>$`

![Contact Macros](/images/contact-macros.png)

## Host Macros

Host macros can be stored directly in a host template or with an individual host. These are usually used to store SNMP communities or other access data that is only relevant for one host.

The macros always follow the structure `$_HOST<macro-name>$`
  
Macros inherited from the host template are shown in green. Those coloured blue mean the macro was configured directly on the host. 

![Host Macros](/images/host-macros.png)

Host macros are available both when running the host check and when running service checks on the host.

## Service macros

Service macros can be stored directly in a service template or together with an individual service. This is usually used to store access data that is only relevant for one service.

The macros always follow the structure `$_SERVICE<macro-name>$`
  
Macros inherited from the service template are shown in green. Those coloured blue mean the macro was configured directly on the service.

Service macros are only available when running a service check.

## Default Macros

In addition to the macros that users can define themselves, the system also provides a number of default macros.

| Macro                                                                 | Description                                                                                                                                                                            |
|-----------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Host macros                                                           |
| $HOSTNAME$                                                            | Host UUID ("1284b927-2bd2-4737-a3da-c39854376ca2")                                                                                                                                     |
| $HOSTDISPLAYNAME$                                                     | Human-readable name of host ("srvstorage01")                                                                                                                                           |
| $HOSTALIAS$                                                           | Human-readable name of host ("srvstorage01"), same as $HOSTDISPLAYNAME$                                                                                                                |
| $HOSTADDRESS$                                                         | Address or FQDN of the host. ("10.10.12.12")                                                                                                                                           |
| $HOSTSTATE$                                                           | Current host status as a string ("UP", "DOWN", or "UNREACHABLE").                                                                                                                      |
| $HOSTSTATEID$                                                         | Current host status as an integer (0=UP, 1=DOWN, 2=UNREACHABLE).                                                                                                                       |
| $LASTHOSTSTATE$                                                       | Last host status as a string ("UP", "DOWN", or "UNREACHABLE").                                                                                                                         |
| $LASTHOSTSTATEID$                                                     | Last host status as an integer (0=UP, 1=DOWN, 2=UNREACHABLE).                                                                                                                          |
| $HOSTSTATETYPE$                                                       | Current host status type as a string ("SOFT" or "HARD").                                                                                                                               |
| $HOSTATTEMPT$                                                         | Current checking attempt as an integer                                                                                                                                                 |
| $MAXHOSTATTEMPTS$                                                     | Maximum number of checking attempts                                                                                                                                                    |
| $HOSTEVENTID$                                                         | Number of status change events as a unique number per host                                                                                                                             |
| $LASTHOSTEVENTID$                                                     | Last unique host event number                                                                                                                                                          |
| $HOSTPROBLEMID$                                                       | Unique number of the current host problem status                                                                                                                                       |
| $LASTHOSTPROBLEMID$                                                   | Unique number of the last host problem status                                                                                                                                          |
| $HOSTLATENCY$                                                         | Delay between planned checking time and actual checking time as a float  ("2.05")                                                                                                      |
| $HOSTEXECUTIONTIME$                                                   | Plugin execution time as a float "4.21").                                                                                                                                              |
| $HOSTDURATION$                                                        | Time since last status change as a string (HH MM SS)                                                                                                                                   |
| $HOSTDURATIONSEC$                                                     | Time since last status change as an integer in seconds                                                                                                                                 |
| $HOSTDOWNTIME$                                                        | If the host is in a scheduled maintenance time, this value is >=1                                                                                                                      |
| $HOSTPERCENTCHANGE$                                                   | Percentage status change as a float (used by flap detection algorithm)                                                                                                                 |
| $HOSTGROUPNAME$                                                       | Contains the first host group of a host as a string ("12403d1a-70c0-468b-ad8d-446fb8412205")                                                                                           |
| $HOSTGROUPNAMES$                                                      | Comma-separated list of all host groups that a host belongs to ("12403d1a-70c0-468b-ad8d-446fb8412205,20a1bad7-60c1-433d-8e28-716cde8b8f04")                                           |
| $LASTHOSTCHECK$                                                       | Unix timestamp (integer) of the last host check                                                                                                                                        |
| $LASTHOSTSTATECHANGE$                                                 | Unix timestamp (integer) of the last state change                                                                                                                                      |
| $LASTHOSTUP$                                                          | Unix timestamp (integer) of last host UP status                                                                                                                                        |
| $LASTHOSTDOWN$                                                        | Unix timestamp (integer) of last host DOWN status                                                                                                                                      |
| $LASTHOSTUNREACHABLE$                                                 | Unix timestamp (integer) of last host UNREACHABLE status                                                                                                                               |
| $HOSTOUTPUT$                                                          | Output of the host check plugin ("OK - 127.5.6.7: rta 0.054ms, lost 0%")                                                                                                               |
| $LONGHOSTOUTPUT$                                                      | Long plugin output of the current host check                                                                                                                                           |
| $HOSTPERFDATA$                                                        | Performance data output of the current host check ("rta=0.054000ms;100.000000;500.000000;0.000000 pl=0%;20;60;0")                                                                      |
| $HOSTCHECKCOMMAND$                                                    | Contains the command UUID and the used command arguments ("5a538ebc-03de-4ce6-8e32-665b841abde3!3000.0.80%!4000.0.90%;")                                                               |
| $HOSTACTIONURL$                                                       | Not implemented in openITCOCKPIT                                                                                                                                                       |
| $HOSTNOTESURL$                                                        | Not implemented in openITCOCKPIT                                                                                                                                                       |
| $HOSTNOTES$                                                           | User-defined, custom notes for a host                                                                                                                                                  |
| $TOTALHOSTSERVICES$                                                   | Total number of services connected to the host                                                                                                                                         |
| $TOTALHOSTSERVICESOK$                                                 | Total number of services connected to the host with status OK                                                                                                                          |
| $TOTALHOSTSERVICESWARNING$                                            | Total number of services connected to the host with status WARNING                                                                                                                     |
| $TOTALHOSTSERVICESCRITICAL$                                           | Total number of services connected to the host with status CRITICAL                                                                                                                    |
| $TOTALHOSTSERVICESUNKNOWN$                                            | Total number of services connected to the host with status UNKNOWN                                                                                                                     |
| Host group macros                                                     |
| $HOSTGROUPALIAS$                                                      | The UUID of the host group ("fc11e1b9-9c0f-49d7-90b5-f283fe39a21d")                                                                                                                    |
| $HOSTGROUPMEMBERS$                                                    | Comma-separated list of host group members as UUIDs ("c7176869-ffb7-4149-b960-bdbf9ae85968,f5e943f3-c46f-4f6d-8fc1-468774a72332").                                                     |
| $HOSTGROUPNOTES$                                                      | Not implemented in openITCOCKPIT                                                                                                                                                       |
| $HOSTGROUPNOTESURL$                                                   | Not implemented in openITCOCKPIT                                                                                                                                                       |
| $HOSTGROUPACTIONURL$                                                  | Not implemented in openITCOCKPIT                                                                                                                                                       |
| Service Macros                                                        |
| $SERVICEDESC$                                                         | The UUID of the service ("bd19ce04-3209-4664-a146-bd1220e740bc")                                                                                                                       |
| $SERVICEDISPLAYNAME$                                                  | Human-readable name of the service ("PING")                                                                                                                                            |
| $SERVICESTATE$                                                        | Current service status as a string ("OK", "WARNING", "UNKNOWN", or "CRITICAL").                                                                                                        |
| $SERVICESTATEID$                                                      | Current service status as an integer (0=OK, 1=WARNING, 2=CRITICAL, 3=UNKNOWN).                                                                                                         |
| $LASTSERVICESTATE$                                                    | Last service status as a string ("OK", "WARNING", "UNKNOWN", or "CRITICAL").                                                                                                           |
| $LASTSERVICESTATEID$                                                  | Last service status as a string ("OK", "WARNING", "UNKNOWN", or "CRITICAL").                                                                                                           |
| $SERVICESTATETYPE$                                                    | Current service status type as a string ("SOFT" or "HARD").                                                                                                                            |
| $SERVICEATTEMPT$                                                      | Current checking attempt as an integer                                                                                                                                                 |
| $MAXSERVICEATTEMPTS$                                                  | Maximum number of service check attempts                                                                                                                                               |
| $SERVICEISVOLATILE$                                                   | Is volatile as integer (0=NO, 1=YES)                                                                                                                                                   |
| $SERVICEEVENTID$                                                      | Number of status change events as a unique number per service                                                                                                                          |
| $LASTSERVICEEVENTID$                                                  | Last unique service event number                                                                                                                                                       |
| $SERVICEPROBLEMID$                                                    | Unique number of the current service problem state                                                                                                                                     |
| $LASTSERVICEPROBLEMID$                                                | Unique number of the current service problem state                                                                                                                                     |
| $SERVICELATENCY$                                                      | Delay between planned checking time and actual checking time as a float ("2.05")                                                                                                       |
| $SERVICEEXECUTIONTIME$                                                | Plugin execution time as a float ("4.21").                                                                                                                                             |
| $SERVICEDURATION$                                                     | Time since last status change as a string (HH MM SS)                                                                                                                                   |
| $SERVICEDURATIONSEC$                                                  | Time since last status change as an integer in seconds                                                                                                                                 |
| $SERVICEDOWNTIME$                                                     | If the service is in a planned maintenance time, this value is >= 1                                                                                                                    |
| $SERVICEPERCENTCHANGE$                                                | Percentage of status change as a float (Used by flap detection algorithm)                                                                                                              |
| $SERVICEGROUPNAME$                                                    | Contains the first service group of a service as a string ("6123eb90-a3eb-4895-b348-c464d9494d14")                                                                                     |
| $SERVICEGROUPNAMES$                                                   | Comma-separated list of all service groups to which the service belongs ("6123eb90-a3eb-4895-b348-c464d9494d14,666b1caf-4c0f-45e8-9380-78f9e915b82d")                                  |
| $LASTSERVICECHECK$                                                    | Unix timestamp (integer) of the last service check                                                                                                                                     |
| $LASTSERVICESTATECHANGE$                                              | Unix timestamp (integer) of the last service state change                                                                                                                              |
| $LASTSERVICEOK$                                                       | Unix timestamp (integer) of the last service OK status                                                                                                                                 |
| $LASTSERVICEWARNING$                                                  | Unix timestamp (integer) of the last service WARNING status                                                                                                                            |
| $LASTSERVICECRITICAL$                                                 | Unix timestamp (integer) of the last service CRITICAL status                                                                                                                           |
| $LASTSERVICEUNKNOWN$                                                  | Unix timestamp (integer) of last service UNKNOWN status                                                                                                                                |
| $SERVICEOUTPUT$                                                       | Output of the service check plugin ("OK - 127.5.6.7: rta 0.054ms, lost 0%")                                                                                                            |
| $LONGSERVICEOUTPUT$                                                   | Long plugin output of the current service check                                                                                                                                        |
| $SERVICEPERFDATA$                                                     | Performance data output of the current service check ("rta=0.054000ms;100.000000;500.000000;0.000000 pl=0%;20;60;0")                                                                   |
| $SERVICECHECKCOMMAND$                                                 | Contains the command UUID and its arguments ("5a538ebc-03de-4ce6-8e32-665b841abde3!3000.0.80%!4000.0.90%;")                                                                            |
| $SERVICEACTIONURL$                                                    | Not implemented in openITCOCKPIT                                                                                                                                                       |
| $SERVICENOTESURL$                                                     | Not implemented in openITCOCKPIT                                                                                                                                                       |
| $SERVICENOTES$                                                        | Custom notes for service                                                                                                                                                               |
| Service group macros                                                  |
| $SERVICEGROUPALIAS$                                                   | Host Group UUID ("65c7692e-b322-4788-8232-97258b457f22")                                                                                                                               |
| $SERVICEGROUPMEMBERS$                                                 | Comma-separated list of service group members as UUIDs ("0a9feda1-569e-40fe-a5a3-b2f389818301,ade06bfb-f9bd-4112-9537-2b3d286a6572")                                                   |
| $SERVICEGROUPNOTES$                                                   | Not implemented in openITCOCKPIT                                                                                                                                                       |
| $SERVICEGROUPNOTESURL$                                                | Not implemented in openITCOCKPIT                                                                                                                                                       |
| $SERVICEGROUPNOTES$                                                   | Not implemented in openITCOCKPIT                                                                                                                                                       |
| Contact macros                                                        |
| $CONTACTNAME$                                                         | Contact UUID ("9595f7d6-2b79-4a7b-b7b8-414eec84c0b0")                                                                                                                                  |
| $CONTACTGROUPNAME$                                                    | Human-readable name of the contact ("info")                                                                                                                                            |
| $CONTACTALIAS$                                                        | Human-readable name of the contact ("info"), same as $CONTACTGROUPNAME$                                                                                                                |
| $CONTACTEMAIL$                                                        | Contact's email address ("community@openitcockpit.io")                                                                                                                                 |
| $CONTACTPAGER$                                                        | Contact's pager number ("004913456789")                                                                                                                                                |
| $CONTACTGROUPNAMES$                                                   | Comma-separated list of all contact groups to which the contact belongs. ("06e352a8-643d-4fa8-a7bd-9ff74ad0e112,4992c7ad-1bb4-465a-8fe4-a721461b69a2")                                 |
| Contact group macros                                                  |
| $CONTACTGROUPALIAS$                                                   | Contact Group UUID ("06e352a8-643d-4fa8-a7bd-9ff74ad0e112")                                                                                                                            |
| $CONTACTGROUPMEMBERS$                                                 | Comma-separated list of all contacts belonging to the contact group. ("9595f7d6-2b79-4a7b-b7b8-414eec84c0b0,6de7d0f9-413e-41cc-b1e4-3289072b72c4")                                     |
| Summary macros (INFO: CPU-intensive to calculate - use with caution!) |
| $TOTALHOSTSUP$                                                        | Number of hosts in UP state                                                                                                                                                            |
| $TOTALHOSTSDOWN$                                                      | Number of hosts in DOWN state                                                                                                                                                          |
| $TOTALHOSTSUNREACHABLE$                                               | Number of hosts in UNREACHABLE state                                                                                                                                                   |
| $TOTALHOSTSDOWNUNHANDLED$                                             | Number of unhandled hosts. Unhandled hosts are in a DOWN state and not acknowledged or in scheduled maintenance time                                                                   |
| $TOTALHOSTSUNREACHABLEUNHANDLED$                                      | Number of unhandled hosts. Unhandled hosts are in an UNREACHABLE status and not acknowledged or in scheduled maintenance                                                               |
| $TOTALHOSTPROBLEMS$                                                   | Number of hosts in a non-UP state                                                                                                                                                      |
| $TOTALHOSTPROBLEMSUNHANDLED$                                          | Number of unhandled hosts. Unhandled hosts are in a non-UP status and not acknowledged or in scheduled maintenance                                                                     |
| $TOTALSERVICESOK$                                                     | Number of services with status OK                                                                                                                                                      |
| $TOTALSERVICESWARNING$                                                | Number of services with status WARNING                                                                                                                                                 |
| $TOTALSERVICESCRITICAL$                                               | Number of services with status CRITICAL                                                                                                                                                |
| $TOTALSERVICESUNKNOWN$                                                | Number of services with status UNKNOWN                                                                                                                                                 |
| $TOTALSERVICESWARNINGUNHANDLED$                                       | Number of unhandled services. Unhandled services are in a WARNING status and not confirmed or in scheduled maintenance                                                                 |
| $TOTALSERVICESCRITICALUNHANDLED$                                      | Number of unhandled services. Unhandled services are in a CRITICAL status and not confirmed or in scheduled maintenance                                                                |
| $TOTALSERVICESUNKNOWNUNHANDLED$                                       | Number of unhandled services. Unhandled services are in an UNKNOWN state and not confirmed or in scheduled maintenance time.                                                           |
| $TOTALSERVICEPROBLEMS$                                                | Number of services in a non-OK state.                                                                                                                                                  |
| $TOTALSERVICEPROBLEMSUNHANDLED$                                       | Number of unhandled services. Unhandled services are in a non-OK state and not confirmed or in scheduled maintenance time.                                                             |
| Benachrichtigungsmakros                                               |
| $NOTIFICATIONTYPE$                                                    | Notification type as a string ("PROBLEM", "RECOVERY", "ACKNOWLEDGEMENT", "FLAPPINGSTART", "FLAPPINGSTOP", "FLAPPINGDISABLED", "DOWNTIMESTART", "DOWNTIMEEND", or "DOWNTIMECANCELLED"). |
| $NOTIFICATIONRECIPIENTS$                                              | Comma separated list of all contacts for this notification ("12403d1a-70c0-468b-ad8d-446fb8412205,20a1bad7-60c1-433d-8e28-716cde8b8f04"))                                              |
| $NOTIFICATIONISESCALATED$                                             | Has this notification been escalated (0=NO, 1=YES)?                                                                                                                                    |
| $NOTIFICATIONAUTHOR$                                                  | openITCOCKPIT username as a string                                                                                                                                                     |
| $NOTIFICATIONAUTHORNAME$                                              | openITCOCKPIT username as a string                                                                                                                                                     |
| $NOTIFICATIONAUTHORALIAS$                                             | openITCOCKPIT username as a string                                                                                                                                                     |
| $NOTIFICATIONCOMMENT$                                                 | Notification comment data                                                                                                                                                              |
| $HOSTNOTIFICATIONNUMBER$                                              | Number of notifications sent for a host. If the host goes into RECOVERY state, the counter is reset to 0                                                                               |
| $HOSTNOTIFICATIONID$                                                  | Unique event number for the host notification                                                                                                                                          |
| $SERVICENOTIFICATIONNUMBER$                                           | Number of notifications sent for a service. If the service changes to an OK status, the counter is reset to 0                                                                          |
| $SERVICENOTIFICATIONID$                                               | Unique event number for the service notification                                                                                                                                       |
| Date and time macros                                                  |
| $DATE$                                                                | Current date as a string (DD-MM-YYYY)                                                                                                                                                  |
| $TIME$                                                                | Current time as a string (HH:MM:SS)                                                                                                                                                    |
| $TIMET$                                                               | Current time as UNIX timestamp                                                                                                                                                         |
