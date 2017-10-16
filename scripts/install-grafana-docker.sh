#!/usr/bin/env bash

set -euf -o pipefail

GRAFANA_VERSION=4.5.2

# Copy configuration files
cp /tmp/files/grafana/grafana.ini $PWD

# Run Grafana automatically with Docker
docker run -d -p 3000:3000 \
  --restart unless-stopped \
  -v /var/lib/grafana:/var/lib/grafana \
  -v $PWD/grafana.conf:/etc/grafana/grafana.ini:ro \
  --name=grafana \
  grafana/grafana:$GRAFANA_VERSION
