#! /bin/bash

dir=/etc-not-exist

if [ -d $dir ]
then
    echo "The directory $dir exists"
    exit 0
else
    echo "The directory does not exist"
    exit 199
fi


echo "The exit code for this script is: $?"
echo "You didn't see the statement"
echo "You will not see this either because execution stopped at first encounter of exit command"
