#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 011_change_expire_date_xadmop01.sh                                 #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.08.21 SAL_SUM:54140                                                     #
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

  chage -l root                                 
  chage -l xadmop01                               
  chage -E -1 -I -1 -m 0 -M 99999 -W 7 root   
  chage -E -1 -I -1 -m 0 -M 99999 -W 7 xadmop01
  chage -E -1 -I -1 -m 0 -M 99999 -W 7 xadmsdy
  chage -l root                                 
  chage -l xadmop01                               

  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:13046:2015.12.03 Do not delete this line
