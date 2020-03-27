#! /bin/bash

# This script is used to verify required executables are installed, and install them if they are not. 
# This version of the script takes care of installing the executables on a linux (Ubuntu) environment.

# verify erlang is installed and install if not 
if [[ $(erl -eval 'io:write("test"), halt().' -noshell 2>&1) == *"command not found"* ]];
then
    echo "erlang not installed on machine - installing now."
    sudo apt update && sudo apt install -y erlang
else
    echo "erlang already installed on machine - moving on."
fi

# verify pulumi is installed and install if not
if [[ $(pulumi version 2>&1) == *"command not found"* ]];
then
    echo "pulumi not installed on machine - installing now."
    curl -fsSL https://get.pulumi.com | sh
else 
    echo "pulumi already installed on machine - moving on."
fi

# verify nodejs is installed for pulumi base languages (typescript) and install if not 
if [[ $(nodejs --version) == *"command not found"* ]];
then
    echo "node.js not installed on machine - installing."
    # install nodejs
else 
    echo "node.js installed on machine - moving on."
fi
