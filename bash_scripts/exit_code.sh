#! /bin/bash


package=not-exist

sudo apt install $package >> package_installations.log

if [ $? -eq 0 ]
then
    echo "The installation of $package was successful."
    echo "The new command is available here:"
    which $package
else
    echo "$package failed to install" >> package_installations_failures.log
fi
