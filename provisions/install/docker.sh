#!/bin/bash

docker_url=https://download.docker.com/linux/ubuntu/dists/trusty/pool/stable/amd64/docker-ce_18.03.1~ce-0~ubuntu_amd64.deb 

apt-get remove docker docker-engine docker.io
apt-get update
apt-get --yes --force-yes install \
	linux-image-extra-$(uname -r) \
	linux-image-extra-virtual

echo "installing docker..."
curl $docker_url 2>/dev/null > docker.deb
dpkg -i docker.deb > /dev/null 2>&1
apt-get -f --yes --force-yes install
if [[ ! $(grep -E "^docker" /etc/group) ]]; then
	echo "docker group not found, adding..."
	groupadd docker
fi
echo "adding $USER to docker group..."
usermod -aG docker ahab
#usermod -aG docker $USER
#usermod -aG docker vagrant
#echo "adding ahab to docker group..."
#usermod -aG docker ahab
# TODO: configure docker socket to accept remote connections as well.