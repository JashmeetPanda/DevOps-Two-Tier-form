#!/bin/sh
sudo apt update
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

echo "Pulling the frontend image from dockerhub"
sudo docker pull jashmeet09/frontend

echo "Running the front-end image"
sudo docker run -d -p 80:80 jashmeet09/frontend
