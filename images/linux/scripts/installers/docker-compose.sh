#!/bin/bash -e
################################################################################
##  File:  docker-compose.sh
##  Desc:  Installs Docker Compose
################################################################################
source $HELPER_SCRIPTS/os.sh

# Install latest docker-compose from releases
URL=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.assets[].browser_download_url | select(contains("docker-compose-Linux-x86_64"))' | head -1)
if isUbuntu16 || isUbuntu18 ; then
    URL="https://github.com/docker/compose/releases/download/1.27.4/docker-compose-Linux-x86_64"
fi
curl -L $URL -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

invoke_tests "Tools" "Docker-compose"
