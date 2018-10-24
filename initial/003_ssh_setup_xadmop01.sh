#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 003_ssh_setup_xadmop01.sh                                          #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.08.21 SAL_SUM:00704                                                     #
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

  mkdir -p  /home/xadmop01/.ssh
  cd        /home/xadmop01/.ssh/
  scp -i /root/.ssh/id_rsa.v1 ${source_ip}:/$PWD/*  .
  chown xadmop01:xadmop01 *
  cp  -p id_rsa id_rsa.v1
  ls -al 
  
  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:53785:2015.11.10 Do not delete this line
