# LDAP Integration

openITCOCKPIT kann für die Benutzerauthentifizierung mit einem LDAP Server verbunden werden. Primär wird dabei die
Verwendung von
_Microsoft Active Directory_ empfohlen und unterstützt. Die Nutzung eines _OpenLDAP Servers_ ist ebenfalls möglich,
jedoch können dann einige Funktionen nur eingeschränkt oder gar nicht zur Verfügung stehen.

## LDAP Authentifizierung

Um eine Authentifizierung gegen LDAP zu aktivieren, müssen Sie zuerst
unter `Systemkonfiguration -> System -> `[`Systemeinstellungen`](/configuration/systemsettings/)
die Daten Ihres LDAP-Servers hinterlegen.

Es wird die Verwendung von _Microsoft Active Directory_ empfohlen.

### Microsoft Active Directory

| Key              | Beschreibung                                                                                                                  | Beispiel                                                               |
|------------------|-------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|
| AUTH_METHOD      | Welches Authentifizierungsverfahren von openITCOCKPIT genutzt werden soll.                                                    | PHP LDAP                                                               |
| LDAP.TYPE        | Ob es sich um ein Microsoft Active Directory server oder um einen Open LDAP Server handelt                                    | Active Directory LDAP                                                  |
| LDAP.ADDRESS     | Hostname oder IP-Adresse des zu verwenden LDAP-Servers                                                                        | `ad.example.com`                                                         |
| LDAP.PORT        | Port-Nummer (389 oder 636)                                                                                                    | `389`                                                                    |
| LDAP.QUERY       | LDAP Filter zum Filtern von Benutzern                                                                                         | `(&(objectClass=user)(samaccounttype=805306368)`(objectCategory=person)(cn=*))` |
| LDAP.BASEDN      | Die zu durchsuchende Base-DN                                                                                                  | `DC=ad,DC=example,DC=com`                                                |
| LDAP.USERNAME    | Benutzername (sAMAccountName) welcher von openITCOCKPIT genutzt werden soll                                                   | `ldap_search`                                                            |
| LDAP.PASSWORD    | Password des Benutzers                                                                                                        |                                                                        |
| LDAP.SUFFIX      | Der zu verwendende Suffix                                                                                                     | `@ad.example.com`                                                        |
| LDAP.USE_TLS     | Plain = Klartext, StartTLS = versucht eine verschlüsselte Verbindung zu nutzen, TLS = erzwingt eine verschlüsselte Verbindung | `StartTLS`                                                               |
| LDAP.GROUP_QUERY | LDAP Filter zum Filtern von Benutzergruppen                                                                                   | `ObjectClass=Group`                                                    |



### Open LDAP

| Key              | Beschreibung                                                                                                                  | Beispiel                                      |
|------------------|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| AUTH_METHOD      | Welches Authentifizierungsverfahren von openITCOCKPIT genutzt werden soll.                                                    | `PHP LDAP`                                    |
| LDAP.TYPE        | Ob es sich um ein Microsoft Active Directory server oder um einen Open LDAP Server handelt                                    | `OpenLDAP`                                    |
| LDAP.ADDRESS     | Hostname oder IP-Adresse des zu verwenden LDAP-Servers                                                                        | `open-ldap.oitc.itn`                          |
| LDAP.PORT        | Port-Nummer (389 oder 636)                                                                                                    | `389`                                         |
| LDAP.QUERY       | LDAP Filter zum Filtern von Benutzern                                                                                         | `(&(objectClass=inetOrgPerson)(uid=*))`       |
| LDAP.BASEDN      | Die zu durchsuchende Base-DN                                                                                                  | `dc=example,dc=com`                           |
| LDAP.USERNAME    | Benutzername (als DN), die von openITCOCKPIT genutzt werden soll                                                              | `uid=ldap_search,ou=people,dc=example,dc=com` |
| LDAP.PASSWORD    | Password des Benutzers                                                                                                        |                                               |
| LDAP.SUFFIX      | Der zu verwendende Suffix                                                                                                     | `<leer>`                                      |
| LDAP.USE_TLS     | Plain = Klartext, StartTLS = versucht eine verschlüsselte Verbindung zu nutzen, TLS = erzwingt eine verschlüsselte Verbindung | `Plain`                                       |
| LDAP.GROUP_QUERY | LDAP Filter zum Filtern von Benutzergruppen                                                                                   | `ObjectClass=posixGroup`                      |


## Importieren von Benutzern

Bevor sich ein LDAP-Benutzer an openITCOCKPIT anmelden kann, ist es zwingen erforderlich den Benutzer zu importieren.
Dies erfolgt unter `Benutzerverwaltung -> Verwalte Benutzer -> `[`Importiere von LDAP`](/configuration/usermanagement/#neuen-benutzer-anlegen-active-directory-ldap)

![Import LDAP User](/images/import-ldap-user.png)

Dies kann auch als Test genutzt werden um zu überprüfen, ob die Verbindung mit dem LDAP-Server erfolgreich hergestellt werden konnte.

**Es wird empfohlen mindestendes einen lokalen Administrator-Benutzer zu erstellen, damit im Falle eines Ausfalls des LDAP-Servers weiterhin eine Zugriffsmöglichkeit auf openITCOCKPIT besteht.**

!!! important
    Für openITCOCKPIT ist es erforderlich, dass die Felder:
     
    Microsoft AD: `'samaccountname', 'mail', 'sn', 'givenname'`
    
    Open LDAP: `'uid', 'mail', 'sn', 'givenname'`
    
    befüllt sind. Benutzer die diese Anforderung nicht erfüllen, werden automatisch ausgeblendet.
    Sobald openITCOCKPIT Benutzer ausblendet, wird dies mit der Zeile `2022-01-07 15:42:06 warning: Dropped 51/100 AD/LDAP users due to missing required fields. [samaccountname, mail, sn, givenname]` in der Logdatei `/opt/openitc/frontend/logs/error.log` angezeigt.

## Importieren von Gruppen
!!! info
    Benötigt openITCOCKPIT ≥ 4.4.0


openITCOCKPIT importiert automatisch alle 24 Stunden alle verfügbaren LDAP Gruppen und speichert diese in der Datenbank.

Dieser Prozess kann über den Befehl `oitc cronjobs -f` manuell durchgeführt werden.
```
Scan for new LDAP groups. This will take a while...
Imported 50 groups, removed 3 groups from database.
   Ok
```

## Automatische Berechtigungen über LDAP-Gruppen

openITCOCKPIT unterstützt das automatische zuweisen von [Benutzer Container Rollen](/configuration/usermanagement/#benutzer-container-rollen) und [Benutzer Rollen](/configuration/usermanagement/#benutzer-rollen-verwalten)
über LDAP-Gruppen. Dies steht nur bei Benutzern zur Verfügung, welche aus dem LDAP-Importiert wurden.

openITCOCKPIT fragt dazu alle 24 Stunden die aktuellen Gruppen aller hinterlegten LDAP-Benutzer ab und gleicht diese mit den Benutzer Container Rollen und Benutzer Rollen ab.

Dieser Prozess kann über den Befehl `oitc cronjobs -f` manuell durchgeführt werden.
```
Assign User Container Roles that have LDAP associations to users
Query LDAP groups from LDAP for user dziegler
Query LDAP groups from LDAP for user ibering
   Ok
```

### LDAP-Gruppen zu Benutzer Container Rollen zuweisen
Jeder User Container Rolle kann optional eine (oder mehrere) LDAP-Gruppen zugewiesen werden. openITCOCKPIT wird diese Information nutzen und automatisch allen
Benutzern, welche in den hinterlegten LDAP-Gruppen sind, die User Container Rolle zuweisen.
![Linking User Container Roles with LDAP groups](/images/ldap-user-container-roles.png)

Einem Benutzer können mehre User Container Rollen zugewiesen werden. Somit ist eine maximale flexibilität gewährleistet. User Container Rollen entscheiden darüber, welche
Objekte (Hosts, Servicevorlagen, Reports, usw) ein Benutzer sehen oder bearbeiten darf.


### LDAP-Gruppen zu Benutzerrollen zuweisen
Jeder Benutzerrolle kann optional eine (oder mehrere) LDAP-Gruppen zugewiesen werden. openITCOCKPIT nutzt diese Information um LDAP-Benutzern beim Login automatisch einer
Benutzerrolle zuzuweisen. Da einem Benutzer nur eine Rolle zugewiesen werden kann, werden im Falle von mehren Treffern die Benutzerrollen alphabetisch sortiert und die erste Benutzerrolle genommen.
Somit ist eine manuelle priorisierung durch die Benamung möglich.
![Linking User Roles with LDAP groups](/images/ldap-user-roles.png)

Da jedem Benutzer eine Benutzer Rolle zugewiesen werden muss, muss beim Erstellen eines LDAP-Users eine `Fallback Benutzer Rolle` angegeben werden. Diese Rolle wird immer dann genommen,
wenn dem Benutzer über LDAP keine Benutzer Rolle zugewiesen werden kann. Es wird empfohlen, eine `LDAP Fallback User Role` zu erstellen, welche keine Berechtigungen enthält.

Somit sieht ein Benutzer, dem keine Benutzerrolle zugewiesen werden konnte, nur das Dashboad von openITCOCKPIT. Im Gegensatz zu
_User Container Rollen_ entscheiden Benutzerrollen darüber, welche Aktionen von einem Benutzer ausgeführt werden dürfen.

### Importieren eines LDAP-Benutzers mit automatischer Gruppenzuweisung (Beispiel)
In diesem Beispiel wird ein neuer Benutzer über LDAP importiert. Das System hat dabei die User Container Rollen und die Benutzer Rolle automatisch dem Benutzer zugewiesen.
![Import a new LDAP-User and automatically assign user container roles and a user role](/images/import-ldap-user-auto-assign-groups.png)**

## Automatisches Importieren von Benutzern
!!! info
    Benötigt openITCOCKPIT ≥ 5.7.0

Seit openITCOCKPIT 5.7.0 ist es möglich, Benutzer automatisch aus Active Directory oder LDAP zu importieren. Den Benutzern werden dabei automatisch die konfigurierten Benutzercontainerrollen (User Container Roles) und Benutzerrollen (User Roles) zugewiesen. Das ist besonders in großen Umgebungen mit vielen Benutzern hilfreich.

Bevor Sie starten: Diese Funktion setzt voraus, dass der Import von LDAP-Gruppen bereits konfiguriert ist und funktioniert. Weitere Informationen finden Sie oben unter [Importieren von Gruppen](#importieren-von-gruppen).

Zur Verwaltung der Berechtigungen importierter Benutzer verwendet der Importer die bereits definierten **Benutzercontainerrollen** und **Benutzerrollen**. Falls noch nicht geschehen, erstellen Sie bitte vor dem automatischen Benutzerimport die erforderlichen **Benutzercontainerrollen** und **Benutzerrollen**.

Im nächsten Schritt können Sie neue **LDAP User Defaults** anlegen. Diese Defaults definieren, welche Benutzer vom LDAP-Server importiert werden und welche Berechtigungen den Benutzern zugewiesen werden. Sie können mehrere Defaults für unterschiedliche Benutzergruppen erstellen.

- **Container:** Definiert nur, zu welchen Containern der Default gehört. Dies hat keinen Einfluss auf die importierten Benutzer. Es dient ausschließlich zur Organisation der Defaults selbst.
- **Name:** Der Name des Defaults.
- **LDAP Gruppen:** Der Importer sucht nach **allen Benutzern, die Mitglied der konfigurierten LDAP-Gruppen sind**. Wenn mehrere Gruppen konfiguriert sind, sucht der Importer nach allen Benutzern, die Mitglied von **mindestens einer der konfigurierten Gruppen** sind. Es können nur LDAP-Gruppen ausgewählt werden, denen eine **Benutzercontainerrolle** zugewiesen ist.
- **Zusätzlicher Container:** Jeder über diesen Default importierte Benutzer wird dem konfigurierten Container zugewiesen. Dies ist eine **optionale** Einstellung, um einen Container aus den **Benutzercontainerrollen** zu ergänzen oder zu überschreiben.
- **Fallback Benutzerrolle:** Es wird empfohlen, die Zuordnung von LDAP-Gruppen zu **Benutzerrollen** direkt in der Definition der Benutzerrollen vorzunehmen. Falls jedoch keine Zuordnung definiert ist oder keine LDAP-Gruppe passt, wird dem Benutzer die konfigurierte Fallback Benutzerrolle zugewiesen. Es wird empfohlen, eine Fallback Benutzerrolle mit **eingeschränkten Berechtigungen** zu erstellen, damit Benutzer ohne passende LDAP-Gruppe keinen Zugriff auf openITCOCKPIT erhalten.

Falls eine LDAP-Gruppe mehreren LDAP Defaults zugewiesen ist, wird der Benutzer vom zuerst passenden Default importiert. Die Reihenfolge ist zufällig und kann nicht beeinflusst werden.

![LDAP User Defaults](/images/ldap-user-defaults.png)

Das Beispiel im obigen Screenshot importiert alle Benutzer, die Mitglied der LDAP-Gruppen `Domain Admins` oder `G_Role_IT` sind.

- Für `G_Role_IT` wird die **Benutzercontainerrolle** `AVENDIS Open Source Solutions Team` zugewiesen.
- Für `Domain Admins` wird die **Benutzercontainerrolle** `openITCOCKPIT Global Admin` zugewiesen.
- Benutzer, die Mitglied beider Gruppen sind (`Domain Admins` und `G_Role_IT`), erhalten Berechtigungen für alle Container beider **Benutzercontainerrollen**. Es gilt jeweils die höchste Berechtigung.

Als **Fallback Benutzerrolle** ist standardmäßig die Benutzerrolle `Viewer` zugewiesen, die weiterhin Zugriff auf viele Informationen hat. Daher wird empfohlen, eine neue Fallback Benutzerrolle ohne Berechtigungen zu erstellen und diese den LDAP User Defaults zuzuweisen.

### Benutzer per Cronjob importieren

Standardmäßig erstellt openITCOCKPIT automatisch einen neuen Cronjob namens `LdapUserImport`. Dieser ist standardmäßig deaktiviert und muss manuell aktiviert werden. Der Cronjob läuft alle 24 Stunden und importiert alle Benutzer, die Mitglied der konfigurierten LDAP-Gruppen sind. Navigieren Sie zu `System Tools -> Cron Jobs` und bearbeiten Sie den Cronjob `LdapUserImport`, um ihn zu aktivieren. Sie können den Zeitplan des Cronjobs außerdem an Ihre Anforderungen anpassen.

Falls der Cronjob auf Ihrem System fehlt, können Sie ihn mit folgenden Einstellungen neu anlegen:

- **Plugin:** `Core`
- **Task:** `LdapUserImport`
- **Intervall:** `1440` (Wert in Minuten, Standard ist 24 Stunden)
- **Priorität:** `low`
- **Aktiviert:** `Ja`

![LdapUserImport-Cronjob aktivieren oder erstellen](/images/enable-ldapuserimport-cronjob.png)

Sie können die Ausführung des Cronjobs auch mit dem Befehl `oitc cronjobs -f -t LdapUserImport` erzwingen. Die Ausgabe sieht dann ähnlich wie folgt aus:

```sh
$ oitc cronjobs -f -t LdapUserImport
Start openITCOCKPIT cronjobs...
-------------------------------------------------------------------------------
Priority: high
Skipping cronjob ScmModule.CheckResourceGroupStatus
Priority: low
Skipping cronjob Core.CleanupTemp
Skipping cronjob Core.DatabaseCleanup
[...]
Scan for new LDAP users. This will take a while...
✅ Matching default template found for user: Ryan, Thompson (R.Thompson) → AVENDIS Open Source Solutions Team [ID: 1]
Imported LDAP user: Ryan, Thompson (R.Thompson)
✅ Matching default template found for user: Thomas, Jones (T.Jones) → AVENDIS Open Source Solutions Team [ID: 1]
Imported LDAP user: Thomas, Jones (T.Jones)
✅ Matching default template found for user: Amy, Nguyen (A.Nguyen) → AVENDIS Open Source Solutions Team [ID: 1]
Imported LDAP user: Amy, Nguyen (A.Nguyen)
✅ Matching default template found for user: Deborah, Clark (D.Clark) → Contoso Example [ID: 2]
Imported LDAP user: Deborah, Clark (D.Clark)
✅ Matching default template found for user: Joseph, Young (J.Young) → Contoso Example [ID: 2]
Imported LDAP user: Joseph, Young (J.Young)
✅ Matching default template found for user: Ronald, Jones (R.Jones) → Contoso Example [ID: 2]
Imported LDAP user: Ronald, Jones (R.Jones)
✅ Matching default template found for user: Matthew, King (Ma.King) → Contoso Example [ID: 2]
Imported LDAP user: Matthew, King (Ma.King)
✅ Matching default template found for user: Timothy, Flores (Ti.Flores) → Contoso Example [ID: 2]
Imported LDAP user: Timothy, Flores (Ti.Flores)
Imported 8 users.
   Ok
-------------------------------------------------------------------------------
```

