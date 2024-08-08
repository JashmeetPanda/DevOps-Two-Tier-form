#!/bin/sh

sudo apt update
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

echo "Pulling the back-end image from dockerhub"
sudo docker pull jashmeet09/two-tier_backend

echo "Running backend image"
sudo docker run -d -p 3000:3000 jashmeet09/two-tier_backend
