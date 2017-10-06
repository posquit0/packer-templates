#!/usr/bin/env bash

set -euf -o pipefail

apt-get install -y \
  build-essential python-software-properties \
  software-properties-common apt-transport-https \
  ca-certificates

apt-get install -y htop jq awscli curl wget git
