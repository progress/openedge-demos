#!/bin/bash

# set -x

Version=$1
PrivateBucket=myprivatebucket12345

case $Version in
117)
# scp /artifacts/sports-app/webui/* $HostName:/var/www/html/
    sudo cp /artifacts/sports-app/${Version}/webui/* /var/www/html/
    cp /artifacts/sports-app/${Version}/webspeed/* /psc/${Version}/wrk
    ;;
122)
    # sudo cp /artifacts/sports-app/${Version}/webspeed/* /psc/${Version}/wrk/oepas1/openedge
    sudo /psc/wrk/oepas1/bin/tcman.sh stop
    cp /artifacts/sports-app/${Version}/app.tar.gz /install/
    tar xCf /install /install/app.tar.gz
    sudo OE_ENV=pasoe DBHostName=localhost DBHostName1=localhost DBHostName2=localhost /install/app/deploy.sh
    sudo OE_ENV=webserver PASOEURL="http://127.0.0.1:8810" HTTP_PORT=8080 /install/app/deploy.sh
    ;;
aws)
    #aws s3 cp /artifacts/sports-app/123/web.tar.gz s3://${PublicBucket}/ --acl public-read
    #aws s3 cp /artifacts/sports-app/123/pas.tar.gz s3://${PublicBucket}/ --acl public-read
    #aws s3 cp /artifacts/sports-app/123/db.tar.gz s3://${PublicBucket}/ --acl public-read    

    aws s3 cp /artifacts/sports-app/123/web.tar.gz s3://${PrivateBucket}/ 
    aws s3 cp /artifacts/sports-app/123/pas.tar.gz s3://${PrivateBucket}/
    aws s3 cp /artifacts/sports-app/123/db.tar.gz s3://${PrivateBucket}/ 
    ./scripts/create_stack.sh
    ;;
esac
