#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 004_ssh_setup_root.sh                                            #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2015.10.15 SAL_SUM:50116                                                     #
#             modify  by root                                                   #
#  2013.08.21 SAL_SUM:36513                                                     #
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

  mkdir -p  /root/.ssh
  cp /home/xadmop01/.ssh/id_rsa  /root/.ssh/id_rsa.v1
  cd /root/.ssh          
  chown root:root *
  ls -al 
  
  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:50116:2015.10.15 Do not delete this line
