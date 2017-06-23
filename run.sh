#!/bin/sh

DEASY="/etc/openvpn/easy-rsa"

if [ ! -d $DEASY ] ; then
  mkdir -p $DEASY/keys
  cp -Rv /usr/share/easy-rsa/* $DEASY
fi

cat << _EOF_ > $EASY/vars
export KEY_COUNTRY="US"
export KEY_PROVINCE="CA"
export KEY_CITY="SanFrancisco"
export KEY_ORG="Fort-Funston"
export KEY_EMAIL="mail@domain"
export KEY_EMAIL=mail@domain
_EOF_

cd $DEASY
touch keys/index.txt
echo 01 > keys/serial
. ./vars  # set environment variables
./clean-all


./build-ca

./build-key-server server

./build-dh

