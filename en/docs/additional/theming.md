# Selecting a theme and CI <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

## Design Module

You can adapt the appearance of your openITCOCKPIT installation as required using the DesignModule, which can be installed via the openITCOCKPIT [integrated Package manager](/configuration/packagemanager/).

You can also adjust the colours of the web interface and the logos used by the system via the design editor. No programming skills are required for completing these tasks.

![Modify the openITCOCKPIT theme](/images/openitcockpit-design-editor.png)

### Export / import design

You can import and export your own designs into another openITCOCKPIT system.
To export a design, you must first create and save a design. You will then need to scroll down to the very bottom of the Design Editor where you will find an "Export the currently saved design". button. This will export your current design as a `.json` file for download.

To import an exported design, click on the "Import" button and upload the corresponding `.json` file.

For example, you can use this method to load our [Halloween theme for openITCOCKPIT ](https://github.com/openITCOCKPIT/oitc-halloween-theme).

![Halloween theme for openITCOCKPIT](/images/openitcockpit-Halloween-login.jpg)

### Using your own CSS

To give you complete design freedom, you also have the option of storing your own CSS rules. This means all spacing, colours and fonts can be adjusted as required.

!!! tip
Creating CSS rules requires knowledge of cascading style sheets and should only be set up by experienced users.

!!! Angular-Selectors
You can style entire components by their selector from angular, system-wide. E.g. you can re-styl our status icons to blink when they are in an danger state.

```CSS
/* Make status icons blink */
oitc-hoststatus-icon .btn-danger {
  animation: alarmAnimation 1s steps(2, start) infinite;
  -webkit-animation: alarmAnimation 1s steps(2, start) infinite;
}
oitc-servicestatus-icon .btn-danger {
  animation: alarmAnimation 1s steps(2, start) infinite;
  -webkit-animation: alarmAnimation 1s steps(2, start) infinite;
}

@keyframes alarmAnimation {
  to {
    background:red;
  }
  from {
    background:yellow;
  }
}
@-webkit-keyframes alarmAnimation {
  to {
    background:red;
  }
}
```