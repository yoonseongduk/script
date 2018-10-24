#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 006_sal_install.sh                                               #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.08.21 SAL_SUM:57001                                                     #
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

  mkdir /isc; cd /isc
  scp -i /root/.ssh/id_rsa.v1 ${source_ip}:/isc/sorc001/root/shell/initial/sal_package.tar .
  scp -i /root/.ssh/id_rsa.v1 ${source_ip}:/isc/sorc001/root/shell/initial/rexx_up.sh  .
  
  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:57001:2013.09.03 Do not delete this line
