#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 016_dumpxml.sh                                                   #
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
  typeset source_ip=${source_ip:-"v1"}

  logdir=/${GDC}/logs001/initial_setup
  logfile=$(basename $0).$(date +%Y%m%d).$(date +%H%M%S)
  logdf=$logdir/$logfile
  mkdir -p $logdir


  typeset VM_MGMT="${1:-NO}"

function main_rtn {
  set -xv

  cd /usr/local/bin 
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/isc/sorc001/root/shell/initial/dumpxml.sh       .

  [[ -d /isc/logs001/DAILY/bmon_log ]] || mkdir -p /isc/logs001/DAILY/bmon_log
  cd /isc/logs001/DAILY/bmon_log
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/isc/sorc001/root/shell/initial/ipaddr.conf      .
  scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/isc/sorc001/root/shell/initial/ipaddr_get.sh    .

  echo "./016_dumpxml.sh YES "
  echo "./016_dumpxml.sh YES "
  echo "./016_dumpxml.sh YES "

  ## vm_mgmt only ##
  if [[ "${VM_MGMT}" = "YES" ]] ; then 
     cd /isc/logs001/DAILY/bmon_log
     scp -i ~/.ssh/id_rsa.v1 ${source_ip}:/isc/sorc001/root/shell/initial/ipaddr_query.sh  .   

     ## Openstack mgmt_vm only ipaddr_query.sh     ##
     ##0   0   * * *   root    /isc/logs001/DAILY/bmon_log/ipaddr_query.sh -batch

     root_crontab='/tmp/crontab.root'
     cat /etc/crontab > ${root_crontab}

     root_crontab_change='NO'
     y=$( grep -w 'ipaddr_query.sh'          ${root_crontab} | wc -l )

     if [[ $y -eq 0 ]] ; then

        echo "#"                                                                          >> ${root_crontab}
        echo "## Openstack mgmt_vm only ipaddr_query.sh     ##"                           >> ${root_crontab}
        echo "0  *    * * *   root    /isc/logs001/DAILY/bmon_log/ipaddr_query.sh -batch" >> ${root_crontab}
        root_crontab_change='YES'

     fi


     if [[ "${root_crontab_change}" = "YES" ]] ; then
        cpbk /etc/crontab
        cp   ${root_crontab} /etc/crontab
     fi
  fi 

  set +xv
}

main_rtn 2>&1 | tee -a $logdf
# SAL_SUM:05244:2015.11.17 Do not delete this line
