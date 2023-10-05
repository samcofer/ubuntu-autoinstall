#!/bin/bash

sed -i s]10.10.10.81/24]"$(for i in {61..69}; do ip="10.10.10.$i"; ping -c 1 -W 1 $ip &>/dev/null ||  { echo "$ip/24"; break; }; done)"]g /etc/netplan/00-installer-config.yaml

netplan apply