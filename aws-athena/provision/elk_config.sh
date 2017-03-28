#!/bin/bash

# set the installation to be non-interactive
export DEBIAN_FRONTEND="noninteractive"





# Logstash - copy over config files, test, restart
cp -R /vagrant/elastic/logstash/* /etc/logstash/conf.d/
systemctl restart logstash.service 2>&1



# Filebeat - copy over config files, restart
# https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-configuration.html
cp -R /vagrant/elastic/filebeat/* /etc/filebeat/
systemctl restart filebeat.service 2>&1
