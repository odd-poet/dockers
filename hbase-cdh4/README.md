HBase
=======

HBase docker image for dev pc. 

* CDH version : cdh4
* java : jdk6u45 (64bit)
* HBase mode : pseudo distributed 
* Exposed port 
	* zookeeper-server: 2181
	* hbase-master : 65000
	* hbase-master web UI : 65010
	* hbase-regionserver : 65020
	* hbase-regionserver web UI: 65030


How to Use
===========

For OSX user
-------------

Download and install [boot2docker](https://github.com/boot2docker/boot2docker).

* [boot2docker releases](https://github.com/boot2docker/boot2docker/releases) 

configure port forwarding for boot2docker.

```
boot2docker init
boot2docker down 

declare PORTS=(2181 65000 65010 65020 65030)
for i in ${PORTS[@]}; do 
	echo "port forwarding : $i"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,tcp,,$i,,$i";
done

boot2docker up
$(boot2docker shellinit)
```

* ref : [boot2docker port forwarding workarounds](https://github.com/boot2docker/boot2docker/blob/master/doc/WORKAROUNDS.md)


Pull image 
-----------

```
docker pull oddpoet/hbase-cdh4
```

Run container 
-------------

```
docker run -p 2181:2181 -p 65000:65000 -p 65010:65010 -p 65020:65020 -p 65030:65030 -h $(hostname) -d oddpoet/hbase-cdh4
```


Check HBase
-----------

open [http://localhost:65010/](http://localhost:65010/) on your browser. 



