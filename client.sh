#!/bin/sh

set -e

ADMINPASSWORD="password"
DNS1="8.8.8.8"
DNS2="8.8.4.4"
PROTOCOL=udp
PORT=1194
HOST=$(wget -4qO- "http://whatismyip.akamai.com/")

if [ -f /etc/openvpn/server.conf ] ; then
  echo "Hay que configurar el server primero (sh /etc/openvpn/server.sh)."
  exit
fi 

cd /etc/openvpn/easy-rsa

nom="$1"

./easyrsa build-client-full $nom nopass

cat > ${nom}.ovpn << _EOF_
echo "client
dev tun
proto $PROTOCOL
sndbuf 0
rcvbuf 0
remote $HOST $PORT
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-CBC
comp-lzo
setenv opt block-outside-dns
key-direction 1
verb 3
<ca>
`cat ../ca.crt`
</ca>
<cert>
`cat pki/issued/$nom.crt`
</cert>
<key>
`cat pki/private/$nom.key`
</key>
<tls-auth>
`cat ../ta.key`
</tls-auth>
_EOF_
