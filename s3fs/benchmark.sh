for i in {0..10}; 
do  
    echo "============================== FILE SIZE IN MB $((2**i)) =============================="
    mb=$((2**i))
    file=sample_${mb}.txt
    dd if=/dev/urandom of=${file} bs=1M count=${mb}
    echo "==================================== UPLOAD goofys ===================================="
    time cp ${file} /opt/s3fs/bucket/
    echo "=================================== DONWLOAD goofys ===================================="
    time cp /opt/s3fs/bucket/${file} .

    echo "==================================== UPLOAD mc ===================================="
    time mc cp ${file} s3/osparc-data/
    echo "=================================== DONWLOAD mc ==================================="
    time mc cp s3/osparc-data/${file} .
done