#!/bin/bash


for i in {61..69}; do ip="10.10.10.$i"; ping -c 1 -W 1 $ip &>/dev/null ||  { export MYIP="$ip/24"; break; }; done
echo $MYIP
cat /etc/netplan/00-installer-config.yaml
cp /etc/netplan/00-installer-config.yaml /etc/netplan/01-custom-config.yaml
sed -i "s=10.10.10.71/24=$MYIP=g" /etc/netplan/01-custom-config.yaml
cat /etc/netplan/01-custom-config.yaml
netplan apply