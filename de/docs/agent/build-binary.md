# Binary erstellen

Standardmäßig wird der openITCOCKPIT Monitoring Agent in eine statisch gelinkte, abhängige freie, einzelne ausführbare Binärdatei kompiliert. Es ist **nicht** erforderlich, Go (oder andere Bibliotheken) auf dem Zielgerät zu installieren.

### Statisch gelinkt (empfohlen, keine Abhängigkeiten)
```
CGO_ENABLED=0 go build -o agent main.go
```

Die Binärdatei kann nur auf derselben Plattform ausgeführt werden, auf der sie kompiliert wurde. Wenn Sie die Binärdatei für ein anderes Betriebssystem oder eine andere CPU-Architektur erstellen möchten, lesen Sie bitte den Abschnitt [Cross-Compile](#cross-compile).

### Libvirt-Unterstützung aktivieren (nur Linux)
Um die Libvirt-Überwachung zu aktivieren, muss die _libvirt_-Bibliothek auf dem Zielgerät vorhanden sein. Standardmäßig ist die Libvirt-Unterstützung deaktiviert, da der Agent ansonsten nicht abhängigkeitfrei wäre. Wenn Sie die Unterstützung für die Libvirt-Überwachung aktivieren möchten, müssen Sie den Agenten selbst kompilieren.

Es wird empfohlen, die Binärdatei auf derselben Plattform zu erstellen, auf der sie später verwendet werden soll. Zum Beispiel sollten Sie, wenn Sie Libvirt auf einem CentOS 7.9 überwachen möchten, die Binärdatei ebenfalls auf einem CentOS 7.9 erstellen.

#### CentOS / Red Hat
````
yum install gcc libvirt-devel
````

#### Debian / Ubuntu
````
apt-get install gcc libvirt-dev
````

#### Binärdatei erstellen
```
go build -o agent -tags libvirt main.go
```

Sie können den Befehl `ldd agent` verwenden, um eine Liste aller dynamisch gelinkten Bibliotheken zu erhalten.

### Disk-IO-Unterstützung auf macOS aktivieren (standardmäßig aktiviert)
Auf macOS ist der Agent nicht frei von Abhängigkeiten. Um Statistiken über Disk-IO zu sammeln, sind einige Systembibliotheken erforderlich.

Diese Bibliotheken sind auf macOS standardmäßig verfügbar, daher haben wir uns entschieden, die Disk-IO-Überwachung standardmäßig zu aktivieren.
```
go build -o agent main.go
```

Sie können den Befehl `otool -L agent` verwenden, um eine Liste aller dynamisch gelinkten Bibliotheken zu erhalten.

---

### Cross-Compile
Mit Cross-Compile können Sie die Binärdatei für ein anderes Betriebssystem oder sogar eine andere CPU-Architektur erstellen.

#### 32 Bit (i386)
```
CGO_ENABLED=0 GOARCH=386 go build -o agent main.go
```

#### ARM64 (Linux)
```
CGO_ENABLED=0 GOARCH=arm64 go build -o agent main.go
```

#### Windows-ARM-Unterstützung

```
CGO_ENABLED=0 GOARCH=arm64 GOOS=windows go build -o agent main.go
```

#### Darwin (macOS)-Binärdatei auf Linux erstellen
```
CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o agent main.go
```

Sehen Sie sich die [vollständige Liste der unterstützten Betriebssysteme und CPU-Architekturen](https://github.com/golang/go/blob/e79b2e1e3acbce03b04f4ae95a8884183006bd1e/src/internal/syslist/syslist.go#L58-L82) der Go-Programmiersprache an.

Bitte beachten: Der openITCOCKPIT Monitoring Agent wurde entwickelt, um unter Linux, Windows und macOS zu laufen, wobei der Hauptfokus auf der Kompatibilität mit amd64- und arm64-Prozessoren liegt. Wenn Sie versuchen, den Code für eine andere Architektur oder ein anderes Betriebssystem zu erstellen, beachten Sie bitte, dass möglicherweise die zugrunde liegenden Bibliotheken ebenfalls angepasst werden müssen.

---

### Native auf unterschiedlicher Hardware
Dieser Abschnitt enthält Beispiele aus der Praxis, wie der openITCOCKPIT Monitoring Agent auf verschiedenen Hardwareplattformen kompiliert werden kann.

#### ARMv6-Unterstützung (Raspberry Pi 1)

Go installieren
```
wget https://golang.org/dl/go1.16.3.linux-armv6l.tar.gz
tar -C /usr/local -xzf go1.16.3.linux-armv6l.tar.gz
export PATH=$PATH:/usr/local/go/bin
```

Binärdatei für ARMv6 erstellen
```
CGO_ENABLED=0 GOARCH=arm GOARM=6 go build -o openitcockpit-agent main.go
```

Weitere Informationen zu Go auf ARM finden Sie hier: [https://go.dev/wiki/GoArm](https://go.dev/wiki/GoArm)

![Raspberry Pi 1 running the openITCOCKPIT Monitoring Agent](/images/agent/Raspberry_Pi_1.jpg){ align=center }

*Bild: Raspberry Pi 1 (2012) mit dem openITCOCKPIT Monitoring Agent*
