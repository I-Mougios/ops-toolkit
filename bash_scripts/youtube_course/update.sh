#!/bin/bash

release_file=/etc/os-release

# Check if the file exists first to avoid errors
if [ -f "$release_file" ]; then

    if grep -q "Arch" "$release_file"; then
        sudo pacman -Syu
    fi

    if grep -q "Pop" "$release_file" || grep -q "Ubuntu" "$release_file"; then
        sudo apt update && sudo apt dist-upgrade -y
    fi

else
    echo "Error: $release_file not found."
    exit 1
fi

exit 0
