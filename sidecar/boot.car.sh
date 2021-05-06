#!/bin/sh
#
echo "THIS IS THE CAR"

echo "THIS IS" whoami 

ls -l /home/scu
ls -l /data


for i in {0..10}; 
do  
    mb=$((16))
    file=sample_${mb}_${i}.txt
    dd if=/dev/urandom of=${file} bs=1M count=${mb}
    time cp ${file} /data
done

echo "CAR IS DONE"
