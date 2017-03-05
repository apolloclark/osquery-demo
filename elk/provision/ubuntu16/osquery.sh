#!/bin/bash

# set the session to be noninteractive
export DEBIAN_FRONTEND="noninteractive"



# install system tools
apt-get update
apt-get install -y jq git

# enable colored Bash prompt
cp /vagrant/.bashrc /root/.bashrc
cp /vagrant/.bashrc /home/vagrant/.bashrc

# enable more robust Nano syntax highlighting
git clone https://github.com/scopatz/nanorc.git /root/.nano
cat /root/.nano/nanorc >> /root/.nanorc
git clone https://github.com/scopatz/nanorc.git /home/vagrant/.nano
cat /home/vagrant/.nano/nanorc >> /home/vagrant/.nanorc





# install the Facebook osquery repo
apt-key adv --keyserver keyserver.ubuntu.com \
    --recv-keys 1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B 2>&1
add-apt-repository "deb [arch=amd64] https://osquery-packages.s3.amazonaws.com/xenial xenial main"
apt-get update

# install osquery
apt-get install -y osquery
osqueryd --version

# configure osquery
cp /vagrant/osquery/osquery.conf /etc/osquery/osquery.conf
service osqueryd restart
service osqueryd status

# configure the inode file listeners
cp /vagrant/osquery/sysctl.conf /etc/sysctl.conf
sysctl -p



# clean up apt-get
apt-get -y autoremove

# update file location database
updatedb
