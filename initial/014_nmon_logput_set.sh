#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 014_nmon_logput_set.sh                                           #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2015.10.15 SAL_SUM:07868                                                     #
#             modify  by root                                                   #
#  2013.08.21 SAL_SUM:56371                                                     #
#             created by root                                                   #
#                                                                               #
# Licensed Materials - Property of LG CNS                                       #
#                                                                               #
# (C) COPYRIGHT LG CNS Co., Ltd. 2009                                           #
# All Rights Reserved                                                           #
#                                                                               #
#################################################################################
#                                                                               #
#  1.  nmon_logput.sh (from VM ... to V0 )                                      #
#  2.                                                                           #
#                                                                               #
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
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/nmon_logput.sh   .


  ## nmon log get for hour
  ##50  *   * * *   root    /usr/local/bin/nmon_logput.sh
  ##59 23   * * *   root    /usr/local/bin/nmon_logput.sh


  root_crontab='/tmp/crontab.root'
  cat /etc/crontab > ${root_crontab}

  root_crontab_change='NO'
  y=$( grep -w 'nmon_logput.sh'           ${root_crontab} | wc -l )
  if [[ $y -eq 0 ]] ; then 
     echo "#"                                                        >> ${root_crontab}
     echo "## AUTO ADDED by initial script ###"                      >> ${root_crontab}
     echo "50  *    * * *   root    /usr/local/bin/nmon_logput.sh"   >> ${root_crontab}
     echo "59 23    * * *   root    /usr/local/bin/nmon_logput.sh"   >> ${root_crontab}
     root_crontab_change='YES'
  fi


  if [[ "${root_crontab_change}" = "YES" ]] ; then 
     cpbk /etc/crontab
     cp   ${root_crontab} /etc/crontab
  fi  
  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:07868:2015.10.15 Do not delete this line
