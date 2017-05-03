#!/bin/bash

set -x
set -e

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install nginx sudo curl libzmq-dev
if [ "$1" = "3" ]; then
    apt-get -y install python3-pip
    pip3 install --upgrade pip
    pip3 install --upgrade packaging appdirs notebook
else
    apt-get -y install python-pip
    pip install --upgrade pip
    pip install --upgrade packaging appdirs notebook
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

mkdir -p /etc/NAE
echo "https://%PUBLICADDR%/" >/etc/NAE/url.txt

# for JARVICE emulation
mkdir -p /etc/JARVICE && cd /etc/JARVICE
curl -H 'Cache-Control: no-cache' -O https://raw.githubusercontent.com/nimbix/notebook-common/master/conf/htpasswd

