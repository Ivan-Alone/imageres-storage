#!/bin/bash


# root access checking

if [[ $USER != 'root' ]]
then
	echo 'Run installer as root!'
	exit
fi


# Full system upgrade

apt update && apt upgrade -y && apt install -y unzip software-properties-common


# Configuring PHP repository

if [[ "$(uname -v | grep Debian)" != '' ]]
then
	apt -y install lsb-release apt-transport-https ca-certificates 
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
else
	apt -y install software-properties-common
	add-apt-repository -y ppa:ondrej/php
fi

apt update


# Installing server software 
apt install -y sudo p7zip-full htop apache2 mariadb-client mariadb-server php7.4 php7.4-gettext php7.4-mysqli php7.4-pdo-mysql php7.4-fileinfo php7.4-ftp php7.4-curl php7.4-gd php7.4-mbstring php7.4-exif php7.4-sockets php7.4-xsl php7.4-xml php7.4-xmlrpc certbot python-certbot-apache gcc g++ make
apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt install -y nodejs
apt install -y xvfb
apt install -y x11-xkb-utils
apt install -y xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic
apt install -y xserver-xorg-core
ln -s /etc/apache2 /etc/httpd
ln -s /etc/apache2/apache2.conf /etc/apache2/httpd.conf
a2enmod proxy rewrite proxy_http ssl
apachectl restart


# Mouse in terminal

apt install -y gpm


# Install Scout Realtime

apt install -y ruby 
gem install scout_realtime 


# Install Java & JDK 8

wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
apt update && apt install -y adoptopenjdk-8-hotspot


# Install LogMeIn Hamachi

wget https://github.com/Ivan-Alone/imageres-storage/raw/master/logmein-hamachi_2.1.0.203-1_amd64.deb
dpkg -i logmein-hamachi_2.1.0.203-1_amd64.deb
rm -rf logmein-hamachi_2.1.0.203-1_amd64.deb

hamachi login

