#!/bin/bash
apt update
apt upgrade 
apt install wget nano 
echo $(curl ifconfig.me 2>/dev/null) $(hostname) >> /etc/hosts
cp /home/debian/.bashrc /root/
wget https://github.com/z3APA3A/3proxy/releases/download/0.9.3/3proxy-0.9.3.x86_64.deb
dpkg install 3proxy-0.9.3.x86_64.deb
rm 3proxy-0.9.3.x86_64.deb
wget https://raw.githubusercontent.com/Ivan-Alone/imageres-storage/master/3proxy.cfg
mv 3proxy.cfg /etc/3proxy/
systemctl restart 3proxy
ip addr
