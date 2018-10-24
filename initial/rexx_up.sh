#!/bin/bash


function rpm_forge_install {
  cd /isc/sorc001
  if [[ -f rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm ]] ; then 
     a='skip'
  else
     #wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
     wget http://repository.it4i.cz/mirrors/repoforge/redhat/el7/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
     #rpm -Uvh rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
     yum install -y ./rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm

     #wget http://dag.wieers.com/rpm/packages/RPM-GPG-KEY.dag.txt
     wget http://repository.it4i.cz/mirrors/repoforge/RPM-GPG-KEY.dag.txt
     rpm --import RPM-GPG-KEY.dag.txt

     wget http://mirror.ghettoforge.org/distributions/gf/el/7/gf/x86_64/gf-release-7-10.gf.el7.noarch.rpm
     yum install -y ./gf-release-7-10.gf.el7.noarch.rpm
  fi
  cd -
}

which apt-get > /dev/null 2>&1 
if [[ $? -eq 0 ]] ; then 
   apt-get install -y wget
   apt-get update
   apt-get install -y regina-rexx
   apt-get install -y nmon       
   apt-get install -y ksh        
   apt-get install -y sysstat    
   apt-get install -y ethtool    
fi

which yum > /dev/null 2>&1 
if [[ $? -eq 0 ]] ; then 
   yum install -y wget 
   rpm_forge_install
   yum install -y regina-rexx
   yum install -y Regina-REXX
   yum install -y nmon
   yum install -y ksh
   yum install -y sysstat
   yum install -y ethtool
fi



mkdir -p /opt/freeware/rexx
ln -s /usr/bin /opt/freeware/rexx/bin


cp sal_package.tar /tmp/
cd /tmp

# SAL_SUM:23824:2013.08.23 Do not delete this line
