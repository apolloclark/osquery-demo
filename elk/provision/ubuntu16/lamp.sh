#!/bin/bash

# set the session to be noninteractive
export DEBIAN_FRONTEND="noninteractive"





## Install PHP, and plugins
echo "INFO: Install PHP..."

# https://secure.php.net/ChangeLog-5.php
apt-get install -y python-software-properties language-pack-en-base
LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php
apt-get update

apt-get -qq install -y --force-yes php5.6 php5.6-gd php5.6-mcrypt \
    php5.6-mysql libapache2-mod-php5.6 \
    php-pear &>/dev/null

# check php version
php -v
