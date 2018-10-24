#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 005_nmon_sh_copy.sh                                              #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.08.21 SAL_SUM:59249                                                     #
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
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/run_nmon.sh   .

  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/host_list.sh  .
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/caller_log.sh .
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/zzcmd.rexx    .
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/zzhost.rexx   .
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/ssh1          .
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/_var2val      .       
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/_rexx         .       
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/usr/local/bin/_rexx_shell_link.sh .

  cd /usr/local/bin
  ln -s zzcmd.rexx  zzcmd
  ln -s zzhost.rexx zzhost
 _rexx_shell_link.sh
  
  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:59249:2015.05.27 Do not delete this line
