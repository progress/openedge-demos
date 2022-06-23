#!/bin/bash

function exit_on_failed_test () {
  tput setaf 1
  echo $_
  echo Test failed. Exiting.
  tput sgr0
  exit
}

GREEN=`tput setaf 2`
RESET=`tput sgr0`

# set -v
if [ ! -f /usr/bin/jq ]
then
  sudo apt-get update
  sudo apt-get -y install jq
fi
curl -sk https://localhost:8811 > /dev/null && echo "${GREEN}PASOE is running${RESET}" || exit_on_failed_test
COUNT=`curl -sk https://localhost:8811/Sports/rest/SportsService/Customer | jq '.dsCustomer.ttCustomer | length'`
test $COUNT -eq 1117 && echo "${GREEN}GET Customer returns 1117 records${RESET}" || exit_on_failed_test
curl -s http://localhost:8080 > /dev/null && echo "${GREEN}NGINX is running${RESET}" || exit_on_failed_test
curl -s http://localhost:9200 > /dev/null && echo "${GREEN}Elasticsearch is running${RESET}" || exit_on_failed_test
curl -s http://localhost:5601 > /dev/null && echo "${GREEN}Kibana is running${RESET}" || exit_on_failed_test
