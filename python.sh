#!/bin/bash

sudo apt-get update
sudo apt-get install gdebi-core -y

PYTHON_VERSION="3.11.3"

curl -O https://cdn.rstudio.com/python/ubuntu-2204/pkgs/python-${PYTHON_VERSION}_1_amd64.deb
sudo gdebi -n python-${PYTHON_VERSION}_1_amd64.deb

/opt/python/"${PYTHON_VERSION}"/bin/pip install --upgrade \
    pip setuptools wheel

echo "export PATH=/opt/python/${PYTHON_VERSION}/bin:\$PATH" > /etc/profile.d/python.sh

rm -rf python-${PYTHON_VERSION}_1_amd64.deb

# Ansible python pre-config

# Automate the creation of a python venv for ansible user
if [ "$(whoami)" != "ansible" ]; then
cat <<EOT >> /etc/profile.d/python.sh
DIRECTORY=~/.venv
if [ ! -d "$DIRECTORY" ]; then
  python -m venv ~/.venv
  source ~/.venv/bin/activate
  pip install --upgrade pip setuptools wheel
  pip install ansible
fi
echo "source ~/.venv/bin/activate" >> ~/.bashrc
EOT
fi