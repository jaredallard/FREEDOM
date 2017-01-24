FROM resin/rpi-raspbian:latest

ENV INITSYSTEM on
CMD ["./init.sh"]

RUN apt-get update
RUN apt-get install -y net-tools dnsmasq openvpn libnl-3-200 libnl-genl-3-200 dbus haveged hostapd
RUN mkdir -p /FREEDOM
WORKDIR /usr/src/app

# Override config files
COPY ./cfg/dnsmasq.conf /etc/dnsmasq.conf
COPY ./cfg/hostapd.conf /etc/hostapd/hostapd.conf

# Override hostapd binary
COPY ./bin/hostapd /usr/sbin/hostapd
COPY ./bin/hostapd_cli /usr/sbin/hostapd_cli

# Copy the rest.
COPY init.sh ./
