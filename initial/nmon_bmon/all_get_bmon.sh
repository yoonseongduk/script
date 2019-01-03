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

ls -1 *_0000.bmon   | awk '{ print "./bmon_get.sh",   $1 }' | sh -v

ls -1  *_net.bmon   | awk '{ print "./net_ios_bmon.rexx",  $1 }' | sh -v

rm -f  *_net.bmon
rm -f *_0000.bmon

# SAL_SUM:02268:2014.01.02 Do not delete this line
