#!/usr/bin/env bash

set -euf -o pipefail

GRAFANA_VERSION=4.6.3
# Plugins to install as default
GRAFANA_PLUGINS="raintank-worldping-app,cloudflare-app,grafana-worldmap-panel,"
GRAFANA_PLUGINS+="grafana-clock-panel,grafana-piechart-panel,btplc-alarm-box-panel,"
GRAFANA_PLUGINS+="novalabs-annotations-panel,digiapulssi-breadcrumb-panel,"
GRAFANA_PLUGINS+="digrich-bubblechart-panel,neocat-cal-heatmap-panel,"
GRAFANA_PLUGINS+="petrslavotinek-carpetplot-panel,briangann-datatable-panel,"
GRAFANA_PLUGINS+="jdbranham-diagram-panel,natel-discrete-panel,"
GRAFANA_PLUGINS+="mtanda-heatmap-epoch-panel,mtanda-histogram-panel,"
GRAFANA_PLUGINS+="natel-plotly-panel,vonage-status-panel"

# Copy configuration files
cp /tmp/files/grafana/grafana.ini $PWD

# Run Grafana automatically with Docker
docker run -d -p 3000:3000 \
  --restart unless-stopped \
  -v /var/lib/grafana:/var/lib/grafana \
  -v $PWD/grafana.ini:/etc/grafana/grafana.ini \
  -e "GF_INSTALL_PLUGINS=$GRAFANA_PLUGINS"\
  --name=grafana \
  grafana/grafana:$GRAFANA_VERSION
