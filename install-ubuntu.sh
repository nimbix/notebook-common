#!/bin/bash

set -x
set -e

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install python-pip nginx sudo curl && apt-get clean
pip install --upgrade notebook

cd /etc/nginx/sites-enabled
curl -O https://raw.githubusercontent.com/nimbix/notebook-common/master/conf/default
curl -O https://github.com/nimbix/notebook-common/blob/master/conf/notebook-site
cd /etc/nginx/conf.d
curl -O https://raw.githubusercontent.com/nimbix/notebook-common/master/conf/httpredirect.conf
cd /usr/local/bin
curl -O https://raw.githubusercontent.com/nimbix/notebook-common/master/nimbix_notebook
chmod 555 /usr/local/bin/nimbix_notebook


