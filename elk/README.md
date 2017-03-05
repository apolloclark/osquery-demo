# osquery-demo elk

This is osquery, with an ElasticSearch, Logstash, Kibana ELK dashboard.


## Install

```shell
git clone <repo_url>
cd osquery-demo/standalone
vagrant up ubuntu14
vagrant ssh ubuntu14

# view ELK dashboard:
# http://127.0.0.1:5601/app/kibana

# in the search bar, enter:
type: "osquery_json"

# to see only updated files, enter:
name:"file_events" AND columns.action:"UPDATED"

# https://www.timroes.de/2016/05/29/elasticsearch-kibana-queries-in-depth-tutorial/
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

# list indexes
/_cat/indices?v


# search
GET /_search



# list Kibana settings
GET /.kibana?pretty

# list Kibana config
GET /.kibana/config/4.6.3?pretty

# check Kibana index-pattern is set to Filebeat
GET /.kibana/index-pattern/filebeat-*

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