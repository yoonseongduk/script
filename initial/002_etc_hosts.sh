#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 002_etc_hosts.sh                                                 #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.08.21 SAL_SUM:46185                                                     #
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

  y=$( grep -w 'testwebwas01' /etc/hosts | wc -l )
  if [[ $y -eq 0 ]] ; then

     echo "# Pasta management server"     >> /etc/hosts
     echo "1.255.151.20  testwebwas01 V1" >> /etc/hosts

  fi 

  y=$( grep -w 'xadmop01'      /etc/sudoers | wc -l )
  if [[ $y -eq 0 ]] ; then
     sed -i '/^root/i xadmop01  ALL=(ALL:ALL) NOPASSWD:NOPASSWD:ALL' /etc/sudoers
  fi 

  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:46185:2013.09.03 Do not delete this line
