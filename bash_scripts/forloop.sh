#! /bin/bash

for f in ./logfiles/*.log
do
    echo "taring file: $f"
    tar -czvf $f.tar.gz $f
    echo "remove the original file to reclaim space"
    rm $f
done

exit 0
