# Build binary

By default the openITCOCKPIT Monitoring Agent will be compiled into a static linked, zero dependencies single executable binary. It is **not** required to have Go (or any other libraries) installed on the target device.

### Static linked (recommended, zero dependencies)
```
CGO_ENABLED=0 go build -o agent main.go
``` 

The binary can only be execute on the same platform, as it was compiled on. If you want to build the binary for a different operating system or cpu architecture please read the [Cross compile](#cross-compile) section.

### Enable libvirt support (Linux only)
To Enable libvirt monitoring the _libvirt_ library is required to be present on the target device. By default libvirt support is disabled, otherwise the Agent would not be free of dependencies. If you want to enable support for libvirt monitoring, you have to compile the agent by your self.

It is recommended to build the binary on the same platform, as you want to use later. For example, if you want to monitor libvirt running on a CentOS 7.9 you should build the binary also on an CentOS 7.9

#### CentOS / Red Hat
````
yum install gcc libvirt-devel
````

#### Debian / Ubuntu
````
apt-get install gcc libvirt-dev
````


#### Build the Binary
```
go build -o agent -tags libvirt main.go
```

You can use the command `ldd agent` to get a list of all dynamic linked libraries


### Enable diskio support on macOS (enabled by default)
On macOS the agent is not free of dependencies. For collecting statistics about Disk IO some system libraries are required. 

These libraries are available on macOS by default so we decided to enable Disk IO monitoring by default.
```
go build -o agent main.go
```

You can use the command `otool -L agent` to get a list of all dynamic linked libraries

---

### Cross compile
With cross compile you can build the binary for a different operating system or even cpu architecture.

#### 32 Bit (i386)
```
CGO_ENABLED=0 GOARCH=386 go build -o agent main.go
```

#### ARM64 (Linux)
```
CGO_ENABLED=0 GOARCH=arm64 go build -o agent main.go
```

#### Windows ARM Support

```
CGO_ENABLED=0 GOARCH=arm64 GOOS=windows go build -o agent main.go
```

#### Build Darwin (macOS) binary on Linux
```
CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o agent main.go
```

See the [full list of supported operating systems and cpu architectures](https://github.com/golang/go/blob/e79b2e1e3acbce03b04f4ae95a8884183006bd1e/src/internal/syslist/syslist.go#L58-L82) of the Go programming language.

Please notice: The openITCOCKPIT Monitoring Agent was built to run on Linux, Windows and macOS with the main focus to be compatible with amd64 and arm64 processors. If you try to build the code for any other architecture or OS, please keep in mind that maybe the underlying libraries needs to be patched as well.

---

### Native on different hardware
This section contain real world examples of how to compile the openITCOCKPIT Monitoring Agent on different hardware platforms.

#### ARMv6 Support (Raspberry Pi 1)

Installing go
```
wget https://golang.org/dl/go1.16.3.linux-armv6l.tar.gz
tar -C /usr/local -xzf go1.16.3.linux-armv6l.tar.gz
export PATH=$PATH:/usr/local/go/bin
```


Build openITCOCKPIT Monitoring Agent for ARMv6
```
CGO_ENABLED=0 GOARCH=arm GOARM=6 go build -o openitcockpit-agent main.go
```

More information about go on ARM can be found here: [https://go.dev/wiki/GoArm](https://go.dev/wiki/GoArm)

![Raspberry Pi 1 running the openITCOCKPIT Monitoring Agent](/images/agent/Raspberry_Pi_1.jpg){ align=center }

*Image: Raspberry Pi 1 (2012) running the openITCOCKPIT Monitoring Agent*