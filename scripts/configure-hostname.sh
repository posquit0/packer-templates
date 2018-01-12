#!/usr/bin/env bash

set -euf -o pipefail

CLI53_VERSION=0.8.12
CLI53_ARCH=linux-amd64

# Install cli53 binary
wget https://github.com/barnybug/cli53/releases/download/$CLI53_VERSION/cli53-$CLI53_ARCH -q -O /usr/local/bin/cli53
chmod 755 /usr/local/bin/cli53

# Setting configuration file
mkdir -p /etc/route53
mv /tmp/files/cli53/config /etc/route53/config
chmod 700 /etc/route53
chmod 600 /etc/route53/config

# Upload update-route53-dns
mv /tmp/files/cli53/update-route53-dns /usr/sbin/

# Enable as dhclient exit hook
ln -s /usr/sbin/update-route53-dns /etc/dhcp/dhclient-exit-hooks.d/
ln -s /usr/sbin/update-route53-dns /var/lib/cloud/scripts/per-boot/
