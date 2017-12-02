#!/usr/bin/env bash

set -euf -o pipefail

PORTAINER_VERSION=1.15.0

# Run Grafana automatically with Docker
docker run -d -p 9000:9000 \
  --restart unless-stopped \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $PWD/portainer-data:/data \
  --name=portainer \
  portainer/portainer:$PORTAINER_VERSION
