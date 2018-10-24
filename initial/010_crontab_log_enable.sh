#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 010_crontab_log_enable.sh                                        #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.08.21 SAL_SUM:26217                                                     #
#             created by root                                                   #
#                                                                               #
# Licensed Materials - Property of LG CNS                                       #
#                                                                               #
# (C) COPYRIGHT LG CNS Co., Ltd. 2009                                           #
# All Rights Reserved                                                           #
#                                                                               #
#################################################################################


  typeset GDC=${GDC:-isc}

  logdir=/${GDC}/logs001/initial_setup
  logfile=$(basename $0).$(date +%Y%m%d).$(date +%H%M%S)
  logdf=$logdir/$logfile
  mkdir -p $logdir


function main_rtn {
  set -xv

  cpbk /etc/rsyslog.d/50-default.conf
  y=$( grep ^cron /etc/rsyslog.d/50-default.conf | wc -l )
  if [[ $y -eq 0 ]] ; then 
     sed -i 's/^#cron/cron/g' /etc/rsyslog.d/50-default.conf
     service rsyslog restart
  fi

  y=$( grep '^exec cron -L 15' /etc/init/cron.conf | wc -l )
  if [[ $y -eq 0 ]] ; then
     cpbk /etc/init/cron.conf
     sed -i 's/^exec cron/exec cron -L 15/g' /etc/init/cron.conf
     service cron    restart
     service rsyslog restart
  fi
  
  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:26217:2013.12.03 Do not delete this line
