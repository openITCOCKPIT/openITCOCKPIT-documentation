# Kiosk Mode

The primary goal of the article is, to set up a system which does not require any manual authentication to display the openITCOCKPIT web interface. Often this is used to running openITCOCKPIT on a large wall mounted TV screen.

!!! danger
    Please be aware of that when you setup a Kiosk System, any person who has access to the kiosk
    has also access to your openITCOCKPIT system.
    It is highly recommended to create a separate user for this with very low permissions.
    See [User management](/en/configuration/usermanagement/#managing-user-roles) for more information about user permissions.

First of all, you have to create a new user in openITCOCKPIT, which has very low user permissions. While you create the user, please make sure to also create a new [API key](/en/development/api/#api-keys) and copy the key. [API keys](/en/development/api/#api-keys) can also be created later on.

!!! info
    In the past, we recommended the `ModHeader` browser extension which is/was available for all major browsers.
    We were informed by our community that the extension injects advertising and is no longer open source.

    Please let us know, if you know a good alternative.


In the next step, install a browser extension ModHeader on your kiosk system. The ModHeader browser extension will add the API key to all requests done by the browser automatically, so openITCOCKPIT will no longer ask for any login credentials.

Create a new Request Header with the name `Authorization` and as value `X-OITC-API <API-KEY>`

For Example:

| Name            | Value                                         |
|-----------------|-----------------------------------------------|
| `Authorization` | `X-OITC-API fe9ab803c661d712059c0e6c15[...]`  |

![openITCOCKPIT Authorization header](/images/modheader-kiosk.png)

You can now access your openITCOCKPIT system without the need to pass any user credentials.

!!! danger
    ModHeader will add this header and your API key to **all requests**. If you use this system to browse the web, make sure to disable ModHeader to avoid leaking your API key.

