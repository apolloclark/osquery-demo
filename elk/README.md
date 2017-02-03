# osquery-demo elk

This is osquery, with an ElasticSearch, Logstash, Kibana ELK dashboard.


## Install

```shell
git clone <repo_url>
cd osquery-demo/standalone
vagrant up ubuntu14
vagrant ssh ubuntu14

# configure ELK dashboard

# go to the Discover table, type this in the search bar:
# https://www.timroes.de/2016/05/29/elasticsearch-kibana-queries-in-depth-tutorial/
type: "osquery_json"

name:"file_events" AND columns.action:"UPDATED"
```



## ElasticSearch end-points
```shell
# http://elasticsearch-cheatsheet.jolicode.com/

# list health
/_cluster/health?pretty

# list state
/_cluster/state?pretty

# list nodes
/_nodes?pretty

# list node state
/_nodes/stats?pretty

# search
GET /_search
```


## Logs

```shell
/var/log/osquery/osqueryd.WARNING
/var/log/osquery/osqueryd.INFO
nano /var/log/osquery/osqueryd.results.log
cat /var/log/osquery/osqueryd.results.log | jq '.'

# filebeat
/var/log/filebeat/filebeat.log

# logstash
/var/log/logstash/logstash.log
/var/log/logstash/logstash.stdout
/var/log/logstash/logstash.err

# elasticsearch
/var/log/elasticsearch/elasticsearch.log
/var/log/elasticsearch/elasticsearch_index_search_slowlog.log
/var/log/elasticsearch/elasticsearch_index_search_slowlog.log
/var/log/elasticsearch/elasticsearch_deprecation.log

# kibana
/var/log/kibana/kibana.stdout
/var/log/kibana/kibana.stderr
```