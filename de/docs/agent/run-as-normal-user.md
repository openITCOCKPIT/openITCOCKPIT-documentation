
# Agenten-Dienst als normaler Benutzer ausführen

Dieses Dokument beschreibt, wie das Benutzerkonto des openITCOCKPIT Monitoring Agenten geändert wird.

## Linux

Zuerst müssen Sie den openITCOCKPIT Monitoring Agent stoppen.
```bash
systemctl stop openitcockpit-agent.service
```

Nun bearbeiten Sie die Systemd-Dienstdefinition
```bash
systemctl edit --full openitcockpit-agent.service
```

Ersetzen Sie den `root`-Benutzer durch einen nicht privilegierten Benutzer Ihrer Wahl, wie zum Beispiel `monitoring`.

Passen Sie anschließend die Berechtigungen für die Agenten-Ordner an und starten Sie den Agenten neu:

```bash
chown -R monitoring: /etc/openitcockpit-agent/
chown -R monitoring: /var/log/openitcockpit-agent/

systemctl start openitcockpit-agent.service
```

## Windows

### Ordnersberechtigungen

1. Öffnen Sie den Datei-Explorer
2. Wechseln Sie zu `C:\Program Files\`
3. Klicken Sie mit der rechten Maustaste auf den Ordner `openitcockpit` (oder `it-novum` falls die Agent-Version vor 3.6.0 installiert wurde)
4. Gehen Sie zu Eigenschaften -> Sicherheit -> Erweitert
5. Ändern Sie den Besitzer auf den Benutzer, der den Agenten-Dienst ausführen soll

### Perflib-Berechtigungen

Um auf Leistungswerte zugreifen zu können, müssen Sie den Benutzer, der den Agenten-Dienst ausführen soll, zur Gruppe "Performance Monitor Users" hinzufügen.

### Konfiguration des Windows-Dienstes

1. Öffnen Sie die Windows-Dienste
2. Klicken Sie mit der rechten Maustaste auf den `openITCOCKPIT Agent`-Dienst
3. Gehen Sie zu Eigenschaften -> Anmelden
4. Ändern Sie den Benutzer auf den Benutzer, der den Agenten-Dienst ausführen soll

Starten Sie schließlich den Agenten-Dienst neu.
