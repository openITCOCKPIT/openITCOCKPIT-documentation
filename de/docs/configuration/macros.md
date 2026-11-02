# Makros

Makros sind Variablen, die in openITCOCKPIT genutzt werden können um zum Beispiel Pfadangaben zu Checkplugins oder Logindaten zu speichern.

Makros beginnen und enden immer mit einem $-Zeichen.

## Benutzerdefinierte Makros

Benutzerdefinierte Makros sind der mit Abstand am häufigsten verwendete Type von Makros in openITCOCKPIT.
Der Name der Makros ist immer `USER` gefolgt von einer Zahl, zum Beispiel `$USER1$`

Dieser Makro Type wird häuft zum Speichern von Pfadangaben, Kennwörter und SNMP Communities genutzt.


Es besteht die Möglichkeit Werte auszublenden, um z.B. Passwörter nicht direkt sichtbar zu machen. Dazu wählt man entweder beim Erstellen oder editieren von einem Makro die Option "Wert verstecken" an oder klickt auf der Übersichtsseite die Schaltfläche.
![Screenshot: Benutzerdefinierte Makros](/images/UserDefinedMacros-hideValue.png)

![Overview about User defined macros](/images/UserDefinedMacros-Overview.png)

!!! info
    Es können bis zu 256 benutzerdefinierte Makros gespeichert werden.

## Kontakt Makros
Kontakt Makros können bei Kontakten hinterlegt werden Logindaten für ein Ticketsystem, oder andere Anwendungsfälle, zu speichern.

Die Makros folgen immer dem Aufbau `$_CONTACT<macro-name>$ `

![Contact Macros](/images/contact-macros.png)

## Host Makros

Host Makros können zum einen direkt in einer Hostvorlage, oder bei einem einzelnen Host hinterlegt werden. In der Regel wird dies genutzt,
um SNMP Communities oder andere Zugangsdaten zu speichern, welche nur für einen Host relevant sind.

Die Makros folgen immer dem Aufbau `$_HOST<macro-name>$ `

Makros welche von der Hostvorlage vererbt wurden, werden in grüner Farbe dargestellt. Blau bedeutet das Makro wurde direkt im Host konfiguriert.
![Host Macros](/images/host-macros.png)

Host Makros stehen sowohl beim Ausführen des Host-Checks, also auch beim Ausführen von Service-Checks des Hosts zur Verfügung.

## Service Makros

Service Makros können zum einen direkt in einer Servicevorlage, oder bei einem einzelnen Service hinterlegt werden. In der Regel wird dies genutzt,
um Zugangsdaten zu speichern, welche nur für einen Service relevant sind.

Die Makros folgen immer dem Aufbau `$_SERVICE<macro-name>$ `

Makros welche von der Servicevorlage vererbt wurden, werden in grüner Farbe dargestellt. Blau bedeutet das Makro wurde direkt im Service konfiguriert.

Service Makros stehen nur beim Ausführen des Service-Checks zur Verfügung.


## Standard Makros

Neben den Makros die vom Benutzer selbst definiert werden können, stellt das System eine Reihe von standard Markos zur Verfügung.

| Makro                       | Beschreibung                                                                                                                                 |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
|Host Makros|
| $HOSTNAME$                  | UUID des Host ("1284b927-2bd2-4737-a3da-c39854376ca2")                                                                               |
| $HOSTDISPLAYNAME$           | Lesbarer Name des Host ("srvstorage01")                                                                                                 |
| $HOSTALIAS$                 | Lesbarer Name des Host ("srvstorage01"), dasselbe wie $HOSTDISPLAYNAME$                                                                      |
| $HOSTADDRESS$               | Adresse oder FQDN des Host. ("10.10.12.12")                                                                                                |
| $HOSTSTATE$                 | Aktueller Host Status als String ("UP", "DOWN", or "UNREACHABLE").                                                                              |
| $HOSTSTATEID$               | Aktueller Host Status als Integer (0=UP, 1=DOWN, 2=UNREACHABLE).                                                                                |
| $LASTHOSTSTATE$             | Letzter Host Status als String ("UP", "DOWN", or "UNREACHABLE").                                                                                 |
| $LASTHOSTSTATEID$           | Letzter Host Status als Integer (0=UP, 1=DOWN, 2=UNREACHABLE).                                                                                   |
| $HOSTSTATETYPE$             | Aktueller Host Status Typ als String ("SOFT" or "HARD").                                                                                       |
| $HOSTATTEMPT$               | Aktueller Prüfversuch als Integer                                                                                                            |
| $MAXHOSTATTEMPTS$           | Maximale anzahl der Prüfversuche                                                                                                          |
| $HOSTEVENTID$               | Anzahl der Statuswechsel events als eindeutige nummer pro Host                                                                                    |
| $LASTHOSTEVENTID$           | Letzte eindeutige Host event nummer                                                                                                              |
| $HOSTPROBLEMID$             | Eindeutige nummer des aktuellen Host Problem Status                                                                                            |
| $LASTHOSTPROBLEMID$         | Eindeutige nummer des letzten Host Problem Status                                                                                              |
| $HOSTLATENCY$               | Verzögerung zwischen geplanter Prüfzeit und tatsächlicher Prüfzeit als Float. ("2.05")                                                        |
| $HOSTEXECUTIONTIME$         | Plugin Ausführungszeit als Float. ("4.21").                                                                                          |
| $HOSTDURATION$              | Zeit seit letztem Statuswechsel als String (HH MM SS)                                                                                   |
| $HOSTDURATIONSEC$           | Zeit seit letztem Statuswechsel als Integer in Sekunden                                                                                  |
| $HOSTDOWNTIME$              | Ist der Host in einer geplanten Wartungszeit, ist dieser wert >=1                                                                             |
| $HOSTPERCENTCHANGE$         | Statuswechsel prozentual als Float (Wird von Flattererkennungs-Algorithmus genutzt)                                                 |
| $HOSTGROUPNAME$             | Beinhaltet die erste Hostgruppe eines Hosts als String ("12403d1a-70c0-468b-ad8d-446fb8412205")                                                 |
| $HOSTGROUPNAMES$            | Kommaseparierte liste aller Hostgruppen denen ein Host angehört ("12403d1a-70c0-468b-ad8d-446fb8412205,20a1bad7-60c1-433d-8e28-716cde8b8f04")|
| $LASTHOSTCHECK$             | Unix timestamp (Integer) des letzten host check.                                                                                            |
| $LASTHOSTSTATECHANGE$       | Unix timestamp (Integer) des letzten Statuswechsel.                                                                                         |
| $LASTHOSTUP$                | Unix timestamp (Integer) des letzten host UP Status.                                                                                         |
| $LASTHOSTDOWN$              | Unix timestamp (Integer) des letzten host DOWN Status.                                                                                       |
| $LASTHOSTUNREACHABLE$       | Unix timestamp (Integer) des letzten host UNREACHABLE Status.                                                                                |
| $HOSTOUTPUT$                | Output des Host check plugin ("OK - 127.5.6.7: rta 0,054ms, lost 0% ").                                                                      |
| $LONGHOSTOUTPUT$            | Long plugin output des aktuellen Host check.                                                                                               |
| $HOSTPERFDATA$              | Performance data output des aktuellen Host check. ("rta=0.054000ms;100.000000;500.000000;0.000000 pl=0%;20;60;0")                              |
| $HOSTCHECKCOMMAND$          | Enthält die Kommando UUID und die genutzten Kommando Argumente ("5a538ebc-03de-4ce6-8e32-665b841abde3!3000.0,80%!4000.0,90%;")                  |
| $HOSTACTIONURL$             | Nicht Implementiert in openITCOCKPIT.                                                                                                           |
| $HOSTNOTESURL$              | Nicht Implementiert in openITCOCKPIT.                                                                                                           |
| $HOSTNOTES$                 | Benutzerdefinierte Notizen für einen Host.                                                                                                             |
| $TOTALHOSTSERVICES$         | Gesamt Anzahl an Services die mit dem Host verbunden sind                                                                                         |
| $TOTALHOSTSERVICESOK$       | Gesamt Anzahl an Services die mit dem Host verbunden sind im Status OK                                                                              |
| $TOTALHOSTSERVICESWARNING$  | Gesamt Anzahl an Services die mit dem Host verbunden sind im Status WARNING                                                                        |
| $TOTALHOSTSERVICESCRITICAL$ | Gesamt Anzahl an Services die mit dem Host verbunden sind im Status CRITICAL                                                                       |
| $TOTALHOSTSERVICESUNKNOWN$  | Gesamt Anzahl an Services die mit dem Host verbunden sind im Status UNKNOWN                                                                        |
|Hostgruppen Makros|
| $HOSTGROUPALIAS$     | Die UUID der Hostgruppe ("fc11e1b9-9c0f-49d7-90b5-f283fe39a21d")                                                                     |
| $HOSTGROUPMEMBERS$   | Kommaseparierte Liste der Hostgruppen Mitglieder als UUIDs ("c7176869-ffb7-4149-b960-bdbf9ae85968,f5e943f3-c46f-4f6d-8fc1-468774a72332"). |
| $HOSTGROUPNOTES$     | Nicht Implementiert in openITCOCKPIT.                                                                                                       |
| $HOSTGROUPNOTESURL$  | Nicht Implementiert in openITCOCKPIT.                                                                                                       |
| $HOSTGROUPACTIONURL$ | Nicht Implementiert in openITCOCKPIT.                                                                                                       |
|Service Makros|
| $SERVICEDESC$            | Die UUID des Service ("bd19ce04-3209-4664-a146-bd1220e740bc")                                                                                  |
| $SERVICEDISPLAYNAME$            | Lesbarer Name des Service ("PING")                                                                                                            |
| $SERVICESTATE$           | Aktueller Service Status als String  ("OK", "WARNING", "UNKNOWN", or "CRITICAL").                                                                     |
| $SERVICESTATEID$         | Aktueller Service Status als Integer (0=OK, 1=WARNING, 2=CRITICAL, 3=UNKNOWN).                                                                        |
| $LASTSERVICESTATE$       | Letzter Service Status als String ("OK", "WARNING", "UNKNOWN", or "CRITICAL").                                                                         |
| $LASTSERVICESTATEID$     | Letzter Service Status als Integer (0=OK, 1=WARNING, 2=CRITICAL, 3=UNKNOWN).                                                                           |
| $SERVICESTATETYPE$       | Aktueller Service Status typ als String ("SOFT" or "HARD").                                                                                          |
| $SERVICEATTEMPT$         | Aktueller Prüfversuch als Integer.                                                                                                                  |
| $MAXSERVICEATTEMPTS$     | Maximale Anzahl an Service Prüfversuchen                                                                                                             |
| $SERVICEISVOLATILE$      | Ist Flüchtig als Integer (0=NO, 1=YES)                                                                                                             |
| $SERVICEEVENTID$         | Anzahl der Statuswechsel events als eindeutige Nummer pro Service                                                                                      |
| $LASTSERVICEEVENTID$     | Letzte eindeutige Service event Nummer                                                                                                                |
| $SERVICEPROBLEMID$       | Eindeutige Nummer des aktuellen Service problem states                                                                                              |
| $LASTSERVICEPROBLEMID$   | Eindeutige Nummer des letzten Service problem states                                                                                                |
| $SERVICELATENCY$         | Verzögerung zwischen geplanter Prüfzeit und tatsächlicher Prüfzeit als Float. ("2.05")                                                              |
| $SERVICEEXECUTIONTIME$   | Plugin Ausführungszeit als Float. ("4.21").                                                                                                |
| $SERVICEDURATION$        | Zeit seit letzten Statuswechsel als String (HH MM SS)                                                                                         |
| $SERVICEDURATIONSEC$     | Zeit seit letzten Statuswechsel als Integer in Sekunden.                                                                                       |
| $SERVICEDOWNTIME$        | Ist der Service in einer geplanten Wartungszeit, ist dieser wert >= 1.                                                                                  |
| $SERVICEPERCENTCHANGE$   | Statuswechsel prozentual als Float. (Wird von Flattererkennungs Algorithmus genutzt).                                                        |
| $SERVICEGROUPNAME$       | Enthält die erste Servicegruppe eines Service als String ("6123eb90-a3eb-4895-b348-c464d9494d14")                                                  |
| $SERVICEGROUPNAMES$      | Kommaseparierte Liste aller Servicegruppen der der Service angehört. ("6123eb90-a3eb-4895-b348-c464d9494d14,666b1caf-4c0f-45e8-9380-78f9e915b82d") |
| $LASTSERVICECHECK$       | Unix timestamp (integer) des letzten Service check.                                                                                               |
| $LASTSERVICESTATECHANGE$ | Unix timestamp (integer) des letzten Service Statuswechsel.                                                                                            |
| $LASTSERVICEOK$          | Unix timestamp (integer) des letzten Service OK Status.                                                                                            |
| $LASTSERVICEWARNING$     | Unix timestamp (integer) des letzten Service WARNING Status.                                                                                       |
| $LASTSERVICECRITICAL$    | Unix timestamp (integer) des letzten Service CRITICAL Status.                                                                                      |
| $LASTSERVICEUNKNOWN$     | Unix timestamp (integer) des letzten Service UNKNOWN Status.                                                                                       |
| $SERVICEOUTPUT$          | Output des Service Prüf Plugin ("OK - 127.5.6.7: rta 0,054ms, lost 0% ").                                                                         |
| $LONGSERVICEOUTPUT$      | Long plugin output des Aktuellen Service checks.                                                                                                  |
| $SERVICEPERFDATA$        | Performance daten output des Aktuellen Service checks. ("rta=0.054000ms;100.000000;500.000000;0.000000 pl=0%;20;60;0")                                 |
| $SERVICECHECKCOMMAND$    | Enthält die Kommando UUID sowie dessen Agrumente ("5a538ebc-03de-4ce6-8e32-665b841abde3!3000.0,80%!4000.0,90%;")                        |
| $SERVICEACTIONURL$       | Nicht Implementiert in openITCOCKPIT.                                                                                                                 |
| $SERVICENOTESURL$        | Nicht Implementiert in openITCOCKPIT.                                                                                                                 |
| $SERVICENOTES$           | Benutzerdefinierte Notizen für den Service                                                                                                                   |
|Servicegruppen Makros|
| $SERVICEGROUPALIAS$    | UUID der Hostgruppe ("65c7692e-b322-4788-8232-97258b457f22")                                                                        |
| $SERVICEGROUPMEMBERS$  | Kommaseparierte Liste der Servicegruppen Mitglieder als UUIDs ("0a9feda1-569e-40fe-a5a3-b2f389818301,ade06bfb-f9bd-4112-9537-2b3d286a6572"). |
| $SERVICEGROUPNOTES$    | Nicht Implementiert in openITCOCKPIT.                                                                                                          |
| $SERVICEGROUPNOTESURL$ | Nicht Implementiert in openITCOCKPIT.                                                                                                          |
| $SERVICEGROUPNOTES$    | Nicht Implementiert in openITCOCKPIT.                                                                                                          |
|Kontakt Makros|
| $CONTACTNAME$       | UUID des Kontakt ("9595f7d6-2b79-4a7b-b7b8-414eec84c0b0")                                                                                  |
| $CONTACTGROUPNAME$  | Lesbarer Name des Kontakt ("info").                                                                                                           |
| $CONTACTALIAS$      | Lesbarer Name des Kontakt ("info"), same as $CONTACTGROUPNAME$                                                                                |
| $CONTACTEMAIL$      | Email Adresse des Kontakt. ("community@openitcockpit.io")                                                                                      |
| $CONTACTPAGER$      | Pager Nummer des Kontakt. ("004913456789")                                                                                                     |
| $CONTACTGROUPNAMES$ | Kommaseparierte Liste aller Kontaktgruppen denen der Kontakt angehört. ("06e352a8-643d-4fa8-a7bd-9ff74ad0e112,4992c7ad-1bb4-465a-8fe4-a721461b69a2") |
|Kontaktgruppen Makros|
| $CONTACTGROUPALIAS$   | UUID der Kontaktgruppe ("06e352a8-643d-4fa8-a7bd-9ff74ad0e112")                                                                            |
| $CONTACTGROUPMEMBERS$ | Kommasepariete Liste aller Kontakte die der Kontaktgruppe angehören. ("9595f7d6-2b79-4a7b-b7b8-414eec84c0b0,6de7d0f9-413e-41cc-b1e4-3289072b72c4") |
|Zusammenfassungs Makros (INFO: CPU intensiv zu berechenen - mit Vorsicht nutzen!)|
| $TOTALHOSTSUP$                   | Anzahl der Hosts im Status UP.                                                                                              |
| $TOTALHOSTSDOWN$                 | Anzahl der Hosts im Status DOWN.                                                                                            |
| $TOTALHOSTSUNREACHABLE$          | Anzahl der Hosts im Status UNREACHABLE.                                                                                     |
| $TOTALHOSTSDOWNUNHANDLED$        | Anzahl der unbehandelten Hosts. Unbehandelte Hosts sind in einem DOWN Status und nicht bestätigt oder in einer geplanten Wartungszeit.           |
| $TOTALHOSTSUNREACHABLEUNHANDLED$ | Anzahl der unbehandelten hosts. Unbehandelte Hosts sind in einem UNREACHABLE Status und nicht bestätigt oder in einer geplanten Wartungszeit.    |
| $TOTALHOSTPROBLEMS$              | Anzahl der Hosts in einem nicht UP Status.                                                                                        |
| $TOTALHOSTPROBLEMSUNHANDLED$     | Anzahl der unbehandelten Hosts. Unbehandelte Hosts sind in einem nicht UP Status und nicht bestätigt oder in einer geplanten Wartungszeit.         |
| $TOTALSERVICESOK$                | Anzahl der Services im Status OK.                                                                                           |
| $TOTALSERVICESWARNING$           | Anzahl der Services im Status WARNING.                                                                                      |
| $TOTALSERVICESCRITICAL$          | Anzahl der Services im Status CRITICAL.                                                                                     |
| $TOTALSERVICESUNKNOWN$           | Anzahl der Services im Status UNKNOWN.                                                                                      |
| $TOTALSERVICESWARNINGUNHANDLED$  | Anzahl der unbehandelten Services. Unbehandelte Services sind in einem WARNING Status und nicht bestätigt oder in einer geplanten Wartungszeit.  |
| $TOTALSERVICESCRITICALUNHANDLED$ | Anzahl der unbehandelten Services. Unbehandelte Services sind in einem CRITICAL Status und nicht bestätigt oder in einer geplanten Wartungszeit. |
| $TOTALSERVICESUNKNOWNUNHANDLED$  | Anzahl der unbehandelten Services. Unbehandelte Services sind in einem UNKNOWN Status und nicht bestätigt oder in einer geplanten Wartungszeit.  |
| $TOTALSERVICEPROBLEMS$           | Anzahl der Services in einem nicht OK Status.                                                                                     |
| $TOTALSERVICEPROBLEMSUNHANDLED$  | Anzahl der unbehandelten Services. Unbehandelte Services sind in einem nicht OK Status und nicht bestätigt oder in einer geplanten Wartungszeit.   |
|Benachrichtigungsmakros|
| $NOTIFICATIONTYPE$          | Benachrichtigungstyp als String ("PROBLEM", "RECOVERY", "ACKNOWLEDGEMENT", "FLAPPINGSTART", "FLAPPINGSTOP", "FLAPPINGDISABLED", "DOWNTIMESTART", "DOWNTIMEEND", or "DOWNTIMECANCELLED"). |
| $NOTIFICATIONRECIPIENTS$    | Kommaseparierte Liste aller Kontakte für diese Benachrichtigung. ("12403d1a-70c0-468b-ad8d-446fb8412205,20a1bad7-60c1-433d-8e28-716cde8b8f04")                                           |
| $NOTIFICATIONISESCALATED$   | Ist diese Benachrichtigung eskaliert (0=NO, 1=YES)                                                                                                                                      |
| $NOTIFICATIONAUTHOR$        | openITCOCKPIT Benutzername als String.                                                                                                                                                   |
| $NOTIFICATIONAUTHORNAME$    | openITCOCKPIT Benutzername als String.                                                                                                                                                   |
| $NOTIFICATIONAUTHORALIAS$   | openITCOCKPIT Benutzername als String.                                                                                                                                                   |
| $NOTIFICATIONCOMMENT$       | Kommentar daten der Benachrichtigung.                                                                                                                                                    |
| $HOSTNOTIFICATIONNUMBER$    | Anzahl der gesendeten Benachrichtigungen für einen Host. Geht der Host in einen RECOVERY Status über, wird der Zähler auf 0 zurückgesetzt.                                                                         |
| $HOSTNOTIFICATIONID$        | Eindeutige Event Nummer der Host Benachrichtigung.                                                                                                                                        |
| $SERVICENOTIFICATIONNUMBER$ | Anzahl der gesendeten Benachrichtigungen für einen Service. Geht der Service in einen OK Status über, wird der Zähler auf 0 zurückgesetzt.                                                                         |
| $SERVICENOTIFICATIONID$     | Eindeutige Event Nummer der Service Benachrichtigung.                                                                                                                                     |
|Datum und Zeit Makros|
| $DATE$  | Aktuelles Datum als String (DD-MM-YYYY). |
| $TIME$  | Aktuelle Zeit als String (HH:MM:SS).   |
| $TIMET$ | Aktuelle Zeit als UNIX timestamp.      |
