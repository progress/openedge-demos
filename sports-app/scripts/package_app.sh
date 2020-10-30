#!/bin/bash

cd /install
cp -r /artifacts/sports-app/webui/* app/web/
cp -r /artifacts/sports-app/webspeed/* app/pas/
tar czvf app.tar.gz app
