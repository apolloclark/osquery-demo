#!/bin/bash
# @see https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elk-stack-on-ubuntu-14-04
# @see https://qbox.io/blog/qbox-a-vagrant-virtual-machine-for-elasticsearch-2-x
# @see https://github.com/Asquera/elk-example
# @see https://github.com/bhaskarvk/vagrant-elk-cluster

# set the installation to be non-interactive
export DEBIAN_FRONTEND="noninteractive"

# update aptitude
apt-get update
apt-get install -y unzip git

# enable colored Bash prompt
cp /vagrant/bashrc /root/.bashrc
cp /vagrant/bashrc /home/vagrant/.bashrc

# enable more robust Nano syntax highlighting
git clone https://github.com/scopatz/nanorc.git /root/.nano
cat /root/.nano/nanorc >> /root/.nanorc

git clone https://github.com/scopatz/nanorc.git /home/vagrant/.nano
cat /home/vagrant/.nano/nanorc >> /home/vagrant/.nanorc





# install Java
apt-get purge openjdk*
add-apt-repository ppa:openjdk-r/ppa 2>&1
apt-get update
apt-get install -y openjdk-8-jre

# install the Elastic PGP Key and repo
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo 'deb https://artifacts.elastic.co/packages/5.x/apt stable main' | \
	tee -a /etc/apt/sources.list.d/elastic-5.x.list
apt-get update





# install Logstash
# @see https://www.elastic.co/guide/en/logstash/current/releasenotes.html
# @see https://www.elastic.co/guide/en/logstash/5.2/installing-logstash.html
echo "[INFO] Installing Logstash..."
apt-get install -y logstash=1:5.2.2-1
systemctl start logstash.service 2>&1

# install the logstash-input-beats plugin
/usr/share/logstash/bin/logstash-plugin install logstash-input-beats





# Install Filebeat
# @see https://www.elastic.co/guide/en/beats/libbeat/5.2/setup-repositories.html
echo "[INFO] Installing Filbeat..."
apt-get install -y filebeat=5.2.2
systemctl start filebeat.service 2>&1
mkdir -p /var/log/filebeat





# clear any unneeded dependencies
apt-get -y autoremove

# update the file search
updatedb
