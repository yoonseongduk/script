#!/bin/bash
#################################################################################
#                                                                               #
# Script Name: disk_get.sh                                                      #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2013.07.02 SAL_SUM:50055                                                     #
#             created by root                                                   #
#                                                                               #
# Licensed Materials - Property of LG CNS                                       #
#                                                                               #
# (C) COPYRIGHT LG CNS Co., Ltd. 2009                                           #
# All Rights Reserved                                                           #
#                                                                               #
#################################################################################

typeset infile="$1"
typeset outfile_r="NULL"
typeset outfile_w="NULL"

if [[ -f "${infile}" ]] ; then

   outfile_r=$( echo "${infile}" | sed -e 's/_.....nmon/_diskr.nmon/g' )
   grep    '^ZZZZ,T0001' ${infile}  > ${outfile_r}
   grep -w '^DISKREAD'   ${infile} >> ${outfile_r}

   outfile_w=$( echo "${infile}" | sed -e 's/_.....nmon/_diskw.nmon/g' )
   grep    '^ZZZZ,T0001' ${infile}  > ${outfile_w}
   grep -w '^DISKWRITE'  ${infile} >> ${outfile_w}

fi

# SAL_SUM:50055:2014.01.02 Do not delete this line
