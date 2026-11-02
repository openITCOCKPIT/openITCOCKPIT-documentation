# Benutzerverwaltung

## Benutzer verwalten

Benutzer in openITCOCKPIT werden hier verwaltet.

In der Übersichtsseite findet man neben der Tabellarischen auflistung aller in openITCOCKPIT vorhandenen Benutzer auch
die möglichkeit das Passwort eines Benutzers zurückzusetzen.

### Neuen Benutzer anlegen

Um einen neuen Benutzer anzulegen, klicken Sie auf die Schaltfläche "Neuer Lokalen Benutzer".

Im sich nun öffnenden Formular wählen Sie zunächst die entsprechenden Container / Container Rollen aus, auf die der
Benutzer Zugriff haben soll.

Sie können auch Container und Container Rollen auswählen. Hierbei ist zu beachten, dass Einzeln zugewiesene Container
die Berechtigungen von Containerrollen überschreiben. Dies beutet, wenn ein Benutzer über eine Container-Rolle lese und
schreibrechte besitzt, kann dieses recht über den einzeln ausgewählten Container verändert werden. Dies hat den Vorteil,
dass Berechtigungen für einzelne Container nicht in einer komplett neuen Container-Rolle definiert werden müssen.

![container roles](/images/manageusers-containerroles.png)

Anschließend wählt man für den neuen Benutzer eine Benutzerrolle und setzt ihn auf "Ist aktiv". Ist für einen Benutzer
die auswahl box "ist aktiv" nicht gesetzt, kann sich dieser Benutzer nicht mehr in openITCOCKPIT Anmelden.

Neben den Standardfeldern E-Mail-Adresse, Vorname, Nachname, Unternehmen, Position und Telefonnummer hat man hier die
möglichkeit standardparameter festzulegen wie das Datumsformat, Zeitzone und die Sprache der Benutzeroberfläche. Diese
können vom Benutzer selbst auch über seine Profileinstellungen geändert werden.

Zudem kann man hier dem Benutzer schon API Keys für die API-Key authentifizierung erstellen.


| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container Rollen | :fontawesome-solid-xmark: | [Benutzercontainerrolle](#benutzer-container-rollen). Optionales Pflichtfeld - Entweder Container, Container Rollen oder beides muss ausgewählt sein |
| Container | :fontawesome-solid-xmark: | [Container](../container/). Optionales Pflichtfeld - Entweder Container, Container Rollen oder beides muss ausgewählt sein |
| Benutzer Rolle | :fontawesome-solid-xmark: | [Benutzer Rollen](#benutzer-rollen-verwalten) |
| ist aktiv | :fontawesome-solid-xmark: | Bestimmt ob ein Benutzer sich in openITCOCKPIT anmelden kann oder nicht |
| E-Mail Adresse | :fontawesome-solid-xmark: | E-Mail Adresse des Benutzers |
| Vorname | :fontawesome-solid-xmark: | Vorname des Benutzers |
| Nachname | :fontawesome-solid-xmark: | Nachname des Benutzers |
| Unternehmen |  | Unternehmenszugehörigkeit des Benutzers |
| Positions des Unternehmens |  | Position des Unternehmens |
| Telefonnummer |  | Telefonnummer des Benutzers |
| Länge der Listen |  | Bestimmt die anzahl der Elemente die der Benutzer in einer Liste sehen kann. Dies kann der Benutzer später über seine [Profileinstellungen](../../monitoring/user-interface/#profil) selbst ändern |
| Statuszeichen im Menü anzeigen |  | Blendet die [Statusinformationen](../../monitoring/user-interface/#profil-informationen) im Webseiten Header ein |
| Rekursiver Browser |  | Bestimmt ob im Browser die [Rekursive Ansicht](../../monitoring/user-interface/#profil-informationen) angezeigt werden soll |
| Tab Rotationsintervall |  | Tab Rotationsintervall im Dashboard |
| Datumsformat | :fontawesome-solid-xmark: | Format des für den Benutzer angezeigten Datums in openITCOCKPIT |
| Zeitzone | :fontawesome-solid-xmark: | Zeitzone des Benutzers |
| Sprache der Benutzeroberfläche | :fontawesome-solid-xmark: | Sprache der Benutzeroberfläche für den Benutzer |
| Neues Passwort | :fontawesome-solid-xmark: | Anmeldepasswort für den Benutzer |
| Bestätige Neues Passwort | :fontawesome-solid-xmark: | Anmeldepasswort für den Benutzer |


### Neuen Benutzer anlegen (Active Directory / LDAP)

Grundsätzlich funktioniert die erstellung eines Benutzers über LDAP ähnlich der erstellung eines Lokalen Benutzers.
Wählen Sie "Importiere von LDAP" um einen neuen Benutzer über LDAP hinzuzufügen.

Jedoch wird hier anstatt der E-Mail-Adresse, Vorname und Nachname anzugeben der SAM-Account-Name aus einer liste
ausgewählt. E-Mail, Vorname und Nachname wird dann automatisch ausgefüllt. Auch ein Passwort wird hier nicht vergeben,
da sich der neue Benutzer mit seinen LDAP zugangsdaten einloggt.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Container Rollen | :fontawesome-solid-xmark: | [Benutzercontainerrolle](#benutzer-container-rollen). Optionales Pflichtfeld - Entweder Container, Container Rollen oder beides muss ausgewählt sein |
| Container | :fontawesome-solid-xmark: | [Container](../container/). Optionales Pflichtfeld - Entweder Container, Container Rollen oder beides muss ausgewählt sein |
| Benutzer Rolle | :fontawesome-solid-xmark: | [Benutzer Rollen](#benutzer-rollen-verwalten) |
| ist aktiv | :fontawesome-solid-xmark: | Bestimmt ob ein Benutzer sich in openITCOCKPIT anmelden kann oder nicht |
| SAM-Account-Name | :fontawesome-solid-xmark: | Benutzer, der Importiert werden soll |
| DN | :fontawesome-solid-xmark: | Wird vom LDAP Server Importiert |
| E-Mail Adresse | :fontawesome-solid-xmark: | E-Mail Adresse des Benutzers. Wird vom LDAP Server Importiert |
| Vorname |  | Vorname des Benutzers. Wird vom LDAP Server Importiert |
| Nachname |  | Nachname des Benutzers. Wird vom LDAP Server Importiert |
| Unternehmen |  | Unternehmenszugehörigkeit des Benutzers |
| Positions des Unternehmens |  | Position des Unternehmens |
| Telefonnummer |  | Telefonnummer des Benutzers |
| Länge der Listen |  | Bestimmt die anzahl der Elemente die der Benutzer in einer Liste sehen kann. Dies kann der Benutzer später über seine [Profileinstellungen](../../monitoring/user-interface/#profil) selbst ändern |
| Statuszeichen im Menü anzeigen |  | Blendet die [Statusinformationen](../../monitoring/user-interface/#profil-informationen) im Webseiten Header ein |
| Rekursiver Browser |  | Bestimmt ob im Browser die [Rekursive Ansicht](../../monitoring/user-interface/#profil-informationen) angezeigt werden soll |
| Tab Rotationsintervall |  | Tab Rotationsintervall im Dashboard |
| Datumsformat | :fontawesome-solid-xmark: | Format des für den Benutzer angezeigten Datums in openITCOCKPIT |
| Zeitzone | :fontawesome-solid-xmark: | Zeitzone des Benutzers |
| Sprache der Benutzeroberfläche | :fontawesome-solid-xmark: | Sprache der Benutzeroberfläche für den Benutzer |


### Benutzerpasswort zurücksetzen

Um ein Benutzerpasswort zurückzusetzen, klicken sie auf der Übersichtsseite auf "Passwort zurücksetzen"

![reset password](/images/manageusers-resetpassword.png)

Der Benutzer bekommt eine E-Mail mit einem neuen Zufallsgenerierten Passwort, mit dem er sich auf dem System anmelden
kann.

## Benutzer Rollen verwalten

Benutzerrollen in openITCOCKPIT repräsentieren das Rollenkonzept für Benutzerrechte. Hier wird bestimmt, was ein
Benutzer, der diese Rolle zugewiesen bekommt, im openITCOCKPIT darf oder nicht darf.


## Neue Benutzer Rolle anlegen

Um eine neue Benutzerrolle anzulegen, klicken Sie auf die schaltfläche "Neu"

Dort Vergeben Sie einen Namen und eine Beschreibung für die neue Benutzerrolle.

Weiter unten im Formular können Sie die entsprechenden Rechte vergeben. Die rechte können granular für einzelne Seiten
und aktionen vergeben werden oder aber über die Schaltfläche "Massenaktionen" mehrere gleichzeitig.

Dort können dann entweder alle rechte, "Index", "Neu", "Editier" oder "Lösch" rechte vergeben werden, wobei Index, Neu, Editieren
und Löschen nacheinander angeklickt werden können, um diese einzeln für jede Seite zu aktivieren.

![userrole bulk actions](/images/manageuserroles-bulkactions.png)

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Name | :fontawesome-solid-xmark: | Name der Benutzer Rolle |
| Beschreibung |  | Beschreibung der Benutzer Rolle |

## Benutzer Container Rollen

Benutzer Container Rollen sind Sammlungen von Containerberechtigungen, die zur für Benutzer in openITCOCKPIT genutzt
werden können.

Eine Benutzer-Container-Rolle kann für die Berechtigung von Benutzern verwendet werden. Hierzu muss eine neue
Benutzer-Container-Rolle erstellt werden.

### Benutzer Container Rolle erstellen

Beim Erstellen einer Benutzer-Container-Rolle vergibt man einen Namen und wählt die gewünschten Container aus.

![containerroles add](/images/usercontainerroles-add.png)

Für die Container vergibt man die entsprechenden Rechte (lesen oder schreiben/lesen). Nach dem Speichern kann die
Benutzer Container Rolle verwendet werden.

| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Rollenname | :fontawesome-solid-xmark: | Name der Benutzer Container Rolle |
| Container | :fontawesome-solid-xmark: | [Container](../container/), welche der Benutzer Container Rolle zugewiesen werden sollen  |


### Meldung des Tages erstellen


| Feld | Erforderlich | Beschreibung |
|---|---|---|
| Title | :fontawesome-solid-xmark: | Pflichtfeld - Der Title wird ganz oben angezeigt und wird als Überschrift verwendet |
| Description | | Hier erhält Benutzer die Möglichkeit eine kurze Beschreibung für die Meldung des Tages zu hinterlegen |
| Datum | :fontawesome-solid-xmark: | Pflichtfeld -Das Datum wird für das Anzeigen des Meldung des Tages verwendet |
| Ablaufdauer | | Optionales Pflichtfeld - mit dem Setzen der Ablaufdauer wird die Meldung des Tages nur vorübergehend angezeigt  |
| Filter für Benutzergruppe| | Hier kann die Sichtbarkeit für Meldung des Tages für bestimmte Gruppen eingeschränkt werden |
| Benachrichtigung für Benutzer | | Wenn aktiv, werden betroffene Benutzer per Email benachrichtigt |
| Style | :fontawesome-solid-xmark: | Folgende Style-Eigenschaften stehen zur Auswahl: <span class="badge badge-info" title="info">info</span> <span class="badge badge-primary" title="primary">primary</span> <span class="badge badge-success" title="success">success</span> <span class="badge badge-warning" title="warning">warning</span> <span class="badge badge-danger" title="danger">danger</span>|
| Text | :fontawesome-solid-xmark: | Text für die Meldung des Tages |

Durch die Styleauswahl kann der Benutzer eine visuelle Informationswichtigkeit beziehungsweise Informationsart verdeutlichen.

![message of the day](/images/configuration/message-otd-styles.png)

Für das Erstellen des Textes steht ein WYSISYG Editor mit rudimentären Funktionen, wie Textfarbe, -größe und -ausrichtung und ähnliches, zur Verfügung. Mithilfe des Editors kann der eingegebene Text formatiert werden. 
Alle Änderungen werden sofort im Vorschaufenster angezeigt.  

![wysiwyg text editor](/images/configuration/message-otd-wysiwyg.png)
