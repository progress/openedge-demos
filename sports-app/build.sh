#!/bin/bash

# set -x 

Version=$1
export display_banner=no
export TERM=xterm

export DLC=/psc/dlc

export PATH=$DLC/bin:$PATH

sudo mkdir -p /artifacts
sudo chmod 777 /artifacts

rm -rf /artifacts/sports-app/${Version}/

mkdir -p /artifacts/sports-app/${Version}/webspeed/
export PROPATH=src/webspeed

mpro -b -db sports2020 -S 20000 -p `pwd`/src/compile.p -param src=src/webspeed,target=/artifacts/sports-app/${Version}/webspeed/ > /tmp/output.$$.txt
cat /tmp/output.$$.txt

mkdir -p /artifacts/sports-app/${Version}/webui/
cp src/webui/*.html src/webui/*.js /artifacts/sports-app/${Version}/webui/

mkdir -p /artifacts/sports-app/${Version}/conf/
cp app/pas/* /artifacts/sports-app/${Version}/conf/
cp app/web/default app/web/nginx.conf /artifacts/sports-app/${Version}/conf/

mkdir -p /artifacts/sports-app/${Version}/scripts/
cp app/deploy.sh /artifacts/sports-app/${Version}/scripts/

mkdir -p /artifacts/sports-app/${Version}/db/
cp app/db/* /artifacts/sports-app/${Version}/db/

rm -rf /artifacts/db/
mkdir -p /artifacts/db/
cd /artifacts/db/
prodb sports2020 sports2020
prostrct add sports2020 /artifacts/sports-app/${Version}/db/addai.st
rfutil sports2020 -C mark backedup -G 0
rfutil sports2020 -C aimage begin -G 0
proutil sports2020 -C enablesitereplication source
probkup sports2020 sports2020_backup

cp sports2020_backup /artifacts/sports-app/${Version}/db/


# Build package app.tar.gz
cd /artifacts/sports-app/${Version}/
mkdir app app/web/ app/pas/ app/db/
cp $DLC/progress.cfg app/
cp scripts/deploy.sh app/
cp -r webui/* app/web/
cp -r webspeed/* app/pas/
cp -r conf/* app/pas/
cp -r conf/default app/web/
cp -r conf/nginx.conf app/web/

cp -r db/* app/db/
cp -r /artifacts/db/sports2020_backup /artifacts/sports-app/${Version}/db/

#
tar cvzf web.tar.gz app/deploy.sh app/web/
tar cvzf pas.tar.gz app/deploy.sh app/progress.cfg app/pas/
tar cvzf db.tar.gz  app/deploy.sh app/progress.cfg app/db/
#
