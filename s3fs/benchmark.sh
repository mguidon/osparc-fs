SAMPLES=8
echo $SAMPLE
for i in {0..9}; 
do  
    echo "============================== FILE SIZE IN MB $((2**i)) =============================="
    mb=$((2**i))
    mbit=$((mb*8))
    prefix=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8 ; echo '')
    file=${prefix}_${mb}.txt
    dd if=/dev/urandom of=${file} bs=1M count=${mb} > /dev/null 2>&1


    echo "==================================== UPLOAD s3fs ===================================="
    start=`date +%s.%N`
    for i in $(seq 1 $SAMPLES);
    do
        cp ${file} /opt/s3fs/bucket/
    done
    end=`date +%s.%N`

    runtime=$( echo "($end - $start)" | bc -l )
    object_time=$( echo "($runtime)/$SAMPLES" | bc -l )
    throughput=$( echo "($SAMPLES * $mbit)/$runtime" | bc -l )
    objects=$( echo "($SAMPLES)/$runtime" | bc -l )
    echo "runtime $runtime, avg object time: $object_time, ojb/s: $objects  throughput=$throughput"

    echo "=================================== DONWLOAD s3fs ===================================="
    start=`date +%s.%N`
    for i in $(seq 1 $SAMPLES);
    do
        cp /opt/s3fs/bucket/${file} .
    done
    end=`date +%s.%N`

    runtime=$( echo "($end - $start)" | bc -l )
    object_time=$( echo "($runtime)/$SAMPLES" | bc -l )
    throughput=$( echo "($SAMPLES * $mbit)/$runtime" | bc -l )
    objects=$( echo "($SAMPLES)/$runtime" | bc -l )
    echo "runtime $runtime, avg object time: $object_time, ojb/s: $objects  throughput=$throughput"

    echo ""
    echo ""

    # echo "==================================== UPLOAD mc ===================================="
    # time mc cp ${file} s3/osparc-data/
    # echo "=================================== DONWLOAD mc ==================================="
    # time mc cp s3/osparc-data/${file} .
done