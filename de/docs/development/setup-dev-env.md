# openITCOCKPIT Entwicklungsumgebung erstellen

## Virtuelle Maschine erstellen

Es wird empfohlen, eine neue virtuelle Maschine (bspw. mit [VirtualBox](https://www.virtualbox.org/)) zu erstellen, 
welche die folgenden Mindestvoraussetzungen erfüllt:

| OS | Festplatte | RAM | CPU Kerne |
|---|---|---|---|
| Ubuntu Focal 20.04 (64 Bit) | 20 GB | 2048 MB | 2 |

Damit Sie die Maschine über das Netzwerk erreichen können, wählen Sie unter den Netzwerkeinstellungen der virtuellen
Maschine `Netzwerkbrücke` (Englisch: `Bridget Network`). 

Falls Sie keine Netzwerkbrücke nutzen wollen, empfehlen wir die einrichtung zweier Netzwerkkarten für die virtuelle
Maschine. Eine Netzwerkkarte im `NAT` Modus, damit der Zugriff auf das Internet gewährleistet ist und eine weitere im
`Host-Only Network` um den Zugriff der VM durch Ihren Lokalen Computer zu ermöglichen.

Um mehr Informationen zum Thema Netzwerk mit VirtualBox zu erhalten, klicken Sie auf den folgenden Link <https://www.virtualbox.org/manual/ch06.html>

Falls gewünscht können Sie auch "Ubuntu Desktop" nutzen, um eine Grafische Benutzeroberfläche zu erhalten.

## Betriebssystem vorbereiten

Stellen Sie sicher, dass auf ihrem System die aktuellsten Updates installiert sind.

```bash
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get dist-upgrade
```

### Installation von benötigten Paketen für die Entwicklung

```bash
sudo apt-get dist-upgrade vim git tmux screen mc htop curl wget ca-certificates sysstat nfs-kernel-server samba-common samba gnupg2 apt-transport-https
```

### "root" Benutzer aktivieren

Standardmäßig ist der `root`Benutzer unter Ubuntu deaktiviert

Nutzen Sie *sudo* um zum root Benutzer zu wechseln.
```bash
sudo su
```

Setzen Sie ein neues Passwort für den root Benutzer mit dem Kommando *passwd*
```bash
passwd
```

### Aktivieren des root Benutzers zum Einloggen über SSH (optional)

Öffnen Sie die Datei `/etc/ssh/sshd_config` und ändern Sie die folgende Zeile
```
PermitRootLogin yes
```

Aktivieren Sie die Änderung:
```bash
systemctl restart sshd
```

Nun können Sie sich als `root` Benutzer auf dem System über SSH anmelden.

## openITCOCKPIT installieren

Da sie eine Entwicklungsumgebung von openITCOCKPIT installieren möchten, gehen wir davon aus, dass Sie mit dem 
openITCOCKPIT Setup Prozess vertraut sind. Für weitere Informationen zum Setup Prozess klicken Sie bitte auf folgenden
Link: <https://openitcockpit.io/download_server/>

```bash
curl https://packages5.openitcockpit.io/repokey.txt | sudo apt-key add -
 
echo "deb https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/stable $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/openitcockpit.list
sudo apt-get update
 
sudo apt-get install openitcockpit
```

### Setup openITCOCKPIT
Führen Sie den Setup Wizard von openITCOCKPIT aus um einen Benutzer für die Weboberfläche zu erstellen. Eine real 
existierende E-Mail-Adresse wird **nicht** vorausgesetzt.

```bash
sudo /opt/openitc/frontend/SETUP.sh
```

![setup.sh example](/images/SETUPsh-example.png)

### Setup phpMyAdmin (optional)
phpMyAdmin ist ein Webbasiertes MySQL Datenbank Management Tool. Nach der Installation ist es unter 
`https://xxx.xxx.xxx.xxx/phpmyadmin` erreichbar. Die MySQL Zugangsdaten finden Sie in der Datei 
`/opt/openitc/etc/mysql/mysql.cnf`.

```bash
sudo apt-get install phpmyadmin
```

mysql.cnf Beispiel:
```bash
dziegler@oitc-dev:~$ sudo cat /opt/openitc/etc/mysql/mysql.cnf
; Automatically generated for openITCOCKPIT scripts. DO NOT TOUCH!
[client]
database = openitcockpit
host = localhost
user = openitcockpit
password = zw8upknsKte2pGvn
port = 3306
dziegler@oitc-dev:~$
```

### Installation von PHP-Composer

Composer ist eine Paketverwaltung für PHP Bibliotheken und voraussetzung für eine openITCOCKPIT Entwicklungsumgebung.
```bash
curl -o composer-setup.php https://getcomposer.org/installer
php composer-setup.php
sudo cp composer.phar /usr/local/bin/composer
```

## Klonen des Quellcodes von GitHub
openITCOCKPIT nutzt git als Versionskontrollsystem. Das Repository ist öffentlich auf GitHub gehostet. 

### Forken des openITCOCKPIT Repositories
Obwohl dies nicht unbedingt vonnöten ist, wird dringend empfohlen, einen Persönlichen Fork des Offiziellen openITCOCKPIT
Repositories zu erstellen.

Wenn Sie dem openITCOCKPIT Projekt einen Beitrag leisten möchten, wird dies **vorausgesetzt**. Sollten Sie nur die
absicht haben, sich im Quellcode umzuschauen oder haben Sie keinen GitHub Account, so können Sie das Offizielle 
openITCOCKPIT Repository auch einfach klonen.

![fork repo](/images/forking.png)

### Klonen Sie ihr Persönliches Repository (empfohlen)

Löschen Sie die Dateien, welche durch apt installiert wurden
```bash
sudo su
rm -rf /opt/openitc/frontend
```

Klonen Sie das Repository (Ersetzen Sie `YOUR_ACCOUNT_NAME` mit Ihrem GitHub Benutzernamen)
```bash 
cd /opt/openitc/
git clone -b development https://github.com/YOUR_ACCOUNT_NAME/openITCOCKPIT frontend
```

### Klonen des Offiziellen openITCOCKPIT Repository (nur empfohlen, wenn sie KEINEN GitHub Account haben)

Löschen Sie die Dateien, welche durch apt installiert wurden
```bash
sudo su
rm -rf /opt/openitc/frontend
```

```bash
cd /opt/openitc/
git clone -b development https://github.com/openITCOCKPIT/openITCOCKPIT frontend
```


### Abhängigkeiten Installieren

Stellen Sie sicher, dass Sie alle Kommandos als `root` Benutzer ausführen (`sudo su`).

#### Installation der PHP Abhängigkeiten
```bash
cd /opt/openitc/frontend
 
composer install
 
rm -f /opt/openitc/frontend/config/app_local.php
```

#### Installation der JavaScript Abhängigkeiten
```bash
cd /opt/openitc/frontend
 
npm install
```

#### Aktualisierung der Datenbank und Reparieren der Dateiberechtigungen
```bash
openitcockpit-update --cc --rights
```

## Aktivierung des openITCOCKPIT Entwicklungsmodus (permanent)
Als Entwickler möchten Sie die Entwicklungsfeatures von openITCOCKPIT aktivieren. Dies ermöglicht beispielsweise ausgabe
der Fehlermeldungen im Browser, aktivierung globaler PHP Methoden wie `dd($var)` und `debug($var)` sowie das Laden von
unkomprimiertem CSS und JavaScript

Stellen Sie sicher, dass Sie alle Kommandos als `root` Benutzer ausführen (`sudo su`).

!!! danger
    Seien Sie sich im Klaren darüber, dass das Aktivieren des debug Modus zu Datenlecks und dem verlust von sensitiven 
    Informationen führen kann.

```bash
echo "OITC_DEBUG=1" >> /etc/environment
export OITC_DEBUG=1
 
sed -i 's/OITC_DEBUG 0/OITC_DEBUG 1/g' /etc/nginx/openitc/master.conf
systemctl restart nginx
```

## Start Hacking
### Dateizugriff über ein Remote System (IDE) (optional)
Ihre Entwicklungsumgebung (bspw. PHPStorm, Visual Studio Code etc.) wird in der Regel nicht auf demselben System laufen, 
auf dem auch openITCOCKPIT läuft. 

Es gibt drei gängige wege, um Zugriff auf den Quellcode über ihre IDE zu erlangen: NFS, SMB und SSH

#### NFS (Linux und macOS clients)
Öffnen Sie die Datei `/etc/exports` auf ihrem openITCOCKPIT Server und erstellen Sie einen neuen Eintrag wie folgt: (Sie
können den Zugriff für eine einzelne IP-Adresse oder aber ein ganzes Subnetz freigeben. Stellen Sie sicher, die richtige
IP-Adresse für ihr Netzwerk einzustellen)

```
/opt/openitc/frontend/ 192.168.56.0/24(rw,no_subtree_check,no_root_squash,all_squash,anonuid=33,anongid=33)
```

```bash
sudo exportfs -a
```
##### NFS Freigabe auf einem Linux client mounten
```bash
sudo apt-get install nfs-common
 
mkdir ~/openitcockpit-frontend
mount xxx.xxx.xxx.xxx:/opt/openitc/frontend ~/openitcockpit-frontend
```

Stellen Sie sicher, dass Sie `xxx.xxx.xxx.xxx` mit der IP-Adresse ihres openITCOCKPIT Servers ersetzen.

Sie können nun den Ordner `~/openitcockpit-frontend` mit ihrer IDE öffnen.

###### Unmount NFS Freigabe (Linux client)
Sollten Sie die Freigabe nicht mehr auf Ihrem System benötigen, können Sie sie mit folgendem Befehl entfernen:
```bash
umount ~/openitcockpit-frontend
```

##### NFS Freigabe auf einem macOS client mounten

```bash
mkdir ~/openitcockpit-frontend
sudo mount_nfs -o resvport xxx.xxx.xxx.xxx:/opt/openitc/frontend ~/openitcockpit-frontend
```
Stellen Sie sicher, dass Sie `xxx.xxx.xxx.xxx` mit der IP-Adresse ihres openITCOCKPIT Servers ersetzen

Sie können nun den Ordner `~/openitcockpit-frontend` mit ihrer IDE öffnen.

###### Unmount NFS Freigabe (macOS client)
Sollten Sie die Freigabe nicht mehr auf Ihrem System benötigen, können Sie sie mit folgendem Befehl entfernen:
```bash
sudo umount ~/openitcockpit-frontend
```

#### SMB (Windows, Linux und macOS clients)

Als Erstes müssen Sie den SMB daemon auf ihrem openITCOCKPIT Server einrichten.
```bash
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.backup
```

Ersetzen Sie Ihre aktuelle smb Konfiguration, welche unter `/etc/samba/smb.conf` zu finden ist mit der Folgenden:
```
[global]
    workgroup = WORKGROUP
    server string = %h server (Samba, Ubuntu)
 
#### Debugging/Accounting ####
    log file = /var/log/samba/log.%m
    max log size = 1000
    logging = file
    panic action = /usr/share/samba/panic-action %d
 
 
####### Authentication #######
    server role = standalone server
    obey pam restrictions = yes
    unix password sync = yes
    passwd program = /usr/bin/passwd %u
    passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
    pam password change = yes
 
    security = user
    guest only = yes
    map to guest = bad user
    guest account = nobody
 
############ Misc ############
    usershare allow guests = yes
 
#======================= Share Definitions =======================
[frontend]
    path = /opt/openitc/frontend
    available = yes
    browseable = yes
    guest ok = no
    writeable = yes
    create mask = 0644
    directory mask = 0755
    force user = www-data
    valid users = www-data
```

Setzen Sie ein Passwort für den Benutzer `www-data` um Zugriff auf die Dateien via samba zu erhalten.
```bash
smbpasswd -a www-data
```

Aktivieren Sie die Änderungen:
```bash
sudo systemctl restart smbd
```

##### SMB Freigabe auf einem Windows client mounten

1. Öffnen Sie den Windows Explorer und klicken Sie auf "Netzlaufwerk Verbinden".

![map network drive](/images/map-network-drive.png)

2. Fügen Sie ihre SMB Freigabe als Netzlaufwerk hinzu.

Stellen Sie sicher, dass Sie die Option "Anmelden mit anderen Anmeldeinformationen herstellen" ausgewählt haben.

![map network drive path](/images/map-network-drive-path.png)

3. Nutzen Sie den `www-data` Benutzer und das Passwort, welches Sie eben gesetzt hatten.

![smb credentials](/images/windows-smb-credentials.png)

4. Nun können Sie die Dateien durchsuchen.

![browse through files](/images/windows-browse-smb-share.png)


Öffnen Sie `Z:\` mit ihrer IDE.

Hilfe: <https://support.microsoft.com/en-us/help/4026635/windows-10-map-a-network-drive>

##### SMB Freigabe auf einem macOS client mounten

1. Öffnen Sie den "Finder" und drücken Sie `CMD+k`.

![connect to smb](/images/connect-to-smb.png)


2. Nutzen Sie den `www-data` Benutzer und das Passwort, welches Sie eben gesetzt hatten.

![set username and password](/images/username-and-password.png)

3. Nun können Sie die Dateien durchsuchen.

![browse smb](/images/browse-smb.png)

Öffnen Sie `/Volumes/frontend` mit ihrer IDE.

#### SSH (Plattformunabhängig - abhängig von der IDE)

Viele IDEs unterstützen den Zugriff auf entfernte Dateien via FTP, SFTP oder SSH. Der Setup Prozess ist abhängig von
ihrer IDE. Bitte suchen Sie im Web nach der Einrichtung via SSH für ihre IDE.

Einrichtung für PHPStorm: <https://www.jetbrains.com/help/phpstorm/create-new-project-add-remote-server.html>

Einrichtung für Visual Studio Code: <https://code.visualstudio.com/docs/remote/ssh>