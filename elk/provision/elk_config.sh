#!/bin/bash

# set the installation to be non-interactive
export DEBIAN_FRONTEND="noninteractive"



# ElasticSearch - copy over config, restart
cp -R /vagrant/elastic/elasticsearch/* /etc/elasticsearch/
service elasticsearch restart 2>&1



# Logstash - copy over config files, test, restart
cp -R /vagrant/elastic/logstash/* /etc/logstash/conf.d/
service logstash configtest
service logstash restart 2>&1



# Filebeat - copy over config files, restart
cp -R /vagrant/elastic/filebeat/* /etc/filebeat/
service filebeat restart 2>&1



# Kibana - copy over config, restart
cp -R /vagrant/elastic/kibana/* /opt/kibana/config/
service kibana restart

# give Kibana a time to initialize
sleep 30s

# create the filebeat index
curl -XPUT http://127.0.0.1:9200/.kibana/index-pattern/filebeat-* \
    -d '{"title" : "filebeat-*",  "timeFieldName": "@timestamp"}' -s
	
# configure the default index to filebeat
curl -XPUT http://127.0.0.1:9200/.kibana/config/4.6.3 \
    -d '{"defaultIndex" : "filebeat-*"}' -s
    
# give Elasticsearch some time to ingest Filebeat data
sleep 120s

# prime the index
curl 'http://127.0.0.1:5601/elasticsearch/.kibana/index-pattern/filebeat-*' -s

# print the status
curl -s http://127.0.01:9200/_cluster/health?pretty