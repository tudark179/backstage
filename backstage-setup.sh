#!/bin/bash

# Update the system
sudo apt-get update
sudo apt-get upgrade -y

# Install necessary dependencies
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Install Node.js 
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Yarn package manager
npm install -g yarn

# Clone the Backstage repository
git clone https://github.com/backstage/backstage.git
cd backstage

# Install dependencies for Backstage
yarn install

# Build the Backstage app
yarn tsc
yarn build

# Start the Backstage backend as a service
nohup yarn start-backend &

# Start the Backstage frontend
nohup yarn start &

# Additional configurations
