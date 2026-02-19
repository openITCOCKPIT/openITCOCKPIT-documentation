# SSL Certificate authentication
Optionally, you can provide SSL Certificates to the clients, which they use for authentitacion in openITCOCKPIT.
This is a very secure way to authenticate users, but it is also more complex to set up and maintain.
#

## Install prerequisites
```bash
apt-get install gnutls-bin
```

## Create a CA
```bash
certtool --generate-privkey --bits 2048 --outfile ca.key
certtool --generate-self-signed  --load-privkey ca.key --outfile ca.crt
```

The following questions must be answered and cannot be left blank.
```text
certtool --generate-self-signed  --load-privkey ca.key --outfile ca.crt
Common name: Test CA

The certificate will expire in (days): 365

Does the certificate belong to an authority? (y/N): y

Is the above information ok? (y/N): y
```

Full output
```text
certtool --generate-self-signed  --load-privkey ca.key --outfile ca.crt
Generating a self signed certificate...
Please enter the details of the certificate's distinguished name. Just press enter to ignore a field.
Country name (2 chars): DE
State or province name: Hessen
Locality name: Fulda
Organization name: openITCOCKPIT
Organizational unit name: Software
Common name: Test CA
UID:
Enter an additional domain component (DC):
This field should not be used in new certificates.
E-mail:
Enter the certificate's serial number in decimal (123) or hex (0xabcd)
(default is 0x1a881d43e75c5c1b008f733238c1c7282405462a)
value:


Activation/Expiration time.
The certificate will expire in (days): 365


Extensions.
Does the certificate belong to an authority? (y/N): y
Path length constraint (decimal, -1 for no constraint): y
Trailing garbage ignored: `y
'
Is this a TLS web client certificate? (y/N):
Will the certificate be used for IPsec IKE operations? (y/N): n
Is this a TLS web server certificate? (y/N): n
Enter a dnsName of the subject of the certificate: n
Enter an additional dnsName of the subject of the certificate: n
Enter an additional dnsName of the subject of the certificate:
Enter a URI of the subject of the certificate:
Enter the IP address of the subject of the certificate:
Enter the e-mail of the subject of the certificate:
Will the certificate be used for signing (required for TLS)? (Y/n): n
Will the certificate be used for data encryption? (y/N): n
Will the certificate be used to sign OCSP requests? (y/N): n
Will the certificate be used to sign code? (y/N): n
Will the certificate be used for time stamping? (y/N): n
Will the certificate be used for email protection? (y/N): n
Will the certificate be used to sign other certificates? (Y/n): n
Will the certificate be used to sign CRLs? (y/N): n
Enter the URI of the CRL distribution point: n
Enter an additional URI of the CRL distribution point:
X.509 Certificate Information:
        Version: 3
        Serial Number (hex): 1a881d43e75c5c1b008f733238c1c7282405462a
        Validity:
                Not Before: Thu Feb 19 12:18:30 UTC 2026
                Not After: Fri Feb 19 12:18:34 UTC 2027
        Subject: DC=DC,DC=DC,DC=DC,CN=Test CA,OU=Software,O=openITCOCKPIT,L=Fulda,ST=Hessen,C=DE
        Subject Public Key Algorithm: RSA
        Algorithm Security Level: Medium (2048 bits)
                Modulus (bits 2048):
                        00:c3:53:b7:23:ce:7e:93:ea:24:4c:63:34:71:46:e2
                        e4:e1:52:7b:a6:5d:1a:4e:f3:9f:e5:f1:a1:f3:02:df
                        72:e4:7e:f2:8d:52:99:e8:08:e7:09:2b:ff:4a:06:ac
                        44:fd:8c:2a:a4:bf:73:b9:7d:83:d6:65:22:c1:7f:e3
                        c8:69:4b:6e:e5:e5:15:04:b1:83:2d:52:7f:ae:9a:6e
                        fc:1e:9c:a6:8f:36:93:06:d5:bc:19:b3:c2:f8:82:5f
                        b5:23:4e:d0:fb:b5:69:0e:50:e2:ee:ad:b3:31:96:b2
                        c7:fd:27:4c:59:1d:11:69:5f:40:e8:82:f2:22:7c:5f
                        20:9a:0f:1d:40:22:65:9f:52:87:83:78:0e:dc:93:b4
                        ac:1b:ad:aa:6e:92:74:3d:69:a1:74:f6:8b:fd:ff:99
                        cd:cb:13:a3:f9:08:25:01:88:4c:43:40:3b:79:68:86
                        29:30:ed:47:7c:82:52:a8:d6:8a:93:33:e3:33:5f:e1
                        49:b9:24:7b:c0:5a:8a:30:3e:52:25:1e:63:10:ab:83
                        4b:fc:0b:b0:1c:37:6c:08:2c:6d:d6:c9:f0:cc:06:4f
                        fe:2d:16:c9:f5:1f:3d:25:95:ca:19:4f:4e:12:13:4c
                        6e:26:3b:1c:7a:da:e3:07:d1:38:6e:fb:42:60:b8:ba
                        9f
                Exponent (bits 24):
                        01:00:01
        Extensions:
                Basic Constraints (critical):
                        Certificate Authority (CA): TRUE
                        Path Length Constraint: 0
                Subject Alternative Name (not critical):
                        DNSname: n
                        DNSname: n
                Subject Key Identifier (not critical):
                        9befe62f2d2ff437e5e238e1faf1106f06f66a1f
                CRL Distribution points (not critical):
                        URI: n
Other Information:
        Public Key ID:
                sha1:9befe62f2d2ff437e5e238e1faf1106f06f66a1f
                sha256:444f8ba883caaa7feacf4fe5be1dd78c9c7d75c7bda8ba9db1876faf239417be
        Public Key PIN:
                pin-sha256:RE+LqIPKqn/qz0/lvh3XjJx9dce9qLqdsYdvryOUF74=

Is the above information ok? (y/N): y


Signing certificate...
```

## Server Certificate
```bash
Common name: 192.168.56.103 (Sollte der FQDN oder die IP sein)

The certificate will expire in (days): 300

Is the above information ok? (y/N): y
```

```text
 certtool --generate-certificate --load-privkey server.key --load-ca-privkey ca.key --load-ca-certificate ca.crt --outfile server.crt
Generating a signed certificate...
Please enter the details of the certificate's distinguished name. Just press enter to ignore a field.
Country name (2 chars):
State or province name:
Locality name:
Organization name:
Organizational unit name:
Common name: 127.0.0.1
UID:
Enter the subject's domain component (DC):
This field should not be used in new certificates.
E-mail:
Enter the certificate's serial number in decimal (123) or hex (0xabcd)
(default is 0x2f7ada72babc17c9f33f016da0d9dd3fb203c12e)
value:


Activation/Expiration time.
The certificate will expire in (days): 365

Expiration time: Fri Feb 19 13:21:51 2027
CA expiration time: Fri Feb 19 13:18:34 2027
Warning: The time set exceeds the CA's expiration time
Is it ok to proceed? (y/N): y


Extensions.
Does the certificate belong to an authority? (y/N):
Is this a TLS web client certificate? (y/N):
Will the certificate be used for IPsec IKE operations? (y/N):
Is this a TLS web server certificate? (y/N):
Enter a dnsName of the subject of the certificate:
Enter a URI of the subject of the certificate:
Enter the IP address of the subject of the certificate:
Enter the e-mail of the subject of the certificate:
Will the certificate be used for signing (required for TLS)? (Y/n):
Will the certificate be used for encryption (not required for TLS)? (Y/n):
Will the certificate be used for data encryption? (y/N):
Will the certificate be used to sign OCSP requests? (y/N):
Will the certificate be used to sign code? (y/N):
Will the certificate be used for time stamping? (y/N):
Will the certificate be used for email protection? (y/N):
Enter the URI of the CRL distribution point:
X.509 Certificate Information:
        Version: 3
        Serial Number (hex): 2f7ada72babc17c9f33f016da0d9dd3fb203c12e
        Validity:
                Not Before: Thu Feb 19 12:21:47 UTC 2026
                Not After: Fri Feb 19 12:21:51 UTC 2027
        Subject: CN=127.0.0.1
        Subject Public Key Algorithm: RSA
        Algorithm Security Level: Medium (2048 bits)
                Modulus (bits 2048):
                        00:c5:30:06:4a:a0:27:c5:6a:c5:cf:e3:36:9b:24:91
                        82:0f:e0:75:67:c9:21:83:21:d1:d5:bd:58:cd:2e:0d
                        57:88:47:dc:6b:3c:5c:d5:91:9c:e7:79:0f:26:d9:8c
                        11:5d:45:c2:88:62:64:95:79:c3:c0:14:76:08:ff:84
                        8f:5b:0b:2d:5f:57:93:89:36:19:39:bd:29:6c:d0:29
                        bc:ff:06:4b:7f:85:a4:de:69:1b:fe:fa:bf:8c:bf:cf
                        8f:e1:27:0a:c3:2a:87:ec:ce:56:f5:62:0e:a3:7e:0b
                        3c:cb:d9:91:9d:36:96:67:87:9a:39:e7:cc:c9:e9:81
                        4f:81:4c:96:bb:26:b3:ec:32:f5:78:78:7b:81:bd:68
                        e0:07:66:ec:2c:dd:cb:0d:65:92:90:59:51:08:cc:9a
                        2a:c8:1a:61:41:6f:e3:18:fe:35:8e:c6:5c:65:3e:da
                        36:f5:27:fe:64:fb:7c:41:cb:5e:bd:c0:6f:ca:52:da
                        5c:c3:45:2a:98:f1:00:88:62:f8:40:84:f5:52:4f:65
                        2b:79:fd:34:f2:32:65:26:92:01:57:93:33:f0:a7:78
                        c3:ca:46:13:14:45:c8:45:ab:2e:cd:45:6c:b7:68:c7
                        51:44:4c:68:63:00:ef:7f:54:58:7b:0b:b9:5c:2b:80
                        d1
                Exponent (bits 24):
                        01:00:01
        Extensions:
                Basic Constraints (critical):
                        Certificate Authority (CA): FALSE
                Key Usage (critical):
                        Digital signature.
                        Key encipherment.
                Subject Key Identifier (not critical):
                        54667e2b87597ad5e6ed3a7404721266c0f14553
                Authority Key Identifier (not critical):
                        9befe62f2d2ff437e5e238e1faf1106f06f66a1f
Other Information:
        Public Key ID:
                sha1:54667e2b87597ad5e6ed3a7404721266c0f14553
                sha256:766541523d32ed9e1b1c65ff56e18ffb8957a104dbc13f0204c8dc2ed14288ea
        Public Key PIN:
                pin-sha256:dmVBUj0y7Z4bHGX/VuGP+4lXoQTbwT8CBMjcLtFCiOo=

Is the above information ok? (y/N): y
```


## Configure nginx
Das Server-Zertifikat, welches von Nginx genutzt wird um überhaupt HTTPS zu unterstützen, wird in der Datei /etc/nginx/openitc/ssl_cert.conf konfiguriert.

```bash
mkdir -p /etc/nginx/ssl
cp ca.key /etc/nginx/ssl/
cp ca.crt /etc/nginx/ssl/
cp server.crt /etc/nginx/ssl/
cp server.key /etc/nginx/ssl/
```

Jetzt die Datei /etc/nginx/openitc/ssl_cert.conf öffnen und die neuen Zertifikate eintragen:

`/etc/nginx/openitc/ssl_cert.conf`
```text
ssl_certificate         /etc/nginx/ssl/server.crt;
ssl_certificate_key     /etc/nginx/ssl/server.key;
ssl_client_certificate  /etc/nginx/ssl/ca.crt;
ssl_verify_client optional;
```

ssl_certificate und ssl_certificate_key können theoretisch bleiben und ist nur erforderlich, wenn der Server selbst die von der CA signierte Zertifikate nutzen soll. Die Optionen ssl_client_certificate und ssl_verify_client sorgen dafür, dass die Validierung der Client Zertifikate, also der des Browsers überprüft werden. Wenn ssl_verify_client auf on gestellt wird, ist die Authentifizierung per Client Zertifikat Pflicht und es kann andernfalls keine Verbindung zu Server aufgebaut werden.

## Configure checks for client certificates
`/etc/nginx/openitc/master.conf`

```text
location ~ \.php$ {
    try_files $uri =404;
    include /etc/nginx/fastcgi_params;
    fastcgi_pass    unix:/run/php/php-fpm-oitc.sock;
    fastcgi_index   index.php;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param OITC_DEBUG 1;
    fastcgi_read_timeout 300;

    # New Params for SSL Client Certificate Authentication
    fastcgi_param  SSL_VERIFIED $ssl_client_verify;
    fastcgi_param  SSL_DN $ssl_client_s_dn;
    fastcgi_param  SSL_CERT $ssl_client_escaped_cert;
}
```

Die Datei /etc/nginx/openitc/master.conf wird bei jedem openITCOCKPIT Update oder beim Aufruf von openitcockpit-update überschrieben! Die oben gezeigten Anpassungen müssen dann wieder manuell angewendet werden! Bitte den Kunden darauf hinweisen!!!

Restart nginx to apply the changes:

```bash
systemctl restart nginx
```

## Create clientCertificates
Zunächst einmal muss einneuer lokaler Benutzer in openITCOCKPIT mit Vorname und Nachname und ggf. passender E-Mail Adresse angelegt werden. Falls eine OU nicht mit dem Namen People angegeben wird, muss die OU Teil der E-Mail Adresse sein (dies ist eine Vorgabe der aktuellen Implementierung in oitc). (OU ist die organizational unit name bei der Zertifikatserstellung)

    Achtung: Der Benutzer sollte umbedingt ein sicheres Passwort bekommen, da auch der Login über E-Mail Adresse + Passwort möglich wäre. Der Befehl pwgen -s -y kann genutzt werden, um sichere Passwörter zu erstellen.

Now you can create the certificate for the user.

```bash
certtool --generate-privkey --bits 2048 --outfile certificate_user.key
certtool --generate-certificate --load-privkey certificate_user.key --load-ca-privkey ca.key --load-ca-certificate ca.crt --outfile certificate_user.crt
```

You must at least answer these questions:
```text
Common name: certificate

Organizational unit name: it-novum

The certificate will expire in (days): 300

Is this a TLS web client certificate? (y/N): y

Is the above information ok? (y/N): y
```

```text
Generating a signed certificate...
Please enter the details of the certificate's distinguished name. Just press enter to ignore a field.
Country name (2 chars):
State or province name:
Locality name:
Organization name:
Organizational unit name:
Common name: Certificate User
UID:
Enter the subject's domain component (DC):
This field should not be used in new certificates.
E-mail:
Enter the certificate's serial number in decimal (123) or hex (0xabcd)
(default is 0x1d86c2307099f1869351797fde2538df2d929cfa)
value:


Activation/Expiration time.
The certificate will expire in (days): 365

Expiration time: Fri Feb 19 13:36:50 2027
CA expiration time: Fri Feb 19 13:18:34 2027
Warning: The time set exceeds the CA's expiration time
Is it ok to proceed? (y/N): y


Extensions.
Does the certificate belong to an authority? (y/N):
Is this a TLS web client certificate? (y/N): y
Will the certificate be used for IPsec IKE operations? (y/N): n
Is this a TLS web server certificate? (y/N): n
Enter a dnsName of the subject of the certificate: n
Enter an additional dnsName of the subject of the certificate:
Enter a URI of the subject of the certificate:
Enter the IP address of the subject of the certificate:
Enter the e-mail of the subject of the certificate:
Will the certificate be used for signing (required for TLS)? (Y/n):
Will the certificate be used for encryption (not required for TLS)? (Y/n):
Will the certificate be used for data encryption? (y/N):
Will the certificate be used to sign OCSP requests? (y/N):
Will the certificate be used to sign code? (y/N):
Will the certificate be used for time stamping? (y/N):
Will the certificate be used for email protection? (y/N):
Enter the URI of the CRL distribution point:
X.509 Certificate Information:
        Version: 3
        Serial Number (hex): 1d86c2307099f1869351797fde2538df2d929cfa
        Validity:
                Not Before: Thu Feb 19 12:36:44 UTC 2026
                Not After: Fri Feb 19 12:36:50 UTC 2027
        Subject: CN=Certificate User
        Subject Public Key Algorithm: RSA
        Algorithm Security Level: Medium (2048 bits)
                Modulus (bits 2048):
                        00:ea:aa:51:41:39:2e:da:86:6e:8f:4c:62:17:73:e1
                        2c:37:f8:f2:27:d4:5c:82:fa:6b:37:40:e2:fb:9b:e3
                        89:72:f8:d2:aa:87:80:5c:43:4a:24:b4:fb:60:4c:a3
                        06:af:8b:5e:25:ec:fc:72:ce:3d:e2:da:f9:1a:32:1f
                        5b:36:9f:ee:3b:1d:c2:70:c0:8b:42:be:8a:9f:a0:ee
                        ee:91:29:30:68:6a:67:c9:a3:25:d4:56:02:a7:13:56
                        4b:5b:16:4a:5a:b3:66:01:a8:8f:13:6a:66:6d:ea:a0
                        14:26:2c:8c:72:72:71:2f:64:65:4b:37:ac:b7:41:b3
                        25:b6:d3:60:09:59:f6:d6:37:a7:1a:08:c7:91:05:65
                        49:50:89:f3:b2:a5:fc:eb:1e:93:70:19:7b:32:4b:32
                        e8:bf:07:fd:e6:78:87:80:1a:db:00:1f:7d:91:b4:68
                        84:29:57:8e:68:ba:61:3e:7d:4a:72:b0:19:ed:c3:43
                        07:e3:c4:b7:cf:39:19:47:16:f8:ed:1d:f6:57:25:61
                        21:fd:e4:49:17:61:2f:7e:4b:07:5d:a6:1f:47:bb:e5
                        d0:59:96:b3:b7:72:dd:9b:98:2c:d8:8b:57:57:e6:df
                        a4:23:84:15:c9:37:a2:e6:aa:34:89:1a:ac:8c:21:2b
                        33
                Exponent (bits 24):
                        01:00:01
        Extensions:
                Basic Constraints (critical):
                        Certificate Authority (CA): FALSE
                Key Purpose (not critical):
                        TLS WWW Client.
                Subject Alternative Name (not critical):
                        DNSname: nDN
                Key Usage (critical):
                        Digital signature.
                        Key encipherment.
                Subject Key Identifier (not critical):
                        f5c2613988392425f029d1c07e4ad20eb5f8a001
                Authority Key Identifier (not critical):
                        9befe62f2d2ff437e5e238e1faf1106f06f66a1f
Other Information:
        Public Key ID:
                sha1:f5c2613988392425f029d1c07e4ad20eb5f8a001
                sha256:777a0ef7c7b85f3e40d20b5438a6e10d32e41982d8b84edc1a2945e0f211e6dd
        Public Key PIN:
                pin-sha256:d3oO98e4Xz5A0gtUOKbhDTLkGYLYuE7cGilF4PIR5t0=

Is the above information ok? (y/N): y


Signing certificate...
```

## Create client p12 file
```bash
certtool --to-p12 --load-privkey certificate_user.key --load-certificate certificate_user.crt --load-ca-certificate ca.crt --outder --outfile certificate_user.p12
```

These three questions must at least be answered:
```text
Enter a name for the key: Test Key
Enter password: asdf12
Confirm password: asdf12
```