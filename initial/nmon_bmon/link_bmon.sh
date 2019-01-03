#!/bin/bash -vx

YYYY=$( date +%Y )
mkdir -p /isc/logs001/DAILY/bmon_logall.$YYYY
mkdir -p /isc/logs001/DAILY/bmon_workload.$YYYY

cd /isc/logs001/DAILY/bmon_workload.$YYYY

ln -sf /isc/logs001/DAILY/all_get_bmon.sh       all_get_bmon.sh
ln -sf /isc/logs001/DAILY/bmon_get.sh           bmon_get.sh
ln -sf /isc/logs001/DAILY/net_ios_bmon.rexx     net_ios_bmon.rexx

cd - > /dev/null
