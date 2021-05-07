iperf -f 'm' -c $1 | grep "/sec" | awk '{print $7 "\t" $8}'
