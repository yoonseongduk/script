#!/bin/bash
#################################################################################
#                                                                               #
# Script Name: cpu_get.sh                                                       #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.07.02 SAL_SUM:36116                                                     #
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

   outfile=$( echo "${infile}" | sed -e 's/_.....nmon/_cpu.nmon/g' )

   grep '^ZZZZ,T0001' ${infile}  > ${outfile}
   grep '^CPU_ALL'    ${infile} >> ${outfile}

fi

# SAL_SUM:36116:2014.01.02 Do not delete this line
