#!/bin/bash
# @see https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elk-stack-on-ubuntu-14-04
# @see https://qbox.io/blog/qbox-a-vagrant-virtual-machine-for-elasticsearch-2-x
# @see https://github.com/Asquera/elk-example
# @see https://github.com/bhaskarvk/vagrant-elk-cluster

# set the installation to be non-interactive
export DEBIAN_FRONTEND="noninteractive"

# update aptitude
apt-get update
apt-get install -y ruby2.0=2.0.0.484-1ubuntu2.2 unzip





# install the Elastic PGP Key
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -





# Install Elasticsearch
# @see https://www.elastic.co/guide/en/elasticsearch/reference/2.4/setup-repositories.html
echo "[INFO] Installing Elasticsearch..."

# install Java
apt-get purge openjdk*
apt-get -y install openjdk-7-jdk

# install Elasticsearch
echo 'deb http://packages.elastic.co/elasticsearch/2.x/debian stable main' | tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
apt-get update
apt-get install -y elasticsearch=2.4.3
service elasticsearch start
update-rc.d elasticsearch defaults 95 10





# install Logstash
# @see https://www.elastic.co/guide/en/logstash/2.4/installing-logstash.html
echo "[INFO] Installing Logstash..."
echo 'deb http://packages.elastic.co/logstash/2.4/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash-2.2.x.list
apt-get update
apt-get install -y logstash=1:2.4.1-1
service logstash start
update-rc.d logstash defaults 96 9





# Install Kibana
# @see https://www.elastic.co/guide/en/kibana/4.6/setup-repositories.html
echo "[INFO] Installing Kibana..."
echo 'deb http://packages.elastic.co/kibana/4.6/debian stable main' | sudo tee -a /etc/apt/sources.list.d/kibana-4.6.x.list
# echo 'deb http://packages.elastic.co/kibana/3.0/debian stable main' | sudo tee -a /etc/apt/sources.list.d/kibana-3.0.x.list
apt-get update
apt-get install -y kibana=4.6.3
# apt-get install -y kibana=3.1.3
service kibana start
update-rc.d kibana defaults 96 9





# Install Filebeat
# @see https://www.elastic.co/guide/en/beats/libbeat/1.3/setup-repositories.html
echo "deb https://packages.elastic.co/beats/apt stable main" |  sudo tee -a /etc/apt/sources.list.d/beats.list
apt-get update
apt-get install -y filebeat=1.3.1
service filebeat start
update-rc.d filebeat defaults 95 10
mkdir -p /var/log/filebeat
# curl -XGET 'http://localhost:9200/filebeat-*/_search?pretty'





# install the Beats dashboard
# https://github.com/elastic/beats-dashboards/releases 1.3.1
cd ~
curl -L -O -s https://download.elastic.co/beats/dashboards/beats-dashboards-1.3.1.zip
unzip -q beats-dashboards-*.zip
cd beats-dashboards-*
./load.sh -url "http://localhost:9200" > /dev/null 2>&1

# install the Filebeat template
cd ~
curl -O -s https://gist.githubusercontent.com/thisismitch/3429023e8438cc25b86c/raw/d8c479e2a1adcea8b1fe86570e42abab0f10f364/filebeat-index-template.json
curl -XPUT -s 'http://localhost:9200/_template/filebeat?pretty' -d@filebeat-index-template.json
# verify the output is {"acknowledged" : true}










# update the file search
updatedb
