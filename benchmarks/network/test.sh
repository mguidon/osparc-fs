#!/bin/bash

deployment=dalco
nodes=(01 02 03 04 05 06 07 08)

for n in ${nodes[@]}; do
  master=osparc-$deployment-$n
  master_ip=`ssh -G $master | awk '/^hostname / { print $2 }'`
  ssh $master "kill -9 \$(ps -aux | grep iperf | head -1 | awk '{print \$2}')" 
  ssh $master "/bin/bash -c 'nohup iperf -s > /dev/null 2>&1 &'"
  
  for node in ${nodes[@]}; do
    client=osparc-$deployment-$node
    client_ip=`ssh -G $client | awk '/^hostname / { print $2 }'`
    echo "$n<---$node" && ssh $client "/bin/bash -s " < bandwidth.sh $master_ip
  done
  ssh $master "kill -9 \$(ps -aux | grep iperf | head -1 | awk '{print \$2}')" 
done
