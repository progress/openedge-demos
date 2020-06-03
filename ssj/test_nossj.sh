#!/bin/bash

SCRIPTS=`dirname $0`

proshut sports2020 -by
proserve sports2020 -S 20000 -ssj 0

if [ "$1" == "--with-logging" ]
then
  rm client.log
  mpro sports2020 -S 20000 -p $SCRIPTS/ssj.p \
       -clientlog client.log -logentrytypes QryInfo -logginglevel 3
  cut -c50- client.log
else
  mpro sports2020 -S 20000 -p $SCRIPTS/ssj.p
fi

cp report.txt report_nossj.txt
