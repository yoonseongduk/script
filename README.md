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
    
    
