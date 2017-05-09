#!/usr/bin/env bash

echo "Setting system locale..."
echo "========================"

echo "LC_ALL=en_US.UTF-8" | sudo tee -a /etc/environment
echo "LANG=en_US.UTF-8" | sudo tee -a /etc/environment

echo "Setting system timezone..."
echo "========================"

sudo timedatectl set-timezone Asia/Kolkata

echo "Updating package repositories..."
echo "================================"

sudo apt-get update

echo "Installing Linux image extras for the AUFS storage driver..."
echo "============================================================"

sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual

echo "Installing helper packages..."
echo "============================================================"

sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

echo "Adding the official Docker GPG key..."
echo "====================================="

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "Adding Docker's repository..."
echo "============================="

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "Installing Docker..."
echo "===================="

sudo apt-get update
sudo apt-get install -y docker-ce

echo "Adding the current user to the Docker group..."
echo "=============================================="

sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart
