Mesos
=======

Mesos cluster for dev. 
It not contains zookeeper, so you need other docker container which provide zookeeper. 


Here is sample ``fig.yml``.

```
mesos: 
   image: oddpoet/mesos 
	 command: 
	    - "zk://zookeeper:2181/mesos"
   ports:
	    - "5050:5050"
	 links:
	    - zookeeper:zookeeper
```

