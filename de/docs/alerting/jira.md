# Jira <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## Was kann ich mit dem Jira-Modul tun?

Das Jira-Modul ermöglicht es Ihnen, Jira-Issues (Probleme) aus openITCOCKPIT-Benachrichtigungen zu erstellen. Zusätzlich kann Jira Issues in openITCOCKPIT über einen Webhook bestätigen.

Wenn ein Host oder Dienst eine Benachrichtigung sendet, erstellt openITCOCKPIT ein neues Jira-Issue. Pro Host- oder Dienstproblem wird nur ein Problem erstellt. openITCOCKPIT schließt auch offene Probleme, wenn ein Host oder Dienst wieder in einen Wiederherstellungszustand wechselt.

openITCOCKPIT unterstützt **Jira Cloud** und **Jira Data Center** Installationen.

## Konfiguration

Um die Jira-Integration einzurichten, navigieren Sie zu `APIs` -> `Jira`.

Wählen Sie den Jira-Typ, geben Sie die Jira-URL und ein API-Token ein. Für Jira Cloud ist auch ein Benutzername erforderlich. Klicken Sie auf "Jira-Projekte aktualisieren", um eine Liste der verfügbaren Jira-Projekte von Ihrem Jira-Server zu laden.

openITCOCKPIT kann Probleme in verschiedenen Jira-Projekten erstellen. Wählen Sie alle Jira-Projekte aus, in denen Sie Probleme erstellen möchten. Mindestens ein Projekt muss ausgewählt werden.
Wenn Sie mehr als ein Projekt auswählen, müssen Sie ein Projekt als `Standardprojekt` markieren. Alle Probleme werden im Standardprojekt erstellt, es sei denn, es wird durch Festlegen der benutzerdefinierten Variable `JIRA_PROJECT` auf den Jira-Projektschlüssel (z.B. `PX` oder `SUP`) in der Kontakt-, Host- oder Dienstkonfiguration überschrieben. Siehe den Abschnitt Makros für Details.

![openITCOCKPIT Jira-Integrationseinstellungen](/images/alerting/jira/datacenter/openitcockpit_jira_integration.png)

### Close transition ID

#### Jira Data Center

Um ein Jira-Issue zu schließen, benötigt openITCOCKPIT die ID des Schließübergangs. Diese Übergangs-ID ist erforderlich, damit openITCOCKPIT Jira-Issues automatisch schließen kann, wenn ein Host oder Dienst wiederhergestellt wird.
Wenn Sie keine Übergangs-ID angeben oder eine falsche ID eingeben, erstellt openITCOCKPIT weiterhin Probleme in Jira, kann sie jedoch nicht schließen.

Je nach Workflow kann die Übergangs-ID variieren. Leider bietet Jira keine API, um die Übergangs-ID abzufragen. Sie müssen die Übergangs-ID manuell in der Jira-Weboberfläche nachschlagen und die Nummer eingeben.

Navigieren Sie zu `Projekte` -> Wählen Sie Ihr Projekt -> `Arbeitsabläufe` und klicken Sie auf das Stiftsymbol.
![Jira Einstellungen -> Projekt](/images/alerting/jira/datacenter/jira_main_menu_projects.png)
![openITCOCKPIT Jira Workflow-Übergänge](/images/alerting/jira/datacenter/jira_edit_workflow.png)

Nun sehen Sie eine Liste aller Übergänge im Arbeitsabläuf. In diesem Beispiel wird der `Fertig`-Übergang verwendet, um Probleme als geschlossen zu markieren, mit der ID `41`.

![openITCOCKPIT Jira Workflow Done Übergänge](/images/alerting/jira/datacenter/project_worksflow_Close_transitions_ID.png)

#### Jira Cloud

Bei Jira Cloud hat sich die Situation nicht verbessert. Die _einfachste_ Methode, um die Übergangs-ID zu erhalten, besteht darin, die Entwicklerkonsole Ihres Browsers zu öffnen und ein Problem zu schließen.
![Übergangs-ID aus den Entwicklertools abrufen](/images/alerting/jira/cloud/jira_cloud_transition_id.png)

Alternativ können die Werte direkt per API Abgefragt werden, dazu die ID (z.B. `PX-6`) in der URL eintragen und im Browser öffnen
```
https://openitcockpit.atlassian.net/rest/api/2/issue/PX-6/transitions
```

Die Antwort enthält dann all Übergänge mit ID.
```json
{
  "expand": "transitions",
  "transitions": [
    {
      "id": "11",
      "name": "Zu erledigen",
      "to": {}
    },
    {
      "id": "21",
      "name": "In Arbeit",
      "to": {}
    },
    {
      "id": "31",
      "name": "Fertig",
      "to": {}
    }
  ]
}
```

### Jira API-Schlüssel

#### Jira Data Center

Jira Data Center verwendet persönliche Zugriffstoken. Bitte folgen Sie der offiziellen Dokumentation, um ein neues Zugriffstoken zu erstellen: [https://confluence.atlassian.com/enterprise/using-personal-access-tokens-1026032365.html](https://confluence.atlassian.com/enterprise/using-personal-access-tokens-1026032365.html).

#### Jira Cloud

Jira Cloud API-Tokens sind an ein Benutzerkonto gebunden. Bitte folgen Sie der offiziellen Dokumentation: [https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/](https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/).


## Webhooks einrichten

Mit Webhooks kann Jira mit openITCOCKPIT kommunizieren. Dies wird verwendet, um eine Bestätigung zu openITCOCKPIT hinzuzufügen, wenn ein Jira-Issue von `Backlog` zu `In Progress` wechselt. Die Bestätigung enthält den Benutzer oder den zugewiesenen Benutzer.
Zusätzlich benachrichtigt Jira openITCOCKPIT, wenn ein Problem in Jira geschlossen wird. Dies stellt sicher, dass openITCOCKPIT ein neues Problem erstellt, wenn ein Problem ungelöst bleibt.

!!! warning
    Aus Sicherheitsgründen wird empfohlen, einen neuen openITCOCKPIT-Benutzer und eine neue Benutzerrolle ohne Berechtigungen zu erstellen.

Um Webhooks einzurichten, ist ein openITCOCKPIT [API-Schlüssel](/development/api/#api-keys) erforderlich.

### Jira Data Center

![Jira Einstellungen -> System](/images/alerting/jira/datacenter/jira_main_menu_system.png)

Um einen Webhook zu erstellen, navigieren Sie zu `System` -> `Webhooks` und klicken Sie oben rechts auf `Einen WebHook erstellen`.

#### Bestätigungs-Webhook

![Jira -> Webhook erstellen](/images/alerting/jira/datacenter/1_create_webhook.png)

Kopieren und fügen Sie die Webhook-URL für Bestätigungen ein, die in den Jira-Einstellungen in openITCOCKPIT angezeigt wird.

Wichtige Einstellungen sind:

- **Name**: `openITCOCKPIT Acknowledge`
- **URL**: *Siehe openITCOCKPIT Jira-Einstellungen*
- **Beschreibung**: `Wird verwendet, um Host- und Dienstprobleme in openITCOCKPIT zu bestätigen`

!!! warning
    Jira erfordert ein gültiges SSL-Zertifikat für den Webhook-Endpunkt!

Klicken Sie unten auf der Seite auf `Erstellen`, um den Webhook zu speichern.

![Jira Bestätigungs-Webhook erstellen](/images/alerting/jira/datacenter/2_create_webhook_acknowledge.png)

#### Schließen-Problem-Webhook

Erstellen Sie einen zweiten Webhook, um openITCOCKPIT zu benachrichtigen, wenn ein Problem in Jira geschlossen wird.

Kopieren und fügen Sie die Webhook-URL für geschlossene Probleme ein, die in den Jira-Einstellungen in openITCOCKPIT angezeigt wird.

Wichtige Einstellungen sind:

- **Name**: `openITCOCKPIT Close`
- **URL**: *Siehe openITCOCKPIT Jira-Einstellungen*
- **Beschreibung**: `Wird verwendet, um openITCOCKPIT zu benachrichtigen, wenn ein Problem in Jira geschlossen wird`

Klicken Sie unten auf der Seite auf `Erstellen`, um den Webhook zu speichern.

![Jira Schließen-Webhook erstellen](/images/alerting/jira/datacenter/2_create_webhook_close.png)

Weitere Informationen zu Webhooks finden Sie in der offiziellen Jira-Dokumentation: [https://confluence.atlassian.com/adminjiraserver/managing-webhooks-938846912.html](https://confluence.atlassian.com/adminjiraserver/managing-webhooks-938846912.html)

#### Workflow bearbeiten

Es ist wichtig, den Workflow Ihres Jira-Projekts zu aktualisieren; andernfalls wird Jira die Webhooks nicht aufrufen oder openITCOCKPIT über Problemaktualisierungen informieren.

![Jira Einstellungen -> Projekt](/images/alerting/jira/datacenter/jira_main_menu_projects.png)

Navigieren Sie zu `Projekte` und wählen Sie das entsprechende Jira-Projekt aus. Klicken Sie auf der linken Seite auf `Arbeitsabläufe`, dann auf Ihren Workflow und wählen Sie oben rechts `Bearbeiten`.

![Jira Einstellungen -> Projekt -> Workflow](/images/alerting/jira/datacenter/3_edit_project_workflow.png)
![Jira Einstellungen -> Projekt -> Workflow -> Bearbeiten](/images/alerting/jira/datacenter/3.1_edit_workflow_via_designer.png)

#### Bestätigungs-Webhook auslösen

In diesem Fall konfigurieren Sie Jira so, dass eine Bestätigung in openITCOCKPIT erstellt wird, wenn ein Problem in den Status `In Progress` verschoben wird. Dies kann je nach Workflow variieren, aber das Grundprinzip ist dasselbe.
Um den Webhook auszuführen, klicken Sie auf `Alle` und dann auf `Folgefunktionen` auf der rechten Seite.

![Jira Einstellungen -> Workflow -> Post-Funktion hinzufügen](/images/alerting/jira/datacenter/4_add_webhook_as_post_function.png)

Sie sehen eine Liste aller Standard-Post-Funktionen. Klicken Sie auf `Folgefunktionen hinzufügen`.

![Jira Einstellungen -> Workflow -> Neue Post-Funktion hinzufügen](/images/alerting/jira/datacenter/5_add_post_function.png)

Wählen Sie `Einen Webhook auslösen` und wählen Sie den `openITCOCKPIT Acknowledge` Webhook.

![Jira Einstellungen -> Workflow -> Neue Post-Funktion hinzufügen -> Webhook auswählen](/images/alerting/jira/datacenter/6_select_trigger_webhook.png)
![Jira Einstellungen -> Workflow -> Neue Post-Funktion hinzufügen -> Den openITCOCKPIT Webhook auswählen](/images/alerting/jira/datacenter/7_select_openitcockpit_acknowledge_webhook.png)

Sobald dies erledigt ist, wird der openITCOCKPIT Webhook zur Liste der Folgefunktionen hinzugefügt. Um die Einstellungen zu übernehmen, ist es wichtig, den neuen Workflow zu veröffentlichen.

![Jira Einstellungen -> Workflow -> Veröffentlichen](/images/alerting/jira/datacenter/8_acknowledge_webhook_done.png)

#### Schließen-Webhook auslösen

Wiederholen Sie die oben beschriebenen Schritte, fügen Sie diesmal jedoch die Folgefunktion zu Ihrem `Fertig`-Status hinzu.

![Jira Einstellungen -> Workflow -> Post-Funktion hinzufügen](/images/alerting/jira/datacenter/9_add_close_webhook.png)
![Jira Einstellungen -> Workflow -> Veröffentlichen](/images/alerting/jira/datacenter/10_close_webhook_done.png)


### Jira Cloud

Jira Cloud bietet Automatisierungen, die mit einem einfachen Editor in den Projekteinstellungen erstellt werden können.

Navigieren Sie zuerst in die Projekteinstellungen, wählen Sie `Automatisierung` auf der linken Seite, wählen Sie `Regeln` und `Regel erstellen`.

![Jira Cloud Neue Regel erstellen](/images/alerting/jira/cloud/1_create_new_automation.png)

Falls dies die erste Regel ist, die Sie erstellen, zeigt die Jira-Weboberfläche ein kleines Tutorial an. Es wird empfohlen, das Tutorial zu lesen.

Fügen Sie nun einen neuen `Vorgang weitergegeben`-Trigger hinzu. Wählen Sie die Zustände aus, bei denen Sie den Webhook aufrufen möchten, also von `To Do -> In Progress` in diesem Fall.

![Jira Cloud Trigger hinzufügen](/images/alerting/jira/cloud/2_add_trigger.png)

Klicken Sie auf `Add component` und fügen Sie eine neue Aktion `Web-Anfrage senden` hinzu.

Wichtige Einstellungen sind:

- **Web Request URL**: *Siehe openITCOCKPIT Jira-Einstellungen und kopieren Sie die Webhook-URL*
- **HTTP-Methode**: `POST`
- **Web request body**: `Vorgangsdaten (Jira-Format)`

![Jira Cloud Aktion hinzufügen](/images/alerting/jira/cloud/3_add_action.png)

Speichern Sie die Automatisierung in der oberen rechten Ecke und wiederholen Sie die Schritte für die Schließungstransition und den Schließen-Webhook.

## Komponenten (optional)

Beim Erstellen eines Issues, können dem Issue eine oder mehrere Komponenten zugeordnet werden, sofern dies vom Jira-Projekt unterstützt wird.
Dazu muss die ID der jeweiligen Komponenten übergeben werden.

### Jira Cloud

Am einfachsten können die Komponenten-IDs über die API ausgelesen werden. Hierfür müssen Sie in der URL das Kürzel des Projekts (`PY`) ersetzten.

```
https://openitcockpit.atlassian.net/rest/api/2/project/PY
```

Die Antwort enthält die IDs der Komponenten.

```json
{
  "maxResults": 50,
  "startAt": 0,
  "total": 3,
  "isLast": true,
  "values": [
    {
      "name": "Foobar",
      "id": "10056"
    },
    {
      "name": "Foo",
      "id": "10054"
    },
    {
      "name": "Bar",
      "id": "10055"
    }
  ]
}
```

### Jira Data Center

In der Jira Data Center Version können die benötigten IDs in der Verwaltung der Komponenten ausgelesen werden. Gehen Sie dazu in die Projektverwaltung und wählen Sie Komponenten links im Menü.
Suchen Sie die entsprechende Komponente aus der Liste und öffnen Sie das Kontaktmenü. Halten Sie die Maus über "Bearbeiten" und notieren Sie sich die ID aus der Adressleiste am unteren Bildschirmrand.

![Jira Komponenten ID auslesen](/images/alerting/jira/datacenter/jira_datacenter_project_component.png)


## Makros

Makros (benutzerdefinierte Variablen) können verwendet werden, um das Standard-Jira-Projekt zu überschreiben, einen Bearbeiter oder ein übergeordnetes Problem hinzuzufügen oder den Problemtyp zu ändern. Diese Einstellungen können als benutzerdefinierte Variablen für Hosts, Dienste oder Kontakte definiert werden.

- `JIRA_ASSIGNEE` - Jira-Benutzername wie `jdoe` zur Zuweisung des Problems
- `JIRA_PROJECT` - Projektschlüssel zur Überschreibung des Standardprojekts, z.B. `PX`
- `JIRA_ISSUE_TYPE` - Zur Überschreibung des Standard-Probletyps, z.B. `Bug` oder `Task`
- `JIRA_PARENT_ISSUE` - Ein gültiges Jira-Issue, das als "verwandtes Problem" zugewiesen werden soll (z.B. `PX-30`)
- `JIRA_COMPONENTS` - Eine kommaseparierte Liste von Komponenten IDs, sofern der Projekt-Typ dies unterstützt (z.B. `10056,10054`)

!!! notice
    Jira Cloud-Benutzer: Das Makro `JIRA_ISSUE_TYPE` erfordert die Übermittlung der Issue Type ID (z.B. 10001) für Jira Cloud!

### Kommandos

Standardmäßig bietet openITCOCKPIT die Benachrichtigungsbefehle `host-notify-by-jira` und `service-notify-by-jira`. Beide können in der Kontaktkonfiguration verwendet werden, um Jira-Issues aus Warnungen zu erstellen.

**host-notify-by-jira**
```
/opt/openitc/frontend/bin/cake JiraModule.jira_notification -q --type host --hostuuid "$HOSTNAME$" --notificationtype "$NOTIFICATIONTYPE$" --state $HOSTSTATEID$ --output "$HOSTOUTPUT$" --longoutput "$LONGHOSTOUTPUT$"
```

**service-notify-by-jira**
```
/opt/openitc/frontend/bin/cake JiraModule.jira_notification -q --type service --hostuuid "$HOSTNAME$" --serviceuuid "$SERVICEDESC$" --notificationtype "$NOTIFICATIONTYPE$" --state $SERVICESTATEID$ --output "$SERVICEOUTPUT$" --longoutput "$LONGSERVICEOUTPUT$"
```

Sie können einen Bearbeiter, ein Projekt, einen Problemtyp oder ein übergeordnetes Problem als Parameter übergeben. Meistens werden Sie wahrscheinlich benutzerdefinierte Variablen für Kontakte, Hosts oder Dienste verwenden, um dies zu tun.
Die folgenden Beispiele zeigen, wie Parameter als benutzerdefinierte Variablen übergeben werden.

![Benutzerdefinierte Variablen an den Jira-Benachrichtigungsbefehl übergeben](/images/alerting/jira/datacenter/jira_host_macros.png)

**host-notify-by-jira-macros**
```
/opt/openitc/frontend/bin/cake JiraModule.jira_notification -q --type host --hostuuid "$HOSTNAME$" --notificationtype "$NOTIFICATIONTYPE$" --state $HOSTSTATEID$ --output "$HOSTOUTPUT$" --longoutput "$LONGHOSTOUTPUT$" --jira-assignee "$_CONTACTJIRA_ASSIGNEE$" --jira-project "$_HOSTJIRA_PROJECT$" --jira-issue-type "$_HOSTJIRA_ISSUE_TYPE$" --jira-parent-issue "$_HOSTJIRA_PARENT_ISSUE$" --jira-components "$_CONTACTJIRA_COMPONENTS$"
```

**service-notify-by-jira-macros**
```
/opt/openitc/frontend/bin/cake JiraModule.jira_notification -q --type service --hostuuid "$HOSTNAME$" --serviceuuid "$SERVICEDESC$" --notificationtype "$NOTIFICATIONTYPE$" --state $SERVICESTATEID$ --output "$SERVICEOUTPUT$" --longoutput "$LONGSERVICEOUTPUT$" --jira-assignee "$_CONTACTJIRA_ASSIGNEE$" --jira-project "$_HOSTJIRA_PROJECT$" --jira-issue-type "$_HOSTJIRA_ISSUE_TYPE$" --jira-parent-issue "$_HOSTJIRA_PARENT_ISSUE$" --jira-components "$_CONTACTJIRA_COMPONENTS$"
```
