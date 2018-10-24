#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 008_rba_workload_install.sh                                      #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.08.21 SAL_SUM:56371                                                     #
#             created by root                                                   #
#                                                                               #
# Licensed Materials - Property of LG CNS                                       #
#                                                                               #
# (C) COPYRIGHT LG CNS Co., Ltd. 2009                                           #
# All Rights Reserved                                                           #
#                                                                               #
#################################################################################


  typeset GDC=${GDC:-isc}
  typeset source_ip=${source_ip:-"v1"}

  logdir=/${GDC}/logs001/initial_setup
  logfile=$(basename $0).$(date +%Y%m%d).$(date +%H%M%S)
  logdf=$logdir/$logfile
  mkdir -p $logdir

function deploy_workload_rba_report {
## HC ##
sudo mkdir -p /isc/AUDIT/script; sudo mkdir -p /isc/AUDIT/logs
sudo scp -i /root/.ssh/id_rsa.v1 root@${source_ip}:/isc/BOT/script/linux/Ubuntu/common/HC_Ubuntu_* /isc/AUDIT/script/
sudo scp -i /root/.ssh/id_rsa.v1 root@${source_ip}:/isc/BOT/script/linux//Health_check_start.sh /isc/AUDIT/script/

## crontab ##
sudo scp -i /root/.ssh/id_rsa.v1 root@${source_ip}:/isc/sorc001/root/shell/menu/util/rba_cron_report.util.org /isc/sorc001/root/shell/menu/util/rba_cron_report.util

## ip ##
sudo scp -i /root/.ssh/id_rsa.v1 root@${source_ip}:/usr/local/bin/ip_addr.rexx /usr/local/bin/ip_addr.rexx
}

function main_rtn {
  set -xv

  ##25 6    * * *   root    cd
  ##0  *    * * *   root    /usr/local/bin/run_nmon.sh
  ##0  6    * * *   root    /isc/sorc001/root/shell/menu/util/rba_cron_report.util > /isc/logs001/root/shell/menu/crontab/rba_cron_report.log 2>&1 
  ##0  6    * * 1   root    /isc/AUDIT/script/Health_check_start.sh > /isc/AUDIT/logs/Health_check_start.out 2>&1

  deploy_workload_rba_report

  /usr/local/bin/run_nmon.sh
  root_crontab='/tmp/crontab.root'
  cat /etc/crontab  > ${root_crontab}

  root_crontab_change='NO'
  y=$( grep -w 'run_nmon.sh'           ${root_crontab} | wc -l )
  if [[ $y -eq 0 ]] ; then 
     echo "## AUTO ADDED by DEVOPS initial script ###"   >> ${root_crontab}
     echo "0  *    * * *   root /usr/local/bin/run_nmon.sh"   >> ${root_crontab}
     root_crontab_change='YES'
  fi

  y=$( grep -w 'rba_cron_report.util'  ${root_crontab} | wc -l )
  if [[ $y -eq 0 ]] ; then 
     echo "0  6    * * *   root /isc/sorc001/root/shell/menu/util/rba_cron_report.util > /isc/logs001/root/shell/menu/crontab/rba_cron_report.log 2>&1"   >> ${root_crontab}
     mkdir -p /isc/logs001/root/shell/menu/crontab/
     root_crontab_change='YES'
  fi

  y=$( grep -w 'Health_check_start.sh' ${root_crontab} | wc -l )
  if [[ $y -eq 0 ]] ; then 
     echo "0  6    * * 1   root /isc/AUDIT/script/Health_check_start.sh > /isc/AUDIT/logs/Health_check_start.out 2>&1" >> ${root_crontab}
     mkdir -p /isc/AUDIT/logs/
     root_crontab_change='YES'
  fi

  if [[ "${root_crontab_change}" = "YES" ]] ; then 
     cpbk /etc/crontab
     cp   ${root_crontab} /etc/crontab
  fi  
  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:56371:2013.09.04 Do not delete this line
