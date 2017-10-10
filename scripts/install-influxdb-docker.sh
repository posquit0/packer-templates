#!/usr/bin/env bash

set -euf -o pipefail

INFLUXDB_VERSION=1.3.6

# Increase OS UDP traffic limit to 25MB
echo "net.core.rmem_max=26214400" | tee -a /etc/sysctl.conf
echo "net.core.rmem_default=26214400" | tee -a /etc/sysctl.conf

# Copy configuration files
cp /tmp/files/influxdb/influxdb.conf $PWD
cp /tmp/files/influxdb/types.db $PWD

# Run InfluxDB automatically with Docker
docker run -d -p 8086:8086 -p 25826:25826/udp \
  -v /var/lib/influxdb:/var/lib/influxdb \
  -v $PWD/influxdb.conf:/etc/influxdb/influxdb.conf:ro \
  -v $PWD/types.db:/usr/share/collectd/types.db:ro \
  influxdb:$INFLUXDB_VERSION-alpine
