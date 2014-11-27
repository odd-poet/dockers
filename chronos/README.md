Chronos on Mesos
=================

Usage 
-------

You can see usage ``docker run`` without commands. 

```
$ docker run oddpoet/chronos 
Usage: docker run oddpoet/chronos [mesos|chronos] ZK PORT
  example: 
        docker run oddpoet/chronos mesos zk://zk-server/mesos 5050
        docker run oddpoet/chronos chronos zk://zk-server/mesos 8081
```

fig.yml
--------

```
mesos:
   image: oddpoet/chronos
   hostname: mesos-server
   command:
      - mesos
      - zk://zk-server/mesos
      - "5050"
   ports: 
      - "5050:5050"
      - "5051:5051"
   links:
      - zookeeper:zk-server
chronos:
   image: oddpoet/chronos
   hostname: chronos-server
   command:
      - chronos
      - zk://zk-server/mesos
      - "8081"
   ports: 
      - "8081"
   links:
      - zookeeper:zk-server
      - mesos:mesos-server
zookeeper:
  image: oddpoet/zookeeper
  hostname: zk-server
  command:
    - "2181"
  ports:
    - 2181:2181
```
