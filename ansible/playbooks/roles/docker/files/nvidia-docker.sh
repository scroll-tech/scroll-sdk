#!/bin/bash
set -e
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list
#apt-key add /root/nvidia-gpgkey
apt-get update
apt-get install -y nvidia-container-runtime
[ -f /etc/docker/daemon.json ] && cp /etc/docker/daemon.json{,.bak} || :
cat >/etc/docker/daemon.json <<EOF
{
  "runtimes": {
     "nvidia": {
         "path": "/usr/bin/nvidia-container-runtime",
         "runtimeArgs": []
     }
 }
}
EOF
systemctl restart docker
