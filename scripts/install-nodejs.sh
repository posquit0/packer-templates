#!/usr/bin/env bash

set -euf -o pipefail

NODEJS_VERSION=8

# Set up the latest Node.js repository and add official GPG key
curl -sL "https://deb.nodesource.com/setup_$NODEJS_VERSION.x" | bash -

# Set up the latest Yarn repository and add official GPG key
add-apt-repository \
  "deb https://dl.yarnpkg.com/debian/ stable main"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

# Install Node.js and Yarn
apt-get update -qq && apt-get install -y nodejs yarn

# Upgrade to the latest of NPM
npm install -g npm

# Install PM2 process manager
npm install -g pm2
