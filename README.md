# script

    scrip install - 
    
    step01 
    
    mkdir -p /isc/sorc001/root/sysinst
    cd /isc/sorc001/root/sysinst
    git clone https://github.com/yoonseongduk/script.git 


    step02 
    
    cd ./script
    mkdir -p /isc/sorc001/root/shell
    cp -apr initial/ /isc/sorc001/root/shell/
    cp /isc/sorc001/root/shell/000* /tmp/
    

    step03
    /tmp/000*  ${host_ipaddress}
    
    
# www : workload graph 

## requirement resource 

   var_www.tar.gz 
   
   

## apache install

    apt-get install apache2

    mkdir /var/www
    cd /var; tar -xvf var_www.tar.gz
    
    cpbk /etc/apache2/sites-enabled/000-default.conf 
    cp /var/www/zz-000-default.conf /etc/apache2/sites-enabled/000-default.conf

    cpbk /etc/apache2/conf-available/serve-cgi-bin.conf 
    cp /var/www/zz-serve-cgi-bin.conf /etc/apache2/conf-available/serve-cgi-bin.conf
    
    
    서버 ip setting: 
    => Change:  /var/www/main.html  (From: 10.78.35.35 -> To: 127.0.0.1) 
    => Change:  /var/www/main_left.html  (From: 10.78.35.35 -> To: 127.0.0.1) 
    cd /var/www
    grep 1.255.151.20 *.html
    sed –i ‘s/1.255.151.20/127.0.0.1/g’ *.html


    www-data : 권한추가 /etc/group rule
    => usermod -a -G adm  www-data
    => usermod -a -G sudo www-data

    vi /etc/sudoers
    %sudo ALL=(ALL) NOPASSWD:ALL
    
    Cgi enable 을 위한 mod enable 
    cd /etc/apache2/mods-enables 
    => ln -s /etc/apache2/mods-enables/../mods-available/cgi.load cgi.load


## NMON log get 설치

    o cp ~/.ssh/id_rsa.v1 id_rsa

    o cd /isc/logs001/DAILY 에 다음 script 를 확인한다.
    link.sh, all_get.sh, cpu_get.sh, disk_get.sh, disk_ios.rexx, mem_get.sh, net_get.sh, net_ios.rexx

1.3 mkdir /etc/hosts.group
cd /etc/hosts.group 에서 host_list.sh grp_only -update 수행…

1.4 /usr/local/bin/nmon_logger_hour.rexx  수행
(정상 확인후 :  cron 등록 )
# nmon logget 
4   * * * * /usr/local/bin/nmon_logget_hour.rexx > /usr/local/bin/nmon_logget_hour.log 2>&1
59 23 * * * /usr/local/bin/nmon_logget_hour.rexx > /usr/local/bin/nmon_logget_hour.log 2>&1

