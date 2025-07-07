# Entwicklung beitreten

Möchten Sie den Quellcode des openITCOCKPIT Monitoring Agent ändern? Wenn ja, folgen Sie dieser Anleitung, um loszulegen.

Bitte stellen Sie sicher, dass Sie [Golang](https://golang.org/) >= 1.15.6 und [Visual Studio Code](https://code.visualstudio.com/) installiert haben.

1. Klonen Sie das Repository
```
git clone https://github.com/openITCOCKPIT/openitcockpit-agent-go.git
```

2. Starten Sie Visual Studio Code und stellen Sie sicher, dass Sie die [Go-Erweiterung](https://marketplace.visualstudio.com/items?itemName=golang.Go) installiert haben.
![Go-Erweiterung für VS Code installieren](/images/agent/vscode_golang_ext.jpg)

3. Go-Tools installieren
Drücken Sie `ctrl` + `shift` + `P` (Windows und Linux) oder `cmd` + `shift` + `P` auf macOS und wählen Sie `Go: Install/Update Tools`.
![Go-Tools installieren](images/agent/vscode_install_go_tools.png)

Wählen Sie alle Tools aus und bestätigen Sie mit `Ok`.
![Go-Tools auswählen und installieren](/images/agent/vscode_install_all_go_tools.png)

Die Installation ist abgeschlossen, sobald Sie `All tools successfully installed. You are ready to Go :).` im VS Code Terminal sehen.

4. Debug-Startkonfiguration

Klicken Sie im Hauptmenü von VS Code auf `Run` -> `Open Configurations`.
```JS
{
    // Verwenden Sie IntelliSense, um mehr über mögliche Attribute zu erfahren.
    // Fahren Sie mit der Maus über die Beschreibungen der vorhandenen Attribute.
    // Weitere Informationen finden Sie unter: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch",
            "type": "go",
            "request": "launch",
            "mode": "auto",
            "program": "${workspaceFolder}",
            "env": {
                "OITC_AGENT_DEBUG": "1",
            },
            "args": ["-c", ".\\config.cnf", "--disable-logfile", "--debug"]
        }
    ]
}
```

Erstellen Sie eine neue Datei im Arbeitsbereichsordner -> `config.ini`

```ini
[default]
customchecks = ./customchecks.ini
```

Erstellen Sie eine neue Datei im Arbeitsbereichsordner -> `customchecks.ini` (Windows)

```ini
[check_Windows_Services_Status_OSS]
command = echo 'hello world'
interval = 15
timeout = 10
enabled = false
```

Erstellen Sie eine neue Datei im Arbeitsbereichsordner -> `customchecks.ini` (Linux/macOS)

```ini
[check_echo]
command = echo 'hello world'
interval = 15
timeout = 10
enabled = false
```

## Hinweise zur Entwicklung unter Windows

Standardmäßig geht der Agent davon aus, dass er als Windows-Dienst ausgeführt wird. Wenn Sie `OITC_AGENT_DEBUG` setzen, wird er den Standardbefehl wie unter Linux ausführen.


```powershell
$env:OITC_AGENT_DEBUG="1"
.\agent.exe -c C:\git\openitcockpit-agent-go\config.ini -l "$env:TEMP\agent.log"
```
