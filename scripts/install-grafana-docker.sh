#!/usr/bin/env bash

set -euf -o pipefail

# Run Grafana automatically with Docker
docker run -d -p 3000:3000 \
  --restart unless-stopped \
  -v /var/lib/grafana:/var/lib/grafana \
  grafana/grafana
