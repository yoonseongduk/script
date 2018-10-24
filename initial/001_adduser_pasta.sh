#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 001_adduser_pasta.sh                                             #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.08.21 SAL_SUM:61434                                                     #
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

function check_g5000 {
  y=$( grep '^xadms:' /etc/group | wc -l )
  if [[ -$y -eq 0 ]] ; then 
     ## addgroup ##
     groupadd -g 5000 xadms
  fi
  grep '^xadms:' /etc/group | awk -F: '{print $3}'
}

function sdy_add_rtn {
  y=$( grep '^xadmsdy' /etc/passwd | wc -l )
  if [[ $y -eq 0 ]] ; then

     gid=$( check_g5000 )
     ## adduser --home /home/xadmsdy --shell /bin/bash --disabled-login -gecos . xadmsdy
     useradd -g ${gid} -d /home/xadmsdy -m -s /bin/bash xadmsdy 
  fi
  echo xadmsdy:xadmsdy001 | chpasswd

}

function main_rtn {
  set -xv

  sdy_add_rtn

  y=$( grep '^xadmop01' /etc/passwd | wc -l )
  if [[ $y -eq 0 ]] ; then

     useradd -d /home/xadmop01 -m -s /bin/bash  xadmop01
     PASS=$( echo -n xadmop01 | md5sum | cut -c1-10 )
     echo xadmop01:$PASS | chpasswd

     #cd2883fdc9
  fi 

  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:12349:2015.12.29 Do not delete this line
