#!/bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo chmod 777 /var/run/docker.socket

docker run -d --cpus=1 --memory=2g \
  -e DELEGATE_NAME=docker-delegate \
  -e NEXT_GEN="true" \
  -e DELEGATE_TYPE="DOCKER" \
  -e ACCOUNT_ID=ucHySz2jQKKWQweZdXyCog \
  -e DELEGATE_TOKEN=NTRhYTY0Mjg3NThkNjBiNjMzNzhjOGQyNjEwOTQyZjY= \
  -e DELEGATE_TAGS="" \
  -e MANAGER_HOST_AND_PORT=https://app.harness.io us-docker.pkg.dev/gar-prod-setup/harness-public/harness/delegate:25.11.87301

docker run -d --cpus=0.1 --memory=100m \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e ACCOUNT_ID=ucHySz2jQKKWQweZdXyCog \
  -e MANAGER_HOST_AND_PORT=https://app.harness.io \
  -e UPGRADER_WORKLOAD_NAME=docker-delegate \
  -e UPGRADER_TOKEN=NTRhYTY0Mjg3NThkNjBiNjMzNzhjOGQyNjEwOTQyZjY= \
  -e CONTAINER_STOP_TIMEOUT=3600 \
  -e SCHEDULE="0 */1 * * *" harness/upgrader:latest


sudo export CI_MOUNT_VOLUMES="path/to/local/cert;/etc/ssl/certs/ca-certificates.crt,path/to/local/cert2;/etc/ssl/certs/cacerts.pem"
sudo export WORKING_DIR="/home/vardhankonderu/harness-runner"
sudo chmod +x harness-docker-runner-linux-arm64
sudo -E ./harness-docker-runner-linux-arm64 server
 
