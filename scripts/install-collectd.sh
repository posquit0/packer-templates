#!/usr/bin/env bash

set -euf -o pipefail

COLLECTD_VERSION=5.8

# Add collectd’s official GPG key
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 3994D24FB8543576

# Set up the latest repository
add-apt-repository \
  "deb http://pkg.ci.collectd.org/deb \
  $(lsb_release -c -s) collectd-$COLLECTD_VERSION"

# Install collectd
apt-get update -qq && apt-get install -y collectd

# Copy configuration files
cp /tmp/files/collectd/collectd.conf /etc/collectd/collectd.conf
