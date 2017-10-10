#!/usr/bin/env bash

set -euf -o pipefail

GRAFANA_VERSION=4.5.2

# Run Grafana automatically with Docker
docker run -d -p 3000:3000 \
  --restart unless-stopped \
  -v /var/lib/grafana:/var/lib/grafana \
  grafana/grafana:$GRAFANA_VERSION
