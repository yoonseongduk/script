#!/bin/bash
################################################################################
#
# Script Name: port_scan2.sh
#
# Description: xxxxxxxxxxxxxxxxxxxx script
#
# Modified:
#
#  2017.07.26 SAL_SUM:xxxxx
#             created by root
#
# Licensed Materials - Property of LG CNS
#
# (C) COPYRIGHT LG CNS Co., Ltd. 2009
# All Rights Reserved
#
################################################################################

export PATH=$PATH:/d/install/My_PC/nmap-7.60-win32/nmap-7.60:.
typeset TARGET_IP=${1:-"127.0.0.1"}
typeset PORT_LST="3722 3822 15990 15880 15770 50000 50001 50005 8088 8080 9090 6000"
        PORT_LST="${PORT_LST} 5900 5000 5001 5002 5003 5004 5005 123 25 22 80 443 139 21 23 32768 62768"
        PORT_LST="${PORT_LST} 3306 3389 8000 8005 8009 9999 3000"
        PORT_LST="${PORT_LST} 5100 5200 5900 6100"

PORT_LST=$( echo ${PORT_LST} | sed 's/ /\n/g' | sort -u -n )

function port_scan_rtn {
  [[ ${DEBUG} = "yes" ]] && set -vx
for x in ${PORT_LST} ; do  
 #echo -n "port:${x}..... "; nc -i 1  ${TARGET_IP} ${x}
 #ssh -v -p ${x} ${TARGET_IP} 2>&1 
 #port_scan ${TARGET_IP} ${x} ${x} 1

 ## nmap -Pn -sT -pT22 1.255.151.57 ## 
 ## -T :TCP
 ## -U :UDP
 ## nmap -Pn -sTU -pT${x} ${TARGET_IP} 2>&1 | grep -v filtered | egrep 'open|close' 
    nmap -Pn -sT  -p${x} ${TARGET_IP} 2>&1 | grep -v filtered | egrep 'open|close' 
done
  [[ ${DEBUG} = "yes" ]] && set +vx
}

function service_rtn {
  PORT_LST=$( cat /etc/services | egrep '/tcp|/udp' | awk '{print $2}' | sort -u | grep tcp | awk -F/ '{print $1}' | sort -u -n )
}

## main rtn ##
port_scan_rtn 

if [[ "$2" = "service" ]] ; then 
   service_rtn
   port_scan_rtn
fi


# SAL_SUM:43319:2017.09.13 Do not delete this line
