#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 020_centos_install_util.sh                                       #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2015.11.10 SAL_SUM:53474                                                     #
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


  typeset VM_MGMT="${1:-NO}"

function main_rtn {
  set -xv

  yum install bmon
  yum install regian-rexx
  yum install nmon
  yum install ksh
  yum install sysstat
  yum install ethtool
  yum install nmap

  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:05244:2015.11.17 Do not delete this line
