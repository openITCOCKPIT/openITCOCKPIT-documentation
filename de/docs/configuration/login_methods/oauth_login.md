# oAuth Login

Configuring openITCOCKPIT to use an OAuth2 server for authentication allows users to log in using their existing credentials from the OAuth2 provider.

First, you need to configure the systemsettings for oAuth2.

| Field                | Example Value                                 | Description                                                                                                                       |
|----------------------|-----------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| `AUTH_METHOD`        | `SSO OAuth2`                                  | Enables login via an OAuth2 server.                                                                                               |
| `SSO.CLIENT_ID`      | `my_client_id`                                | Provided by the OAuth2 administrator. Identifies openITCOCKPIT to the OAuth2 server.                                              |
| `SSO.CLIENT_SECRET`  | `some_client_password`                        | Also provided by the OAuth2 administrator. Used together with the Client ID to authenticate openITCOCKPIT with the OAuth2 server. |
| `SSO.AUTH_ENDPOINT`  | `https://192.168.1.207:3001/dialog/authorize` | URL of the OAuth2 server’s login page where users are redirected for authentication.                                              |
| `SSO.TOKEN_ENDPOINT` | `https://192.168.1.207:3001/oauth/token`      | Endpoint used by openITCOCKPIT to retrieve the access token after a successful login.                                             |
| `SSO.USER_ENDPOINT`  | `https://192.168.1.207:3001/api/userinfo`     | Endpoint used by openITCOCKPIT to retrieve additional user information from the OAuth2 server.                                    |
| `SSO.LOG_OFF_LINK`   | `https://192.168.1.207:3001/logout`           | URL used to log the user out from the OAuth2 server.                                                                              |

When configuring your oAuth2 provider, you will have to set the redirect URI to `https://<your_openitcockpit_url>/users/login`. 
Please note that the URL does NOT contain `/a/`, because it directly targets on the API of openITCOCKPIT. Otherwise you will get the following error page:
`You have reached the openITCOCKPIT backend API.`

After the configuration is done, you need to create the users that exist on the oAuth2 server in openITCOCKPIT. During creation, you need to 
- enable the checkbox "Enable login through oAuth2"
- use the exact same email address of the user in the oAuth2 provider
![Enable oAuth2 Login for a user](/images/configuration/login_methods/oauth2_setting_per_user.png)
 
If configurred correctly, users will be able to log into openITCOCKPIT after clicking "Login through single Sign-On". Which then leads to the login page of the oAuth2 provider.

