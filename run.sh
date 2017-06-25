#!/bin/sh

set -e

[ -d /dev/net ] || mkdir -p /dev/net
[ -c /dev/net/tun ] || mknod /dev/net/tun c 10 200

cd /etc/openvpn

[ -d server.conf ] || sh ./server.sh

# iptables -t nat -A POSTROUTING -s 192.168.255.0/24 -o eth0 -j MASQUERADE

touch server.log
while true ; do openvpn server.conf ; done >> server.log &
tail -F *.log
