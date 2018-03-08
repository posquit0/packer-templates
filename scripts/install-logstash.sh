#!/usr/bin/env bash

set -euf -o pipefail

# Add Elastic’s official GPG key
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# Set up the stable repository
# Do not use add-apt-repository as it will add a deb-src entry as well
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" \
  | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list

# Install Logstash
apt-get update && apt-get install -y logstash

# Install Logstash X-Pack and other plugins
cd /usr/share/logstash/bin && ./logstash-plugin install x-pack
cd /usr/share/logstash/bin && ./logstash-plugin install logstash-input-cloudwatch_logs

# Update all plugins
cd /usr/share/logstash/bin && ./logstash-plugin update

# Copy configuration files
cp /tmp/files/logstash/logstash.yml /etc/logstash/logstash.yml
cp /tmp/files/logstash/pipelines.yml /etc/logstash/pipelines.yml
cp -a /tmp/files/logstash/conf.d/. /etc/logstash/conf.d

# Enable as service daemon
systemctl daemon-reload && systemctl enable logstash.service
