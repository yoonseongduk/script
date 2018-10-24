#!/bin/bash 
#################################################################################
#                                                                               #
# Script Name: 000_scp_to_target.sh                                             #
#                                                                               #
# Description: xxxxxxxxxxxxxxxxxxxx script                                      #
#                                                                               #
# Modified:                                                                     #
#                                                                               #
#  2015.11.10 SAL_SUM:55938                                                     #
#             add get_file function                                             #
#  2015.10.15 SAL_SUM:55303                                                     #
#             modify  by root                                                   #
#  2013.08.23 SAL_SUM:57236                                                     #
#             created by root                                                   #
#                                                                               #
# Licensed Materials - Property of LG CNS                                       #
#                                                                               #
# (C) COPYRIGHT LG CNS Co., Ltd. 2009                                           #
# All Rights Reserved                                                           #
#                                                                               #
#################################################################################

typeset P1="${1}"
typeset P2="${2}"
typeset indd='/isc/sorc001/root/shell/initial'
typeset hostname_v1="testwebwas01" 
typeset hostname_v0="GET_HOSTNAME"
#
typeset source_ip="NULL"
typeset source_hostname="NULL"
typeset source_vv="NULL"

function set_v1 {
   source_ip="1.255.151.20"
   source_hostname="${hostname_v1}"
   source_vv="V1"
}

function set_v0 {
   source_ip="${P1}"
   source_hostname="${hostname_v0}"
   source_vv="V0"
}

function _help {
cat <<- EOF

 ./000_scp_to_target.sh                              # original use (v1)
 ./000_scp_to_target.sh 1.255.151.20                 # v0 
 ./000_scp_to_target.sh 1.255.151.20  testwebwas01   # v0,hostname

EOF
return 
}

## set initial value ## 
if   [[ "${P1}" = ""             ]] ; then 
   set_v1
elif [[ "${P1}" = "1.255.151.20" ]] ; then 
   set_v1 
elif [[ "${P1}" = "help"         ]] ; then 
   _help
   exit 0
elif [[ "${P1}" = "-h"           ]] ; then 
   _help
   exit 0
elif [[ "${P1}" != [0-9]*.[0-9]*.[0-9]*.[0-9]* ]] ; then 
   _help
   exit 1 
else
   set_v0
fi

export source_ip
export source_hostname
export source_vv


function 000_root_idrsa {
cat <<- EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAuXVvaN6p3qbyYYePOeuIqow5dOJF7geZFJeVZfNMTVUwi50J
sjO+x/fVjANLGZ2fH85xsWzzB/vap4ToDZCF2rY1EA2gKt+Wders0mXzaS5Ijf/F
46Qa2XksLMaFni2BzD4SsIaxfIn62giEV0UEWFP2HF9rmR9LtLKDwHUnAS8WMRba
fg2ZiYwvW3Smf9KZiDVxf8t7TPIKRsEjCJQxGNt4y8RCy4G5h+9wKjh0ai8NMj+P
7d9NB6TwvgdKZog8uAnOqRABTF2kp9/ikRZpK7euJ/7mPbU1Q67v+mnBnnCBkCy0
E/mMZwYwPpWh3g2Gwq0MsoY+4H3ItUkOkMNPRwIDAQABAoIBAGyiapk+XLjMiAwz
MOWXn11veDSMWrQchUH3rQ6kHpzp+t69JTHad7WA6fjy8OnXV590+UoZ7J5Pm/wm
sRtI/e9obdqycJDMmcEG1KRGDfgdoWh0W4GF3ihnf0XXH+vQ8kgmUCJRM+Qkmule
tc684devjul9x3RRTbJSIzT4KtnYsLM/Ps+SYhgn8aSE8yGkq6eQCZH1+i9sbcGU
cnCefhxJ6jYV3jFR6ae57lxIGvs01czf4yEfUujI5xOLlWLt2dOaJ0GFHE7V8usH
uZdsJpUkNgD0aCwqYBy/udiv0+tGXKz1HB8DuhnRw2GzaR+RfrGPZzRC/bpexjId
fCYBCVkCgYEA4c/vKRSToJ3iT+hM+YGGvhLt0MqRcQWbAQKxXF8ebD2YMOzbu3yV
VRv0CK4H6kZoL66s0gsDNWzmMbOs4RMoCUCUPUpippACMnGPwVCZNeZP6O33RK/v
gdU2B8sOI9vaxAT2nd08j66Xkx4DDie2DPH1DWCaVP9i1tbNSKTO5vMCgYEA0kB3
TwuI8FkMSEpEF8es4hCsS7Qdt70wjPaqLhx0E7NWfwo09IuFIt2M+Nay9/L6Npn2
MmZEh1DU9BsiMh6qb/DhfjhIoiZhE3jJqs9x7+BkIN8wDh1KK5rpqyvivodfbNhf
85pjRihnsnatudfk0/KKhqCuy9ChabKNk5PNM10CgYAHbbvEcjTZF9iWIGJH4wb3
wc+pCsD2IuUSh3AmRcrObMhQ87nW1SZkgmLo1jDUeDR9PRXaYxpb65U3FV4emW67
vzAhRA0yxZIM7sd36Jrhtw3x78IutEsAzm7Ums2ASH9N64vhbaHMaEX8RQR8trm6
e0tAgWkSWsR5pN9kAGf+GQKBgCaod8du5YTbuqhoD1EYA6+lRSi+O2CXRqAEkpHb
5XPh25uMMuRr6tTYS51NTKbOZDc548yshRkkQaOIgacZgFkIv01H6AL4b4z2/o2L
ivWCGqb4ootV01dlKmWwsgY6Oc93kVznHC3ALCDiNVsgWRCnXdUXIkyTVbprfCCQ
YoB5AoGBAIvUpNxrr+HRFvrQSJW9xoMGcUkJeCD2I6PYdcVYSqHztT57jfUZYWyH
NfwrRCKhzbJE+BEOPYULE+rQkxo0CIYZ32YZP+2pJiJVzHI192KcFxNAiaKdzrq3
jILhwDcwGVjMALrsrQleO1l4X83Q/qNMpMSQyh4pPaP3iqdRjn0h
-----END RSA PRIVATE KEY-----
EOF
return 
}

function 000_root_authkey {
cat <<- EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5dW9o3qnepvJhh48564iqjDl04kXuB5kUl5Vl80xNVTCLnQmyM77H99WMA0sZnZ8fznGxbPMH+9qnhOgNkIXatjUQDaAq35Z16uzSZfNpLkiN/8XjpBrZeSwsxoWeLYHMPhKwhrF8ifraCIRXRQRYU/YcX2uZH0u0soPAdScBLxYxFtp+DZmJjC9bdKZ/0pmINXF/y3tM8gpGwSMIlDEY23jLxELLgbmH73AqOHRqLw0yP4/t300HpPC+B0pmiDy4Cc6pEAFMXaSn3+KRFmkrt64n/uY9tTVDru/6acGecIGQLLQT+YxnBjA+laHeDYbCrQyyhj7gfci1SQ6Qw09H root@LCNBSPTPRX01H
EOF
return
}


function get_file_and_run {
  scp -i /root/.ssh/id_rsa.v1 ${source_ip}:${indd}/${1} ${indd}
  cd  ${indd}
  ./${1}
  cd - > /dev/null 
}

function get_file {
  scp -i /root/.ssh/id_rsa.v1 ${source_ip}:${indd}/${1} ${indd}
}

function get_hostname {
  ssh -i /root/.ssh/id_rsa.v1 ${source_ip} "uname -a" | awk '{print $2}'
}

## main ##

mkdir -p /root/.ssh/; cd /root/.ssh/
y=$( cat authorized_keys | grep 'root@LCNBSPTPRX01H' | wc -l )
if [[ $y -eq 0 ]] ; then 
   000_root_authkey >> authorized_keys
fi
000_root_idrsa    > id_rsa.v1
chown root:root     id_rsa.v1
chmod 0600          authorized_keys
chmod 0600          id_rsa.v1

source_hostname=$( get_hostname )
export source_hostname

y=$( grep -w "^${source_ip}" /etc/hosts | wc -l )
if [[ $y -eq 0 ]] ; then
   echo "# Pasta management server ${source_vv}"        >> /etc/hosts
   echo "${source_ip}  ${source_hostname} ${source_vv}" >> /etc/hosts
fi
cd - > /dev/null 


mkdir -p $indd
if [[ ! -f ${indd}/000_scp_to_target.sh ]] ; then 
   cp ./000_scp_to_target.sh  ${indd}/
fi

get_file         rexx_up.sh
get_file         sal_package.tar

get_file_and_run 001_adduser_pasta.sh
get_file_and_run 002_etc_hosts.sh     
get_file_and_run 003_ssh_setup_xadmop01.sh
get_file_and_run 004_ssh_setup_root.sh
get_file_and_run 005_nmon_sh_copy.sh
get_file_and_run 006_sal_install.sh
get_file_and_run 007_sysstat_install.sh
get_file_and_run 008_rba_workload_install.sh
get_file_and_run 009_crontab_edit_setup.sh
get_file_and_run 010_crontab_log_enable.sh
get_file_and_run 011_change_expire_date_xadmop01.sh
get_file_and_run 012_iplinfo.sh
get_file         013_audit_script.sh
get_file         016_dumpxml.sh     
get_file_and_run 020_centos_install_util.sh
get_file_and_run 014_nmon_logput_set.sh
get_file_and_run 015_bmon_report_set.sh

# SAL_SUM:42696:2017.09.01 Do not delete this line
