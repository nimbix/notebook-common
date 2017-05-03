#!/bin/bash

set -x
set -e

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install nginx sudo curl libzmq-dev
if [ "$1" = "3" ]; then
    apt-get -y install python3-pip
    pip3 install --upgrade pip
    pip3 install --upgrade notebook
else
    apt-get -y install python-pip
    pip install --upgrade pip
    pip install --upgrade notebook
fi
apt-get clean

cd /etc/nginx/sites-enabled
curl -H 'Cache-Control: no-cache' -O https://raw.githubusercontent.com/nimbix/notebook-common/master/conf/default
curl -H 'Cache-Control: no-cache' -O https://raw.githubusercontent.com/nimbix/notebook-common/master/conf/notebook-site
cd /etc/nginx/conf.d
curl -H 'Cache-Control: no-cache' -O https://raw.githubusercontent.com/nimbix/notebook-common/master/conf/httpredirect.conf
cd /usr/local/bin
curl -H 'Cache-Control: no-cache' -O https://raw.githubusercontent.com/nimbix/notebook-common/master/nimbix_notebook
chmod 555 /usr/local/bin/nimbix_notebook

echo "https://%PUBLICADDR%/" >/etc/NAE/url.txt
