#!/bin/bash

#
# set -x
#

#touch /tmp/deploy.txt

echo $OE_ENV >> /tmp/deploy.txt
echo $DBHostName >> /tmp/deploy.txt
echo $DBHostName1 >> /tmp/deploy.txt
echo $DBHostName2 >> /tmp/deploy.txt
echo $PASOEURL >> /tmp/deploy.txt

if [ -d /psc/122/dlc ]
then
    export DLC=/psc/122/dlc
else
    export DLC=/psc/dlc
fi
export PATH=$DLC/bin:$PATH

sudo yum -y update
case $OE_ENV in
db0)
    cp /install/app/progress.cfg /psc/dlc/
    cd /psc/wrk

    # /install/app/update_etc_hosts.sh -a "app_prod,${DBHostName} app_dr1,${DBHostName1} app_dr2,${DBHostName2}"

    # prodb sports2020 sports2020
    # proserve sports2020 -S 20000

    mkdir -p aiArchives
    cp /install/app/db/sourceDB.repl.properties sports2020.repl.properties
    sed -i "s/DBHostName2/${DBHostName2}/" sports2020.repl.properties
    sed -i "s/DBHostName1/${DBHostName1}/" sports2020.repl.properties
    sed -i "s/DBHostName/${DBHostName}/" sports2020.repl.properties
    prorest sports2020 /install/app/db/sports2020_backup
    prorest sports2020 /install/app/db/sports2020_backup_incremental
    prostrct add sports2020 /install/app/db/addai.st
    rfutil sports2020 -C aimage begin
    rfutil sports2020 -C aiarchiver enable
    proutil sports2020 -C enableSiteReplication source
    proserve sports2020 -DBService replserv -S 20000 -aiarcdir aiArchives
    ;;
db1)
    cp /install/app/progress.cfg /psc/dlc/
    cd /psc/wrk
    # prodb sports2020 sports2020
    # proserve sports2020 -S 20000

    mkdir -p aiArchives
    cp /install/app/db/targetDB1.repl.properties sports2020.repl.properties
    sed -i "s/DBHostName2/${DBHostName2}/" sports2020.repl.properties
    sed -i "s/DBHostName1/${DBHostName1}/" sports2020.repl.properties
    sed -i "s/DBHostName/${DBHostName}/" sports2020.repl.properties
    prorest sports2020 /install/app/db/sports2020_backup
    prorest sports2020 /install/app/db/sports2020_backup_incremental
    prostrct add sports2020 /install/app/db/addai.st
    rfutil sports2020 -C aimage begin
    rfutil sports2020 -C aiarchiver enable
    proutil sports2020 -C enableSiteReplication target
    proserve sports2020 -DBService replagent -S 20000 -aiarcdir aiArchives
    ;;
db2)
    cp /install/app/progress.cfg /psc/dlc/
    cd /psc/wrk
#    prodb sports2020 sports2020
#    proserve sports2020 -S 20000

    mkdir -p aiArchives
    cp /install/app/db/targetDB2.repl.properties sports2020.repl.properties
    sed -i "s/DBHostName2/${DBHostName2}/" sports2020.repl.properties
    sed -i "s/DBHostName1/${DBHostName1}/" sports2020.repl.properties
    sed -i "s/DBHostName/${DBHostName}/" sports2020.repl.properties
    prorest sports2020 /install/app/db/sports2020_backup
    prorest sports2020 /install/app/db/sports2020_backup_incremental
    prostrct add sports2020 /install/app/db/addai.st
    rfutil sports2020 -C aimage begin
    rfutil sports2020 -C aiarchiver enable
    proutil sports2020 -C enableSiteReplication target
    proserve sports2020 -DBService replagent -S 20000 -aiarcdir aiArchives
    ;;
pasoe)
    sysctl net.ipv4.tcp_syn_retries=2
    cp /install/app/progress.cfg /psc/dlc/
    mkdir -p /psc/wrk/
    cd /psc/wrk
    pasman create -v oepas1
    cp /install/app/pas/rc.local /etc/rc.local
    chmod +x /etc/rc.local
    cp /install/app/pas/autoreconnect.pf /psc/wrk/
    sed -i "s/DBHostName1/${DBHostName1}/" autoreconnect.pf
    sed -i "s/DBHostName2/${DBHostName2}/" autoreconnect.pf
    sed -i "s/DBHostName/${DBHostName}/" autoreconnect.pf
    cp /install/app/pas/openedge.properties /psc/wrk/oepas1/conf/
    cp /install/app/pas/anonymousLoginModel.xml /psc/wrk/oepas1/webapps/ROOT/WEB-INF/spring/
    cp /install/app/pas/*.r /psc/wrk/oepas1/openedge/

    # /psc/wrk/oepas1/bin/tcman.sh import oepas1.oear

    export TERM=xterm
    /psc/wrk/oepas1/bin/tcman.sh pasoestart
	;;
webserver)
    cp /install/app/web/*.html /var/www/html
    cp /install/app/web/*.js /var/www/html

    if [ -f /etc/nginx/sites-available/default ]
    then
        SRC_CONF_FILE=/install/app/web/default
        CONF_FILE=/etc/nginx/sites-available/default
    else
        SRC_CONF_FILE=/install/app/web/nginx.conf
        CONF_FILE=/etc/nginx/nginx.conf
    fi
    cp $SRC_CONF_FILE $CONF_FILE
    if [ -z "$HTTP_PORT" ]
    then
        sed -i "s|HTTP_PORT|80|" $CONF_FILE
    else 
        sed -i "s|HTTP_PORT|${HTTP_PORT}|" $CONF_FILE
    fi
    sed -i "s|PASOEURL|${PASOEURL}|" $CONF_FILE
    systemctl restart nginx 
	;;
esac
