#!/usr/bin/env bash

set -euf -o pipefail

NTP_SERVER="169.254.169.123"

# Install chrony
apt-get install -y chrony

# Configure NTP server
echo "server $NTP_SERVER prefer iburst" | tee -a /etc/chrony/chrony.conf

# Verify the time synchronization
chronyc tracking
