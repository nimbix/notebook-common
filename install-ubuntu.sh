#!/bin/bash

set -x
set -e

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install python3-pip nginx sudo curl && apt-get clean
pip3 install --upgrade pip
pip3 install --upgrade notebook

cd /etc/nginx/sites-enabled
curl -H 'Cache-Control: no-cache' -O https://raw.githubusercontent.com/nimbix/notebook-common/master/conf/default
curl -H 'Cache-Control: no-cache' -O https://raw.githubusercontent.com/nimbix/notebook-common/master/conf/notebook-site
cd /etc/nginx/conf.d
curl -H 'Cache-Control: no-cache' -O https://raw.githubusercontent.com/nimbix/notebook-common/master/conf/httpredirect.conf
cd /usr/local/bin
curl -H 'Cache-Control: no-cache' -O https://raw.githubusercontent.com/nimbix/notebook-common/master/nimbix_notebook
chmod 555 /usr/local/bin/nimbix_notebook


