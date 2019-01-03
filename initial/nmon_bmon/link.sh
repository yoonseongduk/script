#!/bin/bash -vx

YYYY=$( date +%Y )
mkdir -p /isc/logs001/DAILY/nmon_logall.$YYYY
mkdir -p /isc/logs001/DAILY/nmon_workload.$YYYY

cd /isc/logs001/DAILY/nmon_workload.$YYYY

ln -sf /isc/logs001/DAILY/all_get.sh       all_get.sh

ln -sf /isc/logs001/DAILY/cpu_get.sh       cpu_get.sh

ln -sf /isc/logs001/DAILY/net_get.sh       net_get.sh
ln -sf /isc/logs001/DAILY/net_ios.rexx     net_ios.rexx

ln -sf /isc/logs001/DAILY/mem_get.sh       mem_get.sh

ln -sf /isc/logs001/DAILY/disk_get.sh      disk_get.sh
ln -sf /isc/logs001/DAILY/disk_ios.rexx    disk_ios.rexx

cd - > /dev/null
