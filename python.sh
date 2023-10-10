#!/bin/bash

sudo apt-get update
sudo apt-get install gdebi-core -y

PYTHON_VERSION="3.11.3"

curl -O https://cdn.rstudio.com/python/ubuntu-2204/pkgs/python-${PYTHON_VERSION}_1_amd64.deb
sudo gdebi -n python-${PYTHON_VERSION}_1_amd64.deb -y

/opt/python/"${PYTHON_VERSION}"/bin/pip install --upgrade \
    pip setuptools wheel

echo 'PATH=/opt/python/"${PYTHON_VERSION}"/bin:$PATH' > /etc/profile.d/python.sh

rm -rf python-${PYTHON_VERSION}_1_amd64.deb
