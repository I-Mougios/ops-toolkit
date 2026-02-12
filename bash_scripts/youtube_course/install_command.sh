#! /bin/bash

package_name="htop"
path_to_check=/usr/bin/${package_name}

if [ -f $path_to_check ]
then
    echo "'$package_name' is already installed"
else
    sudo apt update && sudo apt install -y $package_name
fi

$package_name
