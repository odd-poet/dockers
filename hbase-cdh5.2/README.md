HBase
=======

HBase docker image for dev pc. 

* CDH version : cdh5.2
* HBase mode : pseudo distributed 
* Exposed port 
	* hbase-master : 65000
	* hbase-master web UI : 65010
	* hbase-regionserver : 65020
	* hbase-regionserver web UI: 65030


How to Use
===========


### modify ``/etc/hosts``

```
sudo echo "$(boot2docker ip 2>/dev/null) hbase.local" >> /etc/hosts
```


### using *fig*

``fig.yml``

```
zookeeper:
  image: oddpoet/zookeeper
  hostname: zookeeper.local
  command:
    - "2181"
  ports:
    - 2181:2181
hbase:
   image: oddpoet/hbase-cdh5.2
   hostname: hbase.local
   command:
     - "zookeeper:2181"
   ports:
     - 65000:65000
     - 65010:65010
     - 65020:65020
     - 65030:65030
   links:
     - zookeeper:zookeeper
```

and then ``fig up``.

### check hbase master

```
open [http://hbase.local:65010](http://hbase.local:65010) on your browser.
```





