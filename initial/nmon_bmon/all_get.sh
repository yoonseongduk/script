#!/bin/bash
#################################################################################
#                                                                               #
# Script Name: all_get.sh                                                       #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.07.02 SAL_SUM:02268                                                     #
#             created by root                                                   #
#                                                                               #
# Licensed Materials - Property of LG CNS                                       #
#                                                                               #
# (C) COPYRIGHT LG CNS Co., Ltd. 2009                                           #
# All Rights Reserved                                                           #
#                                                                               #
#################################################################################

ls -1 *_0000.nmon | awk '{ print "./cpu_get.sh",    $1 }' | sh -v
ls -1 *_0000.nmon | awk '{ print "./mem_get.sh",    $1 }' | sh -v
ls -1 *_0000.nmon | awk '{ print "./net_get.sh",    $1 }' | sh -v
ls -1 *_0000.nmon | awk '{ print "./disk_get.sh",   $1 }' | sh -v

ls -1  *_net.nmon   | awk '{ print "./net_ios.rexx",  $1 }' | sh -v
ls -1  *_diskr.nmon | awk '{ print "./disk_ios.rexx", $1 }' | sh -v

[[ -d ./detail/ ]] || mkdir ./detail/
mv     *_net.nmon   ./detail/
mv     *_diskr.nmon ./detail/
mv     *_diskw.nmon ./detail/

rm -f *_0000.nmon

# SAL_SUM:02268:2014.01.02 Do not delete this line
