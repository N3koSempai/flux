#!/bin/bash
IP=$(curl -s https://ipify.app.runonflux.io)
openssl genrsa -out ../certs/v1privkey.pem 2048
openssl req -new -key ../certs/v1privkey.pem -out ../certs/v1.key -subj '/CN=self.api.runonflux.io/O=RunOnFlux'
openssl x509 -req -in ../certs/v1.key -CA ../certs/v1rootcert.cert.pem -CAkey ../certs/v1rootcert.privkey.pem -CAcreateserial -out ../certs/v1.crt -days 3650
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout ../certs/v1.key -out ../certs/v1.crt -subj '/CN=self.api.runonflux.io/O=RunOnFlux' -addext "subjectAltName = DNS:self.api.runonflux.io, IP:$IP"
sleep 2
