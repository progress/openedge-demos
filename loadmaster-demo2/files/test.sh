#!/bin/bash

while true
do
  count=`curl -s http://10.0.0.126:8810/web/customer.p | jq '.dsCustomer.ttCustomer | length'`
  case $count in
  22) echo "Blue Env is Active"
  ;;
  1117) echo "Green Env is Active"
  ;;
  esac
  sleep 5
done
