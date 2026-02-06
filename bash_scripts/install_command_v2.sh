#! /bin/bash

command="htop"


if command -v $command
then
    echo "'$command' is already installed"
else
    sudo apt update && sudo apt install -y $command
fi

$package_name
