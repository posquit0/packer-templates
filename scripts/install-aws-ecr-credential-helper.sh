#!/usr/bin/env bash

set -euf -o pipefail

# Clone the official repository
git clone https://github.com/awslabs/amazon-ecr-credential-helper /tmp/ecr-helper

# Build binary
cd /tmp/ecr-helper && make docker

# Move the executable binary to $PATH
mv ./bin/local/docker-credential-ecr-login /usr/local/bin/

# Copy configuration files
mkdir -p ~/.docker
cp /tmp/files/aws-ecr-credential-helper/config.json ~/.docker/config.json
