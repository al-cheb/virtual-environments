#!/bin/bash -e
################################################################################
##  File:  repos.sh
##  Desc:  Installs official Microsoft package repos for the distribution
################################################################################

LSB_RELEASE=$(lsb_release -rs)

# Install Microsoft repository
wget https://packages.microsoft.com/config/ubuntu/$LSB_RELEASE/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Install Microsoft GPG public key
curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

# update
apt-get -yq update
apt-get -yq dist-upgrade

# Install aria2 and jq
apt-get install aria2
apt-get install jq

# Use apt-fast for parallel downloads
add-apt-repository -y ppa:apt-fast/stable
apt-get update
apt-get install apt-fast