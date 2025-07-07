# Join Development

Do you want to modify the source code of the openITCOCKPIT Monitoring Agent? If yes follow this guide to getting started. 

Please make sure you have [Golang](https://golang.org/) >= 1.15.6 and [Visual Studio Code](https://code.visualstudio.com/) installed.

1. Clone the repository
```
git clone https://github.com/openITCOCKPIT/openitcockpit-agent-go.git
```

2. Run Visual Studio Code and make sure that you have installed the [Go extension](https://marketplace.visualstudio.com/items?itemName=golang.Go)
![Install Go extension for VS Code](/images/agent/vscode_golang_ext.jpg)

3. Install Go tools
Press `ctrl` + `shift` + `P` (Windows and Linux) or `cmd` + `shift` + `P` on macOS and select `Go: Install/Update Tools`
![Install Go tools](images/agent/vscode_install_go_tools.png)

Select all tools and confirm with `Ok`
![Select and install Go tools](/images/agent/vscode_install_all_go_tools.png)

The installation is completed, as soon as you see `All tools successfully installed. You are ready to Go :).` in the VS Code terminal.

4. Debug Launch Configuration

In the VS Code main menu click on `Run` -> `Open Configurations`
```JS
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
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

Create a new file in workspace folder -> `config.ini`
```ini
[default]
customchecks = ./customchecks.ini
```

Create a new file in workspace folder -> `customchecks.ini` (Windows)

```ini
[check_Windows_Services_Status_OSS]
command = echo 'hello world'
interval = 15
timeout = 10
enabled = false
```

Create a new file in workspace folder -> `customchecks.ini` (Linux/macOS)

```ini
[check_echo]
command = echo 'hello world'
interval = 15
timeout = 10
enabled = false
```

## Windows development notes

By default the agent will assume to be run as Windows Service. If you set `OITC_AGENT_DEBUG` it will run the default cmd like on linux.

```powershell
$env:OITC_AGENT_DEBUG="1"
.\agent.exe -c C:\git\openitcockpit-agent-go\config.ini -l "$env:TEMP\agent.log"
```