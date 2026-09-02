#!/bin/bash
set -eux

dnf install -y docker

if [ -d /run/systemd/system ]; then
  systemctl enable --now docker
else
  dockerd > /var/log/dockerd.log 2>&1 &
  sleep 5
fi

docker pull ghcr.io/lordvladious98/auto-healing-web-tier:latest

docker rm -f web || true

docker run -d \
  --name web \
  --restart unless-stopped \
  -p 80:80 \
  ghcr.io/lordvladious98/auto-healing-web-tier:latest