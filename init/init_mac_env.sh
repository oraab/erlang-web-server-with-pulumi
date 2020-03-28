#! /bin/bash

# This script is used to verify required executables are installed, and install them if they are not. 
# This version of the script takes care of installing the executables on a linux (Ubuntu) environment.

# verify pulumi is installed and install if not
if [[ $(pulumi version 2>&1) == *"command not found"* ]];
then
    echo "pulumi not installed on machine - installing now."
    # installing directly as homebrew only supports v1.0.0
    curl -sSL https://get.pulumi.com | sh
else 
    echo "pulumi already installed on machine - moving on."
fi

# verify nodejs is installed for pulumi base languages (typescript) and install if not 
if [[ $(node --version 2>&1) == *"command not found"* ]];
then
    echo "node.js not installed on machine - installing."
    brew update && brew install nodejs
else 
    echo "node.js already installed on machine - moving on."
fi

# verify npm is installed for package management through pulumi and install if not
if [[ $(npm --version 2>&1) == *"command not found"* ]];
then
    echo "npm not installed on machine - installing."
    brew update && brew install npm
else 
    echo "npm already installed on machine - moving on."
fi

# verify awscli is installed for pulumi configuration and install if not 
if [[ $(aws version 2>&1) == *"command not found"* ]];
then
    echo "awscli not installed on machine - installing."
    brew update && brew install awscli
else 
    echo "awscli already installed on machine - moving on."
fi

# verify docker engine is installed and install if not 
if [[ $(docker --version 2>&1) == *"command not found"* ]];
then
    echo "docker engine not installed on machine - installing."
    brew update && brew install docker.io
else 
    echo "docker engine already installed on machine - moving on."
fi

echo "Init script completed."
