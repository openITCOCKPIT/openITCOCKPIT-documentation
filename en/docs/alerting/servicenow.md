# ServiceNow <span class="badge badge-danger badge-outlined" title="Enterprise Edition">EE</span>

## Prerequisites

- openitcockpit-module-servicenow
- ServiceNow instance (London)

## Facility

### Creating ServiceNow users

In order to connect the ServiceNow module to a ServiceNow (London) instance, you must first create a ServiceNow user.

![Screenshot: Creating ServiceNow users](/images/servicenow-usersmenu.png)

The following parameters must be specified:

- User ID: openitcockpit
- First Name: openITCOCKPIT
- Time zone: (wie im openITCOCKPIT System)
- Active: (true)
- Password

The user should **not have a surname** and the user ID and first name should not contain spaces (or any other special characters)!

After the user has been saved, it must now be edited.

The new role 'incident\_manager' must also be added to the user (at the bottom of the page) via Roles → Edit.

The role must then be saved by clicking **Save** and the user updated by clicking **Update**.

![Screenshot: Creating ServiceNow users](/images/servicenow-userrolesedit.png)

![Screenshot: Creating ServiceNow users](/images/servicenow-userrolesedit2.png)

### Configure the ServiceNow custom incident summary

To display URLs to hosts and services from openITCOCKPIT in the ServiceNow Incident, a separate Incident View must be created.

To do this, first open any incident (Menu → Incidents → All → click on Incident ID), press the menu button at the top left and navigate to Configure → Form Design.

On the page that is displayed, the table 'Incident' and the view 'Default view' should be selected at the top left.

![Screenshot: Configure the ServiceNow custom incident summary](/images/servicenow-incidentfields.png)

To clone the selected view, open the drop-down menu which currently shows 'Default view' and click on '**New…**'

![Screenshot: Configure the ServiceNow custom incident summary](/images/servicenow-incidentnew.png)

Select the name 'openITCOCKPIT' and confirm this choice with OK.

![Screenshot: Configure the ServiceNow custom incident summary](/images/servicenow-createview.png)

The new view should now be selected in the drop-down menu.

On the left side, in the tab 'Field Types', enter the filter 'URL'. A new URL field object should appear.

![Screenshot: Configure the ServiceNow custom incident summary](/images/servicenow-newurlfield.png)

**The URL object** can be dragged and dropped to the desired position in the boxes on the right-hand side.

This will need to be done twice to create the 'Host URL' and 'Service URL' fields.

Recommended configuration:

(Arrange the objects for the 'Host URL' and 'Service URL' fields in the second box under the 'Description' object)

![Screenshot: Configure the ServiceNow custom incident summary](/images/servicenow-incidentfieldtype.png)

After adding the two URL objects, they must be edited using the gear wheel icon on the right.

The name 'u_host_url' must be selected for the label 'Host URL' and the name 'u_service_url' for the 'Service URL' label.

![Screenshot: Configure the ServiceNow custom incident summary](/images/servicenow-hosturlproperties.png)

![Screenshot: Configure the ServiceNow custom incident summary](/images/servicenow-serviceurlproperties.png)

Then the configuration can be saved by clicking 'Save' in the top right. The tab can now be closed.

A 'View Rule' must now be created so that the Incident View you just created will automatically be selected for Incidents created by openITCOCKPIT.

![Screenshot: Configure the ServiceNow custom incident summary](/images/servicenow-viewrules.png)

The view rule should be defined as follows:

The 'Incident' option must be selected as the Table.

The View value corresponds to the name of the Incident View that has just been defined.

'Caller' → 'is' → 'openITCOCKPIT' should be defined as a condition.

The Caller value corresponds to the name of the ServiceNow user created for openITCOCKPIT.

Now save your new rule by clicking on ‘Submit’

![Screenshot: Configure the ServiceNow custom incident summary](/images/servicenow-newviewrole.png)

### Save module configuration

In openITCOCKPIT, open the menu item System configuration → APIs → ServiceNow and enter the user ID/password of the user you just created.

Enter your own ServiceNow URL according to the specified scheme.

If a host/service now leaves the Up/Ok state, a ServiceNow Incident will be created.

If an 'Assignment Group' or an 'Assigned To' user is to be assigned to this incident, the name of the group/user must be entered here.

For 'Impact' and 'Urgency' there are 3 available options each (High, Medium, Low) that make up the Incident Priority displayed in the ServiceNow incident list.

Details on the priority classification can be found in the official [ServiceNow documentation](https://docs.servicenow.com/bundle/london-it-service-management/page/product/incident-management/reference/r_PrioritizationOfIncidents.html?cshalt=yes).

![Screenshot: Save module configuration](/images/servicenow-config.png)

### Activate notifications

The command 'host-notify-by-servicenow' / ' service-notify-by-servicenow' must be added to the list of contacts that ServiceNow should be notified about.

Several commands or a different time period can also be selected.

The notification for the 'Recovery' state must always be activated to ensure the system functions correctly.

Because these involve changes to the Nagios configuration, an [Export](../../monitoring/basic-principles/#how-do-i-carry-out-an-export) must be carried out after this step.

![Screenshot: Activate notifications](/images/contacts-servicenownotifications.png)

## Setting up two-way integration

In order to execute acknowledgements for hosts and services via ServiceNow incidents, you will need to activate "Two-Way Integration" in openITCOCKPIT System Configuration → APIs → ServiceNow.

To do this, the openITCOCKPIT server must be accessible externally via http or https with a valid and verified SSL certificate.

**Important: If available, the "full chained" certificate must be used.** (This is automatically created with LetsEncrypt)

Also, a ServiceNow 'Business Rule' must be created so that incident updates can automatically be sent to openITCOCKPIT.

To do this, navigate to 'System Definition' → 'Business Rule'.

It is recommended that 'openITCOCKPIT' be used as the name, but this is not mandatory.

The 'Incident' table must be selected for the rule and the 'Active' and 'Advanced' options enabled.

The following settings must also be made in the '**When to run**' tab:

(The specified 'Filter Conditions' are linked via the 'AND' operator)

The 'Caller' and 'Updated by' values correspond to the name of the user that has been created (in this instance 'openITCOCKPIT').

![Screenshot: Setting up two-way integration](/images/servicenow-businessrule.png)

In the '**Advanced**' tab, the following source code must be inserted into the 'Script' field (no 'Condition' is required at this point):

The value of the variable 'openITCOCKPIT_url' must correspond to your company's own externally accessible openITCOCKPIT URL.

The value of the variable 'openITCOCKPIT_apikey' must correspond to your own individually generated and valid openITCOCKPIT API Key.

**Business Rule Script (Template)**

```plaintext
(function executeRule(current, previous /*null when async*/) {

    try {

        var openITCOCKPIT_url = "https://demo.openitcockpit.io";
        var openITCOCKPIT_apikey = "551ad76bcdb0.....";

        var openITCOCKPIT_servicenow_path = "/servicenow_module/servicenow_acknowledge/submit.json";
        var request = new sn_ws.RESTMessageV2();
        request.setEndpoint(openITCOCKPIT_url + openITCOCKPIT_servicenow_path);
        request.setRequestHeader("Accept","application/json");
        request.setRequestHeader('Content-Type','application/json;charset=UTF-8');
        request.setHttpMethod('POST');
        request.setQueryParameter('apikey', openITCOCKPIT_apikey);

        var data = {};
        data.short_description = current.getValue('short_description');
        data.impact = current.getValue('impact');
        data.urgency = current.getValue('urgency');
        data.state = current.getValue('state');
        data.incident_id = current.getValue('number');
        data.close_notes = current.getValue('close_notes');
        data.close_code = current.getValue('close_code');
        data.sys_resolved_by = current.getValue('resolved_by');
        data.updated_by = current.getValue('sys_updated_by');

        var myJSON = JSON.stringify(data);
        request.setRequestBody(myJSON);

        var response = request.execute();
        gs.log(myJSON);
        gs.log('openITCOCKPIT HTTP Status Code: '+response.getStatusCode());
        gs.log('openITCOCKPIT Error Message:');
        gs.log(response.getErrorMessage());
        gs.log('openITCOCKPIT Response Body:');
        gs.log(response.getBody());

    }catch(err){
        gs.log('openITCOCKPIT Rule Error: '+err);
    }

})(current, previous);
```

## Commands

The following commands must be used for notifications.

These should be created automatically as part of the module installation.

**Host Notification Command**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake ServicenowModule.ServicenowNotification --type Host --hostname "$HOSTNAME$" --hostaddress "$HOSTADDRESS$" --hoststate "$HOSTSTATEID$" --output "$HOSTOUTPUT$"
```

**Service Notification Command**

```plaintext
/usr/share/openitcockpit/app/cake4/bin/cake ServicenowModule.ServicenowNotification --type Service --hostname "$HOSTNAME$" --hostaddress "$HOSTADDRESS$" --hoststate "$HOSTSTATEID$" --servicedesc "$SERVICEDESC$" --servicestate "$SERVICESTATEID$" --output "$SERVICEOUTPUT$"
```

## Debugging

If you find two-way integration does not work, please check whether the **"full chained" certificate** has been used. (This is created automatically with LetsEncrypt)

To get the debug output from calling the business rule in ServiceNow (for example when changing incidents), you will need to navigate to 'System Diagnostics' → 'Debug Business Rule' in the options menu.

To activate debug mode, click on the 'available here' link and then on the 'Update' button in the subsequent tab that opens.

![Screenshot: Debugging](/images/servicenow-debugbusinessrule.png)

![Screenshot: Debugging](/images/servicenow-scriptexecutionhistory.png)

You can then navigate back to the incident and update it.

The debug output should now appear at the bottom of the page.

## Usage

In order to connect hosts/services to ServiceNow, the commands 'host-notify-by-servicenow' and 'service-notify-by-servicenow' must be added to the respective 'Contact'.

All hosts/services with this contact will be connected to ServiceNow as an incident when a new notification is received.

When the incident is updated by a user who is not openITCOCKPIT, an acknowledgement will be created for the host/service as long as it has not returned to the Up/Ok state again.

The ServiceNow Incident number (with link) will be displayed in the acknowledgement message.

Schematic representation of possible interactions with ServiceNow:

![Figure: Usage](/images/servicenow-schema.png)

The 'ServiceNow' tab appears in the hosts and services browser when the ServiceNow module is activated. If you need to provide any host or service-specific incident settings that deviate from the global configuration, these can be made here.

At this point, the global parameters 'Incident', 'Urgency', 'Assignment Group', 'Assigned To' and 'Business Service' can be overwritten.

Updates to an incident created by openITCOCKPIT (via ServiceNow) result in an acknowledgement of the host/service if two-way integration has been configured correctly.

The incident 'State' and 'Updated By' fields are sent in addition to the incident 'Number'.

When changing the Incident State to 'Closed' or 'Resolved', the 'Resolution Code', the 'Resolution Notes' and the system ID of the 'Resolved By' user are also sent to openITCOCKPIT.

![Figure: Usage](/images/servicenow-schema2.png)
