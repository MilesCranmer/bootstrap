#!/bin/bash

set -ev

sudo service docker start
{
    sudo groupadd docker
} || {
    echo "docker group already exists" > /dev/stdout
}

{
    sudo usermod -aG docker $USER
} || {
    echo "Already in docker group" > /dev/stdout
    exit 0
}

# Install nvidia-docker and nvidia-docker-plugin
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1_amd64.tar.xz
sudo tar --strip-components=1 -C /usr/bin -xvf /tmp/nvidia-docker*.tar.xz && rm /tmp/nvidia-docker*.tar.xz

# Run nvidia-docker-plugin
sudo -b nohup nvidia-docker-plugin > /tmp/nvidia-docker.log

# Test nvidia-smi
nvidia-docker run --rm nvidia/cuda nvidia-smi
