#!/bin/bash
apt update
apt -y upgrade
apt -y install wget nano php php-curl php-mbstring php-curl php-gd php-mysqli php-fileinfo php-sockets php-exif php-xml

external_ip=$(curl ifconfig.me 2>/dev/null)

echo $external_ip $(hostname) >> /etc/hosts

# Adding .bashrc for root
users=$(ls -1d /home/*)
IFS=$'\n' read -rd '' -a default_user <<<"$users"
cp /home/$default_user/.bashrc /root/

# Installing 3proxy
wget https://github.com/z3APA3A/3proxy/releases/download/0.9.3/3proxy-0.9.3.x86_64.deb
dpkg -i 3proxy-0.9.3.x86_64.deb
rm 3proxy-0.9.3.x86_64.deb

# Making transparent proxy config
wget https://raw.githubusercontent.com/Ivan-Alone/imageres-storage/master/3proxy.cfg

read -p "Enter Proxy Username (default \"user\" if empty): " user
read -p "Enter Proxy Username (default \"password\" if empty): " pass

if [[ -z "$user" ]]; then user="user"; fi
if [[ -z "$pass" ]]; then pass="password"; fi

cfg=$(cat 3proxy.cfg)
cfg="${cfg//%USER%/"$user"}"
cfg="${cfg//%PASSWORD%/"$pass"}"

echo "$cfg" > 3proxy.cfg

mv 3proxy.cfg /etc/3proxy/

systemctl restart 3proxy

# Debug report
echo
ip addr
echo
echo "HTTP(s) Proxy: "$user":"$pass"@"$external_ip":23230"
echo "Socks5 Proxy must be running on socks5://"$user":"$pass"@"$external_ip":23232"
