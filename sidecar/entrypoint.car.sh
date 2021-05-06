#!/bin/sh
#
echo "$INFO" "Starting boot ... "$@" " 


USERNAME=scu
GROUPNAME=scu

chown -R $USERNAME:$GROUPNAME /home/scu

gosu scu "$@" 