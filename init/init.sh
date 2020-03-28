#! /bin/bash 

# Wrapper script for initialization of environment - determines whether it's running on mac or Ubuntu and runs correct init script

if [[ $(uname) == *"Darwin"* ]];
then
    echo "Running init script on Mac."
    ./init_mac_env.sh
elif [[ $(uname) == *"Ubuntu"* ]];
then 
    echo "running init script on Ubuntu."
    ./init_ubuntu_env.sh
else
    echo "Environment not supported for this demo.";
    exit 1
fi
