
FROM debian:stretch

MAINTAINER Guillermo Garcia <ggarcia@realidadfutura.com>

RUN apt-get update                      \
 && apt-get -y install openvpn easy-rsa \
 && apt-get -y autoremove               \
 && apt-get -y autoclean                \
 && mkdir -p /var/log/openvpn           \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /etc/openvpn

ADD run.sh .

VOLUME /etc/openvpn

EXPOSE 1194

CMD ["bash"]
