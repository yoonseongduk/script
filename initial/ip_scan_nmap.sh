#!/bin/bash
################################################################################
#
# Script Name: ip_scan2.sh
#
# Description: xxxxxxxxxxxxxxxxxxxx script
#
# Modified:
#
#  2017.07.26 SAL_SUM:xxxxx
#             created by root
#
# Licensed Materials - Property of LG CNS
#
# (C) COPYRIGHT LG CNS Co., Ltd. 2009
# All Rights Reserved
#
################################################################################

export PATH=$PATH:/d/install/My_PC/nmap-7.60-win32/nmap-7.60:.
typeset TARGET_IP=${1:-"192.168.20.200-250"}


function ip_scan_rtn {
  [[ ${DEBUG} = "yes" ]] && set -vx
  nmap -sP ${TARGET_IP}  
}

## main rtn ##
ip_scan_rtn 

# SAL_SUM:43319:2017.09.13 Do not delete this line
