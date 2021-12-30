#!/bin/bash

export DLC=/psc/dlc
export PATH=$DLC/bin:$PATH

cd /psc/wrk
mkdir -p aiArchives
prorest sports2020 /install/app/db/sports2020_backup
prorest sports2020 /install/app/db/sports2020_backup_incremental
prostrct add sports2020 /install/app/db/addai.st
rfutil sports2020 -C aimage begin
rfutil sports2020 -C aiarchiver enable
proutil sports2020 -C enableSiteReplication target
proserve sports2020 -DBService replagent -S 20000 -aiarcdir aiArchives
