#!/bin/bash

# set the installation to be non-interactive
export DEBIAN_FRONTEND="noninteractive"



# ElasticSearch - copy over config, restart
cp -R /vagrant/provision/$OS_VER/elasticsearch/* /etc/elasticsearch/
service elasticsearch restart



# Logstash - copy over config files, test, restart
cp -R /vagrant/provision/$OS_VER/logstash/* /etc/logstash/conf.d/
service logstash configtest
service logstash restart



# Kibana - copy over config, restart
cp -R /vagrant/provision/$OS_VER/kibana/* /opt/kibana/config/
service kibana restart



# Filebeat - copy over config files, restart
cp -R /vagrant/provision/$OS_VER/filebeat/* /etc/filebeat/
service filebeat restart 2>&1
