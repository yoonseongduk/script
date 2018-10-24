#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 009_crontab_edit_setup.sh                                        #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.08.21 SAL_SUM:03996                                                     #
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

  echo '3' | select-editor
  
  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:03996:2013.09.03 Do not delete this line
