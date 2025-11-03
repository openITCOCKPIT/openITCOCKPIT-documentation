# Kiosk Mode

The primary goal of the article is, to set up a system which does not require any manual authentication to display the openITCOCKPIT web interface. Often this is used to running openITCOCKPIT on a large wall mounted TV screen.

!!! danger
    Please be aware of that when you setup a Kiosk System, any person who has access to the kiosk
    has also access to your openITCOCKPIT system.
    It is highly recommended to create a separate user for this with very low permissions.
    See [User management](/en/configuration/usermanagement/#managing-user-roles) for more information about user permissions.

First of all, you have to create a new user in openITCOCKPIT, which has very low user permissions. While you create the user, please make sure to also create a new [API key](/en/development/api/#api-keys) and copy the key. [API keys](/en/development/api/#api-keys) can also be created later on.


In the next step, install the browser extension [SimpleModifyHeaders](https://github.com/didierfred/SimpleModifyHeaders) on your kiosk system. The SimpleModifyHeaders browser extension will add the API key to all requests done by the browser automatically, so openITCOCKPIT will no longer ask for any login credentials.

- SimpleModifyHeaders for [Chrome](https://chrome.google.com/webstore/detail/simple-modify-headers/gjgiipmpldkpbdfjkgofildhapegmmic)
- SimpleModifyHeaders for [Firefox](https://addons.mozilla.org/firefox/addon/simple-modify-header/)


Create a new Request Header with the name `Authorization` and as value `X-OITC-API <API-KEY>`

For Example:

| Name            | Value                                         |
|-----------------|-----------------------------------------------|
| `Url Patterns`  | `https://monitoring.itsm.love/*`              |
| `Authorization` | `X-OITC-API fe9ab803c661d712059c0e6c15[...]`  |

![openITCOCKPIT Authorization header](/images/simple_modify_header_firefox_example.png)

You can now access your openITCOCKPIT system without the need to pass any user credentials.

!!! danger
    SimpleModifyHeaders will add this header and your API key to **all requests**. If you use this system to browse the web, make sure to disable SimpleModifyHeaders to avoid leaking your API key.

# Kiosk Front-End
Additionally to the kiosk authentication, there's a kiosk-mode for the openITCOCKPIT front-end.
To enable that, you just need to add the URI parameter `?kiosk` to your openITCOCKPIT address.

Now, the navigation bars, headers and footers will be hidden to make more space for the actual content.

Anyway, if you want to access the navigation again, you can click the button `Exit Kiosk Mode`.

![openITCOCKPIT Kiosk-Mode Front-End](/images/kiosk_mode_front_end.png)


