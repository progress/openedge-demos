#!/bin/bash

# set -x

if [ ! -d /psc/wrk/oepas1 ]
then
  echo "Creating PASOE instance (oepas1)..."
  export DLC=/psc/dlc
  export PATH=$DLC/bin:$PATH
  cd /psc/wrk
  if [ -f /files/oepas1.tar.gz ]
  then
    tar xzvf /files/oepas1.tar.gz
  else
    pasman create -v oepas1
    cp /vagrant/files/openedge.properties /psc/wrk/oepas1/conf
    cp /vagrant/files/customer.p /psc/wrk/oepas1/openedge
  fi
  ./oepas1/bin/tcman.sh pasoestart -restart
fi
