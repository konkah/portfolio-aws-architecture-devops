#!/bin/bash

# Ubuntu Configuration
apt update && apt install -y \
    net-tools \
    nano \
    curl \
    unzip \
    pkg-config \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3 \
    python3-pip \
    python3-dev \
    python-tk \
    awscli \
    make \
    libjpeg-dev \
    libpq-dev \
    libtiff-dev \
    libjpeg62-turbo-dev \
    zlib1g-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev

add-apt-repository ppa:git-core/ppa -y

apt clean
rm -rf /var/lib/apt/lists/*

apt upgrade -y
apt autoremove -y
apt autoclean -y


# Docker and Docker Compose Install
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt-cache policy docker-ce
apt upgrade -y

apt install docker-ce

systemctl status docker
systemctl start docker

usermod -aG docker $USER && newgrp docker

mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.36.2/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose


# Login to ECR
aws ecr get-login-password --region ${VM_AWS_REGION} | docker login --username AWS --password-stdin $(echo ${VM_CONTAINERS_IMAGE_URL} | cut -d'/' -f1)
# Pull and run the Docker image
docker pull ${VM_CONTAINERS_IMAGE_URL}
docker run -d -p 80:80 ${VM_CONTAINERS_IMAGE_URL}
