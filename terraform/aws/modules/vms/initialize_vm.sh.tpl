#!/bin/bash

# Ubuntu Configuration
sudo apt update && sudo apt install -y \
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
    make \
    git \
    libjpeg-dev \
    libpq-dev \
    libtiff-dev \
    zlib1g-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev

sudo add-apt-repository ppa:git-core/ppa -y

sudo apt clean
sudo rm -rf /var/lib/apt/lists/*

sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y

# AWS CLI Install
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Amazon CloudWatch Install
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb

# Amazon CloudWatch Status
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a status

# Docker and Docker Compose Install
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt-cache policy docker-ce
sudo apt upgrade -y

sudo apt install docker-ce -y

sudo systemctl status docker
sudo systemctl start docker

sudo usermod -aG docker $USER && newgrp docker

sudo mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.36.2/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
sudo chmod +x ~/.docker/cli-plugins/docker-compose


# Login to ECR
aws ecr get-login-password --region ${VM_AWS_REGION} | docker login --username AWS --password-stdin $(echo ${VM_CONTAINERS_IMAGE_URL} | cut -d'/' -f1)
# Pull and run the Docker image
docker pull ${VM_CONTAINERS_IMAGE_URL}
docker run -d -p 80:80 ${VM_CONTAINERS_IMAGE_URL}


# Logs
cat <<EOF | sudo tee /opt/aws/amazon-cloudwatch-agent/bin/config.json
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/syslog",
            "log_group_name": "portfolio-api-ec2-logs",
            "log_stream_name": "{instance_id}/syslog",
            "timestamp_format": "%b %d %H:%M:%S"
          },
          {
            "file_path": "/var/log/cloud-init.log",
            "log_group_name": "portfolio-api-ec2-logs",
            "log_stream_name": "{instance_id}/cloud-init"
          }
        ]
      }
    }
  }
}
EOF

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json \
  -s
