# Kiosk Mode

Das Primärziel dieses Artikels ist es, ein System einzurichten, welches keine manuelle Authentifizierung benötigt, um die Weboberfläche von openITCOCKPIT aufrufen zu können. Meistens sind solche Systeme große Bildschirme, welche an einer Wand befestigt sind.


!!! danger
    Bitte beachten Sie, das alle Personen die Zugriff auf das Kiosk-System haben, auch Zugriff auf oenITCOCKPIT haben.
    Es wird daher dringen empfohlen, einen eigenen openITCOCKPIT Benutzer mit sehr geringen Benutzerberechtigungen zu erstellen.
    Mehr dazu erfharen Sie unter [Benutzerverwaltung](/configuration/usermanagement/#benutzer-rollen-verwalten).

Zuerst müssen Sie einen neuen Benutzer in openITCOCKPIT erstellen, welcher sehr geringe Berechtigungen hat. Während Sie den Benutzer erstellen, können Sie dem Benutzer auch gleich einen [API Keys](/development/api/#api-keys) hinzufügen.
[API Keys](/development/api/#api-keys) können auch später noch erstellt werden.

Im nächsten Schritt installieren Sie auf dem Kiosk-System die Browser-Erweiterung  [SimpleModifyHeaders](https://github.com/didierfred/SimpleModifyHeaders). Die SimpleModifyHeaders Browser-Erweiterung wird später den API Key an alle Anfragen, welche vom Webbrowser ausgeführt werden, automatisch anhängen. Somit sind keine weiteren Anmeldedaten mehr erforderlich.

- SimpleModifyHeaders für [Chrome](https://chrome.google.com/webstore/detail/simple-modify-headers/gjgiipmpldkpbdfjkgofildhapegmmic)
- SimpleModifyHeaders für [Firefox](https://addons.mozilla.org/firefox/addon/simple-modify-header/)


Erstellen Sie einen neuen Request Header mit dem Namen `Authorization` und setzen Sie `X-OITC-API <API-KEY>` als Value.

Zum Beispiel:

| Name            | Value                                         |
|-----------------|-----------------------------------------------|
| `Url Patterns`  | `https://monitoring.itsm.love/*`              |
| `Authorization` | `X-OITC-API fe9ab803c661d712059c0e6c15[...]`  |

![openITCOCKPIT Authorization header](/images/simple_modify_header_firefox_example.png)

Ab jetzt können Sie auf openITCOCKPIT zugreifen, ohne Anmeldedaten eingeben zu müssen.

!!! danger
    ModHeader sendet den API-Key **mit jeder Anfrage**. Wenn Sie das System nutzen, um im Internet zu surfen, sollten Sie die Erweiterung deaktivieren, damit Sie ihren API Key nicht preisgeben.

# Kiosk Front-End
Zusätzlich zum Kiosk-Login gibt es auch den Kiosk-Mode für das Front-End. 
Wenn an die Adresse des openITCOCKPIT der Parameter `?kiosk` angehängt wird, öffnet sich openITCOCKPIT im Kiosk-Modus.

Jetzt werden Navigationsleisten, Kopf- und Fußzeilen ausgeblendet, um eine möglichst große Darstellungsfläche für die eigentlichen Inhalte zu schaffen.

Wenn die ausgeblendeten Elemente doch gebraucht werden, kann man jederzeit auf den Button `Exit Kiosk Mode` klicken.

![openITCOCKPIT Kiosk-Mode Front-End](/images/kiosk_mode_front_end.png)


