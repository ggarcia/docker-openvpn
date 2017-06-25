FROM debian:stretch

MAINTAINER Guillermo Garcia <ggarcia@realidadfutura.com>

RUN apt-get update -q \
 && apt-get install -qy openvpn iptables openssl ca-certificates lighttpd wget \
 && apt-get -y autoremove \
 && apt-get -y autoclean  \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /etc/openvpn

ENV	EASYRSA_VER="3.0.1"
ENV EASYRSA_NOM="EasyRSA-${EASYRSA_VER}"
ENV EASYRSA_URL="https://github.com/OpenVPN/easy-rsa/releases/download/${EASYRSA_VER}/${EASYRSA_NOM}.tgz"

# RUN echo "xxx ${EASYRSA_URL}"

RUN cd /etc/openvpn \
  && rm -rf easy-rsa \
  && wget -O ${EASYRSA_NOM}.tgz ${EASYRSA_URL} \
  && tar xvzf ${EASYRSA_NOM}.tgz \
  && mv ${EASYRSA_NOM} easy-rsa \
  && chown -R root:root easy-rsa \
  && rm -f ${EASYRSA_NOM}.tgz

WORKDIR /etc/openvpn

ADD server.sh /etc/openvpn
ADD client.sh /etc/openvpn
ADD run.sh /etc/openvpn

VOLUME /etc/openvpn

EXPOSE 1194

CMD /etc/openvpn/run.sh

