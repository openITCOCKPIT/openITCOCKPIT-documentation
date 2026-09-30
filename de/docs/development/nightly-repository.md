# Nightly Repository

!!! warning
    Das Nightly Repository enthält **automatisch** erstellte und **ungetestete** Builds von openITCOCKPIT.
    Es wird dringend empfohlen, dass Nightly Repository nur für Test und Entwicklungssysteme zu nutzen.


openITCOCKPIT bietet zwei Update-Kanäle, **stable** und **nightly**. Im Standard wird immer der stabile  Kanal genutzt.

Um neue Funktionen schon vor der Veröffentlichung einer stabilen Version zu testen, können erfahrene Benutzer das openITCOCKPIT Nightly Repository einbinden. Dieses wird in unregelmäßigen Abständen aktualisiert und enthält immer die aktuelle Version von openITCOCKPIT. Die Nightly Versionen werden automatisiert aus dem Quelltext von openITCOCKPIT gebaut **und ohne vorherige Tests** veröffentlicht.


## Wechsel auf das Nightly Repository

Eventuell muss nach dem Wechsel, der Community oder Enterprise Lizenzschlüssel erneut aktiviert werden.

### Debian
```
tee /etc/apt/sources.list.d/openitcockpit.sources <<EOF
Types: deb
URIs: https://packages5.openitcockpit.io/openitcockpit/$(. /etc/os-release && echo "$VERSION_CODENAME")/nightly
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: main
Signed-By: /etc/apt/keyrings/openitcockpit-keyring.asc
Enabled: yes
EOF

apt-get update
```

### Ubuntu
```
tee /etc/apt/sources.list.d/openitcockpit.sources <<EOF
Types: deb
URIs: https://packages5.openitcockpit.io/openitcockpit/$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")/nightly
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: main
Signed-By: /etc/apt/keyrings/openitcockpit-keyring.asc
Enabled: yes
EOF

apt-get update
```

#### Ubuntu / Debian (Legacy)

Verwenden Sie dies nur, wenn der Schlüssel des openITCOCKPIT-Repositorys im alten Schlüsselbund `trusted.gpg` gespeichert ist.

```
echo "deb https://packages5.openitcockpit.io/openitcockpit/$(lsb_release -sc)/nightly $(lsb_release -sc) main" > /etc/apt/sources.list.d/openitcockpit.list
apt-get update
```

#### Update von openITCOCKPIT
Das Update auf eine Nightly Version erfolgt wie gewohnt über den Paketmanager.
```
apt-get dist-upgrade
```

## Wechsel auf das Stable Repository


### Debian
```
tee /etc/apt/sources.list.d/openitcockpit.sources <<EOF
Types: deb
URIs: https://packages5.openitcockpit.io/openitcockpit/$(. /etc/os-release && echo "$VERSION_CODENAME")/stable
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: main
Signed-By: /etc/apt/keyrings/openitcockpit-keyring.asc
Enabled: yes
EOF

apt-get update
```

### Ubuntu
```
tee /etc/apt/sources.list.d/openitcockpit.sources <<EOF
Types: deb
URIs: https://packages5.openitcockpit.io/openitcockpit/$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")/stable
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: main
Signed-By: /etc/apt/keyrings/openitcockpit-keyring.asc
Enabled: yes
EOF

apt-get update
```
