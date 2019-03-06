# osquery-demo

This is an osquery Vagrant demo.

You can find a tutorial here:
https://www.sitepoint.com/osquery-explore-os-sql/#5-using-osquery



## Install

```shell
git clone <repo_url>
cd osquery-demo/standalone
vagrant up ubuntu16
vagrant ssh ubuntu16
```



## Usage

```shell
# run a query, output as json
osqueryi --json "select * from routes"

# run a query, output as csv
osqueryi --csv --separator ',' "select * from routes"

# run the interactive console
osqueryi

# verify the config file is valid
osqueryd --config_check /vagrant/provision/osquery.conf



# install a LAMP stack
sudo /vagrant/provision/ubuntu14-lamp.sh



# test the file integrity monitoring (FIM)
# you cannot use the osqueryi interactive shell
# https://github.com/facebook/osquery/issues/2826#issuecomment-268798859
cur_datetime=$(date +"%Y-%m-%d_%H-%M-%S");
cur_timestamp=$(date +"%s");
touch /tmp/test.txt
chmod 0777 /tmp/test.txt
echo "current time = $cur_datetime" >> /tmp/test.txt
cat /tmp/test.txt
cat /var/log/osquery/osqueryd.results.log | grep 'test.txt' | jq '.'
cat /var/log/osquery/osqueryd.results.log | grep 'test.txt' | jq '.' | grep 'md5'
    OR
watch -n 1 "cat /var/log/osquery/osqueryd.results.log | grep 'test.txt' | jq '.' | tail -n 32"
    OR
osqueryi --json "SELECT * from hash where path = '/tmp/test.txt'" | jq '.'
```



## Logs

```shell
/var/log/osquery/osqueryd.WARNING
/var/log/osquery/osqueryd.INFO
nano /var/log/osquery/osqueryd.results.log
cat /var/log/osquery/osqueryd.results.log | jq '.'
```



## Queries
https://osquery.readthedocs.io/en/latest/introduction/using-osqueryi/

### Basic queries
```sql
# quit
.q
.exit

# help
.help

# clear the screen
<CTRL+L>

# change display mode
.mode [csv, column, line, list, pretty]

# list all tables
.tables

# list schema of a table
.schema <table_name>
# https://osquery.io/docs/tables/

```



### Complex queries
```sql

# list all running processes
SELECT pid, name, cmdline
    FROM processes 
    ORDER BY start_time ASC;

# list all running processes, non-startup
SELECT pid, name, cmdline
    FROM processes
    WHERE cmdline IS NOT NULL AND cmdline != ""
    ORDER BY start_time ASC;

# list all running processes, from non-root users
SELECT pid, name, cmdline
    FROM processes
    WHERE uid > 0
    ORDER BY start_time ASC;



# list all system users
SELECT * FROM users;

# list all users and their groups
SELECT u.uid, u.gid, u.username, g.groupname, u.description
	FROM users u LEFT JOIN groups g ON (u.gid = g.gid);
	
# list all empty groups without any users
SELECT groups.gid, groups.groupname
	FROM groups LEFT JOIN users ON (groups.gid = users.gid)
	WHERE users.uid IS NULL;

# list all processes, with username and groupname
SELECT p.pid, u.username, g.groupname, p.name, p.cmdline
    FROM processes p
    LEFT JOIN users u ON (p.uid = u.uid)
    LEFT JOIN groups g ON (g.gid = u.gid)
    ORDER BY start_time ASC;

    

# list all listening ports
SELECT * FROM listening_ports;

# list all running process that are publicly listening
SELECT DISTINCT p.name, l.port, p.pid
    FROM processes p
    JOIN listening_ports l ON p.pid = l.pid
    WHERE l.address = '0.0.0.0';
    
SELECT p.name, l.port, p.pid
    FROM processes p
    JOIN listening_ports l ON p.pid = l.pid
    WHERE l.address = '0.0.0.0';

	
	
# list all installed packages - name, version, revision
SELECT name, version, revision FROM deb_packages;

# list all python packages - name, version, revision
SELECT name, version,revision 
	FROM deb_packages
	WHERE name LIKE "python%";

# list all php packages - name, version, revision
SELECT name, version,revision 
	FROM deb_packages
	WHERE name LIKE "php%";
	

# list openssh server and client - name, version, revision
SELECT name, version,revision 
    FROM deb_packages
    WHERE name LIKE "openssh%";

```