# PHP LDAP / Microsoft Active Directory

This page shows you, how to setup the login via LDAP in openITCOCKPIT. This method is based on the PHP LDAP extension
and can be used with Microsoft Active Directory as well as with OpenLDAP.

You can import both, users and contacts from the LDAP/AD for notifications.
If you set up openITCOCKPIT to accept logins from LDAP users, it still accepts logins from local users from its own
database.
This can be handy in case you need to log in as a user which is not present on the LDAP server, like external support
agents, etc.

To connect your LDAP Server, you'll need to set up the connection in openITCOCKPIT's System Settings.

| System Setting                | Example Value                                                                              | Description                                                                                                                                                                                                         |
| ----------------------------- | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `LDAP.TYPE`                   | `Active Directory LDAP`                                                                    | Select the LDAP variant used by openITCOCKPIT. Choose **“Active Directory LDAP”** when connecting to Microsoft Active Directory. In most other cases, select **“OpenLDAP.”**                                        |
| `LDAP.ADDRESS`                | `ad.yourdomain.tld`                                                                        | Hostname or IP address of your LDAP server.                                                                                                                                                                         |
| `LDAP.PORT`                   | `389`                                                                                      | Port used by the LDAP server. Default is **389** (or **636** for LDAPS).                                                                                                                                            |
| `LDAP.QUERY` (OpenLDAP)       | `(&(objectClass=inetOrgPerson)(uid=*))`                                                    | User search filter for OpenLDAP environments.                                                                                                                                                                       |
| `LDAP.QUERY` (MS AD)          | `(&(objectClass=user)(samaccounttype=1337)(objectCategory=person)(cn=*))`                  | User search filter for Microsoft Active Directory environments.                                                                                                                                                     |
| `LDAP.BASEDN`                 | `DC=ad,DC=openitcockpit,DC=io`                                                             | Base Distinguished Name (Base DN) where user searches are performed.                                                                                                                                                |
| `LDAP.USERNAME` (MS AD)       | `readonlyUser`                                                                             | Username of an account with sufficient permissions to query Active Directory.                                                                                                                                       |
| `LDAP.USERNAME` (OpenLDAP)    | `CN=ldap search,OU=Service Accounts,OU=ad.openitcockpit.com,DC=ad,DC=openitcockpit,DC=com` | Full Distinguished Name (DN) of the service account used for authentication in OpenLDAP.                                                                                                                            |
| `LDAP.PASSWORD`               | `Another1BytesTheDust!`                                                                    | Password of the configured LDAP service account.                                                                                                                                                                    |
| `LDAP.SUFFIX`                 | `@ad.openitcockpit.io`                                                                     | Suffix appended to usernames during authentication.                                                                                                                                                                 |
| `LDAP.USE_TLS`                | `Plain`, `StartTLS`, or `TLS`                                                              | Defines the encryption method. **Plain** = unencrypted connection. **StartTLS** = starts unencrypted and upgrades to encrypted. **TLS** (LDAPS) = encrypted connection from the beginning (typically port **636**). |
| `LDAP.GROUP_QUERY` (MS AD)    | `ObjectClass=Group`                                                                        | Group search filter for Microsoft Active Directory.                                                                                                                                                                 |
| `LDAP.GROUP_QUERY` (OpenLDAP) | `ObjectClass=posixGroup`                                                                   | Group search filter for OpenLDAP environments.                                                                                                                                                                      |


# Import LDAP Users from LDAP

After setting up the connection to your LDAP server, you can import users from the LDAP server under "User
Management" => "Manage Users" => "Import from LDAP". Right after saving, the user is able to log in with their LDAP credentials.

![Import LDAP Users from LDAP](/images/configuration/login_methods/ldap_import_users.png)
![Import LDAP Users from LDAP](/images/configuration/login_methods/ldap_import_users_2.png)

# Import contacts from LDAP

Under "Monitoring" => "Manage Contacts", you can import contacts from the LDAP server.
Kontakte können einfach unter Contacts aus dem AD/LDAP Importiert werden und anschließend für die Benachrichtigung
genutzt werden

![Import contacts from LDAP](/images/configuration/login_methods/ldap_import_contacts.png)
![Import contacts from LDAP](/images/configuration/login_methods/ldap_import_contacts_2.png)

# Conditions

openITCOCKPIT can only import users from the LDAP/AD if the following fields are set:

- Microsoft Active Directory
    - `samaccountname`, `mail`, `sn`, `givenname`

- OpenLDAP
    - `uid`, `mail`, `sn`, `givenname`

 