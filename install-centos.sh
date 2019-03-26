#!/bin/bash
#
# Copyright (c) 2018, Nimbix, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# The views and conclusions contained in the software and documentation are
# those of the authors and should not be interpreted as representing official
# policies, either expressed or implied, of Nimbix, Inc.
#

set -x
set -e

while getopts "b:p" opt; do
    case ${opt} in
        b)
            BRANCH="${OPTARG}"
            ;;
        p)
            PYTHON="3"
            ;;
        *)
            echo "usage: $0 [-b <branch>] [-p <notebook-port>]" >&2
            echo "  use -b to specify notebook common branch" >&2
            echo "  use -p to specify to use python3" >&2
            exit 1
            ;;
    esac
done

#yum update -y
yum groupinstall -y "Development Tools"
yum install -y wget curl python-devel zeromq-devel
yum install -y epel-release
yum makecache

# Python 3, must choose python 3.4 or 3.6, defaulting here to 3.6
if [[ "${PYTHON}" = "3" ]]; then
    yum install -y python36-pip
    python36 -m pip install --upgrade pip setuptools
    pip3 install --upgrade packaging appdirs jupyter
else
    yum install -y python2-pip
    python -m pip install --upgrade pip setuptools
    pip install packaging appdirs jupyter
fi
yum clean all

# Install redir
REDIR_VERSION="v2.2.1"
mkdir /tmp/build-redir
cd /tmp/build-redir
wget https://github.com/troglobit/redir/archive/${REDIR_VERSION}.tar.gz
tar -xf *.tar.gz
cd redir*
make all
cp redir /usr/bin
chmod 04555 /usr/bin/redir
cd
rm -rf /tmp/build-redir
yum groupremove -y "Development Tools"

[[ -z ${BRANCH} ]] && BRANCH="master"

cd /usr/local/bin
curl -H 'Cache-Control: no-cache' -O https://raw.githubusercontent.com/nimbix/notebook-common/${BRANCH}/nimbix_notebook
chmod 555 /usr/local/bin/nimbix_notebook

mkdir -p /etc/NAE
echo "https://%PUBLICADDR%/?token=%RANDOM64%" >/etc/NAE/url.txt

