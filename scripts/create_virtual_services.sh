#!/bin/bash

exec >/tmp/log.txt 2>&1

set -x
# echo "DEBUG: $1 $2 $3"
LM_IP_ADDRESS=${1-10.0.0.226}
IP_ADDRESS=$2
LM_SUBVS=$3
LM_APIKEY=`cat /files/lm_apikey.txt`

curl -sk -X POST --data-binary "@/vagrant/files/pasoe-production.tmpl" https://${LM_IP_ADDRESS}/access/uploadtemplate?apikey=${LM_APIKEY}
curl -sk -X POST --data-binary "@/vagrant/files/pasoe-staging.tmpl" https://${LM_IP_ADDRESS}/access/uploadtemplate?apikey=${LM_APIKEY}

cat > /tmp/$$.tmp << EOT
{
  "apikey": "${LM_APIKEY}",
  "cmd": "addvs",
  "vs": "${LM_IP_ADDRESS}",
  "port": "8810",
  "prot": "tcp",
  "template": "PASOE-Production"
}
EOT
curl -sk -d @/tmp/$$.tmp https://${LM_IP_ADDRESS}/accessv2

cat > /tmp/$$.tmp << EOT
{
  "apikey": "${LM_APIKEY}",
  "cmd": "addvs",
  "vs": "${LM_IP_ADDRESS}",
  "port": "8820",
  "prot": "tcp",
  "template": "PASOE-Staging"
}
EOT
curl -sk -d @/tmp/$$.tmp https://${LM_IP_ADDRESS}/accessv2

cat > /tmp/$$.tmp << EOT
{
  "apikey": "${LM_APIKEY}",
  "cmd": "modvs",
  "vs": "${LM_IP_ADDRESS}",
  "port": "8810",
  "prot": "tcp",
  "Enable": true
}
EOT
curl -sk -d @/tmp/$$.tmp https://${LM_IP_ADDRESS}/accessv2

cat > /tmp/$$.tmp << EOT
{
  "apikey": "${LM_APIKEY}",
  "cmd": "modvs",
  "vs": "${LM_IP_ADDRESS}",
  "port": "8820",
  "prot": "tcp",
  "Enable": true
}
EOT
curl -sk -d @/tmp/$$.tmp https://${LM_IP_ADDRESS}/accessv2

rm /tmp/$$.tmp

