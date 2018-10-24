#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 007_sysstat_install.sh                                           #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.08.21 SAL_SUM:42702                                                     #
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

  cd /isc
  if [[ -f ./rexx_up.sh ]] ; then 
     a='ok'
  else 
     cp /isc/sorc001/root/shell/initial/rexx_up.sh .
  fi 
  echo 'Y' | ./rexx_up.sh

  cd /tmp
  if [[ -f sal_package.tar ]] ; then 
     a='ok'
  else 
     cp /isc/sorc001/root/shell/initial/sal_package.tar .
  fi
  tar -xvf sal*; cd SAL*; ./_install_silence.sh isc perm profile
  
  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:42702:2013.09.03 Do not delete this line
