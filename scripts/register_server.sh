#!/bin/bash

exec > /tmp/log.txt 2>&1
set -x
# echo "DEBUG: $1 $2 $3"
LM_IP_ADDRESS=$1
IP_ADDRESS=$2
LM_APIKEY=`cat /files/lm_apikey.txt`

function register_server_subvs ()
{
  cat > /tmp/$$.tmp << EOT
  {
    "apikey": "${LM_APIKEY}",
    "cmd": "listvs"
  }
EOT

  SUBVS=`curl -s -k -d @/tmp/$$.tmp https://${LM_IP_ADDRESS}/accessv2 | jq -r ".VS[] | select(.NickName == \"${LM_SUBVS}\") | .Index"`

  for subvs in $SUBVS
  do
    cat > /tmp/$$.tmp << EOT
  {
    "apikey": "${LM_APIKEY}",
    "cmd": "addrs",
    "vs": "${subvs}",
    "port": "8810",
    "subvs": "1",
    "rs": "${IP_ADDRESS}",
    "rsport": "8810",
    "prot": "tcp",
    "non_local": "1"
  }
EOT
    curl -s -k -d @/tmp/$$.tmp https://${LM_IP_ADDRESS}/accessv2
  done
}

LM_SUBVS=$3
register_server_subvs

LM_SUBVS=$3-Testing
register_server_subvs
