#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 013_audit_script.sh                                              #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2015.01.16 SAL_SUM:01166                                                     #
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


function main_rtn {
  set -xv

  cd /usr/local/bin 
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/audit_script.sh              .
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/run_audit_and_initial.sh     .

  ### CRONTAB: Audit script
  ##0 0,6,12,18 * * * root  /usr/local/bin/run_audit_and_initial.sh >/dev/null 2>&1
  ###
  root_crontab_change='NO'
  root_crontab='/tmp/crontab.root'
  crontab -l > ${root_crontab}

  y=$( grep -w 'run_audit_and_initial.sh' ${root_crontab} | wc -l )
  if [[ $y -eq 0 ]] ; then 
     echo "#"                         >> ${root_crontab}
     echo "## Audit script"           >> ${root_crontab}
     echo '0 0,6,12,18 * * *  /usr/local/bin/run_audit_and_initial.sh >/dev/null 2>&1' >> ${root_crontab}
     root_crontab_change="YES"
  fi 


  if [[ "${root_crontab_change}" = "YES" ]] ; then 
     cpbk /var/spool/cron/crontabs/root
     cp   ${root_crontab} /var/spool/cron/crontabs/root
     chown root:crontab   /var/spool/cron/crontabs/root

     /usr/local/bin/audit_script.sh initial
  fi


  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:01166:2015.05.27 Do not delete this line
