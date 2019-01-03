#!/bin/bash
#################################################################################
#                                                                               #
# Script Name: net_get.sh                                                       #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.07.02 SAL_SUM:31215                                                     #
#             created by root                                                   #
#                                                                               #
# Licensed Materials - Property of LG CNS                                       #
#                                                                               #
# (C) COPYRIGHT LG CNS Co., Ltd. 2009                                           #
# All Rights Reserved                                                           #
#                                                                               #
#################################################################################

typeset infile="$1"
typeset outfile="NULL"

if [[ -f "${infile}" ]] ; then

   outfile=$( echo "${infile}" | sed -e 's/_.....nmon/_net.nmon/g' )

   grep    '^ZZZZ,T0001' ${infile}  > ${outfile}
   grep -w '^NET'        ${infile} >> ${outfile}

fi

# SAL_SUM:31215:2014.01.02 Do not delete this line
