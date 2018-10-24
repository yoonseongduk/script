#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 012_iplinfo.sh                                                   #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2015.01.16 SAL_SUM:35142                                                     #
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
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/isc/sorc001/root/shell/initial/iplinfo     .
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/isc/sorc001/root/shell/initial/iplinfo_Sxx .

  cp /usr/local/bin/iplinfo_Sxx /etc/init.d/iplinfo
  update-rc.d iplinfo defaults

  /etc/init.d/iplinfo start
  /usr/local/bin/iplinfo
  
  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:35142:2015.01.16 Do not delete this line
