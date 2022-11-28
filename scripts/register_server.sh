#!/bin/bash

# echo "DEBUG: $1 $2 $3"
LM_IP_ADDRESS=$1
IP_ADDRESS=$2
LM_SUBVS=$3
LM_APIKEY=`cat /files/lm_apikey.txt`

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
  curl -s -k -d @/tmp/$$.tmp https://${LM_IP_ADDRESS}/accessv2 > /dev/null

done
