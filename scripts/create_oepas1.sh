#!/bin/bash

# set -x

if [ ! -d /psc/wrk/oepas1 ]
then
  echo "Creating PASOE instance (oepas1)..."
  export DLC=/psc/dlc
  export PATH=$DLC/bin:$PATH

  if [ -f /files/oepas1.tar.gz ]
  then
    cd /
    tar xzf /files/oepas1.tar.gz
    cp /vagrant/files/openedge.properties /psc/wrk/oepas1/conf
  else
    cd /psc/wrk
    time pasman create -v oepas1
    cp /vagrant/files/openedge.properties /psc/wrk/oepas1/conf
    cp /vagrant/files/customer.p /psc/wrk/oepas1/openedge
    cd /
    tar czf /files/oepas1.tar.gz psc/dlc/servers/pasoe/conf/instances.unix psc/wrk/oepas1
  fi

  cd /psc/wrk
  ./oepas1/bin/tcman.sh pasoestart -restart
fi
