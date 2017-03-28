# aws-athena demo

This is osquery, with logstash and filebeat, shipping into AWS Athena.


## Install

```shell
git clone <repo_url>
cd osquery-demo/aws-athena/ubuntu16
vagrant up 
vagrant ssh
```


## Links

https://www.elastic.co/guide/en/logstash/current/plugins-outputs-s3.html


## Logs

```shell
/var/log/osquery/osqueryd.WARNING
/var/log/osquery/osqueryd.INFO
/var/log/osquery/osqueryd.results.log
cat /var/log/osquery/osqueryd.results.log | jq '.'

# filebeat
/var/log/filebeat/filebeat.log

# logstash
/var/log/logstash/logstash.log
/var/log/logstash/logstash.stdout
/var/log/logstash/logstash.err
```