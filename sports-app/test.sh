#/bin/sh

exec >&2

HostName=${1-localhost}
AppURL=/web

echo Testing application on server \"$HostName\" ...

for i in index.html main.html menu.html
do
    echo "Testing: $i ..."
    curl -s http://$HostName/$i > /tmp/output.$$.html
    diff test/output/$i /tmp/output.$$.html
    if [ $? -eq 0 ]; then echo "Test: PASSED"; else echo "Test: FAILED"; fi
    rm /tmp/output.$$.html
done

echo "Testing: customer-data.p ..."
curl -s http://$HostName$AppURL/customer-data.p | json_reformat > /dev/null
if [ $? -eq 0 ]; then echo "Test: PASSED"; else echo "Test: FAILED"; fi

echo "Testing: customer-data.p ..."
curl -s http://$HostName$AppURL/customer-data.p | json_reformat > /dev/null
if [ $? -eq 0 ]; then echo "Test: PASSED"; else echo "Test: FAILED"; fi

echo "Testing: state-data.p ..."
curl -s http://$HostName$AppURL/state-data.p | json_reformat > /dev/null
if [ $? -eq 0 ]; then echo "Test: PASSED"; else echo "Test: FAILED"; fi

for i in about.html customer-view.html state-view.html
do
    echo "Testing: $i ..."
    curl -s http://$HostName$AppURL/$i > /tmp/output.$$.html
    diff test/output/$i /tmp/output.$$.html
    if [ $? -eq 0 ]; then echo "Test: PASSED"; else echo "Test: FAILED"; fi
    rm /tmp/output.$$.html
done
