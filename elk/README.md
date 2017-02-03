# osquery-dem elk

This is osquery, with an ELK dashboard.


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