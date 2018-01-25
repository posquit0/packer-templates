#!/usr/bin/env bash

set -euf -o pipefail

JAVA_VERSION=8

# Add Oracle JAVA PPA
sudo add-apt-repository -y ppa:webupd8team/java

# Accept the Oracle License
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

# Set default answer for any questions a package might ask
export DEBIAN_FRONTEND=noninteractive

# Install Oracle JAVA
apt-get update && apt-get install -y oracle-java$JAVA_VERSION-installer
