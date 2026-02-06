#! /bin/bash

dir=/etc
exit_code=0

if [ -d $dir ]
then
    exit_code=$?
    echo "The directory $dir exists"
else
    exit_code=$?
    echo "The directory does not exist. This 'echo'command turns 'exit' to: $?"
fi



