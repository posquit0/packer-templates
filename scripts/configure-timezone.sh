#!/usr/bin/env bash

set -euf -o pipefail

TIMEZONE="Asia/Seoul"

# Configure TimeZone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
