# Telegram <span class="badge badge-primary badge-outlined" title="Community Edition">CE</span>

## Was kann ich mit dem Telegram-Modul machen?

Wie andere Benachrichtigungsmodule verwendet das Telegram-Modul einen Telegram-Bot, um Benachrichtigungen und
Bestätigungen von openITCOCKPIT an einen Telegram-Chat zu senden.

![](/images/telegram/1-feature.png)

## Wie wird das Modul konfiguriert?

Die Einstellungen des Telegram-Moduls findest du unter System Configuration → APIs → Telegram.

| Feldname              | Pflichtfeld | Beschreibung                                                                       |
|-----------------------|-------------|------------------------------------------------------------------------------------|
| API-Token             | :warning:   | Das API-Token, das dir BotFather beim Erstellen deines Telegram-Bots bereitstellt. |
| Proxyserver verwenden |             | Legt fest, ob der konfigurierte Proxyserver verwendet werden soll.                 |

## Voraussetzungen

Um das Telegram-Modul verwenden zu können, benötigst du mindestens ein Telegram-Konto. Der Telegram-Bot sendet
Benachrichtigungen an Benutzer, die sich mit dem Bot verbunden und sich mit einem in openITCOCKPIT generierten Schlüssel
authentifiziert haben.

### 1. Einen Telegram-Bot erstellen

![](/images/telegram/2-botfather.png)

- Starte einen neuen Telegram-Chat mit @BotFather.
- Klicke auf „Start“ und führe den Befehl `/newbot` aus:
    - Wähle einen Namen für deinen Bot, beispielsweise `DEV-openITCOCKPIT`.
    - Wähle einen Benutzernamen für deinen Bot, beispielsweise `oitc_uzumymw_bot`.
- Öffne deine openITCOCKPIT-Instanz.
- Kopiere das von BotFather bereitgestellte API-Token in den Bereich System Configuration -> APIs -> Telegram.

![](/images/telegram/3-oitc-tele-api.png)

### 2. Kontakte konfigurieren

- Navigiere zu Monitoring->Objects->Contacts.
- Erstelle einen neuen Kontakt oder bearbeite einen bestehenden Kontakt.
- Füge die Benachrichtigungsbefehle hinzu, die du verwenden möchtest:
    - `host-notify-by-telegram`
    - `service-notify-by-telegram`

![](/images/telegram/4-contact.png)

- Speichere deine Änderungen und navigiere anschließend zur Seite System Configuration -> APIs -> Telegram.
- Auf dieser Seite werden die Benutzer angezeigt, die für die Verwendung der Telegram-Benachrichtigungsbefehle
  konfiguriert sind.
- Klicke neben dem entsprechenden Benutzer auf „Generate Key“ und sende den generierten Schlüssel an diesen Benutzer.

![](/images/telegram/5-join-openitcockpit.png)

### 3. Dem Bot beitreten

- Bitte den Benutzer, deinen Bot in der Telegram-App zu suchen und auf „Start“ zu klicken, um einen Chat zu öffnen. In
  diesem Beispiel kann der Bot durch die Suche nach `oitc_uzumymw_bot` gefunden werden.

![](/images/telegram/6-join-telegram.png)

- Nachdem der Chat gestartet wurde, muss sich der Benutzer beim Bot authentifizieren.
- Der Benutzer muss `/auth THEUSERSGENERATEDKEY` an den Bot senden. Dabei muss `THEUSERSGENERATEDKEY` durch den für sein
  Konto generierten Schlüssel ersetzt werden. Bei erfolgreicher Authentifizierung sendet der Bot eine
  Bestätigungsnachricht.

Anschließend stehen dem Benutzer mehrere Optionen zur Verfügung:

- `/start` aktiviert openITCOCKPIT-Benachrichtigungen.
- `/stop` deaktiviert openITCOCKPIT-Benachrichtigungen.
- `/help` zeigt diesen Hilfetext erneut an.
- `/delete` löscht diese Bot-Verbindung in openITCOCKPIT.

![](/images/telegram/7-testmessage.png)

### Nützliche Informationen

Interaktionen mit der API können bis zu einer Minute dauern, bis sie abgeschlossen sind.
Wenn deine openITCOCKPIT-Instanz nicht über das Internet erreichbar ist, musst du möglicherweise warten, bis der nächste
Cronjob ausgeführt wird, bevor Änderungen wirksam werden.

Nachdem sich der Benutzer erfolgreich authentifiziert hat, kannst du seinen generierten Schlüssel auf der Seite System
Configuration -> APIs -> Telegram löschen.