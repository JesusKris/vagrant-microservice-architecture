#!/bin/bash

# Argument 1: Folder path
folder_path=$1
app_name=$2

# Navigate to project root
cd "$folder_path"

# System updates
sudo apt update
sudo apt upgrade

# Install nodejs v16.x
sudo apt-get install -y curl
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install npm
sudo apt-get install npm -y

# Fix all trailing dependencies
sudo apt autoremove
sudo apt --fix-broken install -y
sudo npm audit fix --force

# Run npm install
sudo npm install -y

# Install PM2
sudo npm install pm2 -g

# Start node server using PM2
pm2 start server.js --name "$app_name"

# Saving the process
pm2 save

# # Moving it to vagrant home dir for easier use after
# sudo mv /root/.pm2/ /home/vagrant/

