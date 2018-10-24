#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 015_bmon_report_set.sh                                           #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2015.11.10 SAL_SUM:53474                                                     #
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
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/bmon_batch.sh     .
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/run_bmon_batch.sh .


  ## bmon_batch.sh or hour
  ##0  0    * * *   root    /usr/local/bin/bmon_batch.sh -force


  root_crontab='/tmp/crontab.root'
  cat /etc/crontab > ${root_crontab}

  root_crontab_change='NO'
  y=$( grep -w 'bmon_batch.sh'            ${root_crontab} | wc -l )

  if [[ $y -eq 0 ]] ; then

     echo "#"                                                           >> ${root_crontab}
     echo "## AUTO ADDED by initial script bmon_batch.sh ##"            >> ${root_crontab}
     echo "0  *    * * *   root    /usr/local/bin/run_bmon_batch.sh > /usr/local/bin/run_bmon_batch.log 2>&1" >> ${root_crontab}
     root_crontab_change='YES'

  fi


  if [[ "${root_crontab_change}" = "YES" ]] ; then
     cpbk /etc/crontab
     cp   ${root_crontab} /etc/crontab
  fi

  apt-get -y install bmon 
  /usr/local/bin/run_bmon_batch.sh 

  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:54792:2015.12.03 Do not delete this line
