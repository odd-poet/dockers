Chronos
=================

Notice : It is NOT contain mesos-master/slave. 
You should link other mesos container. (See the below ``fig.yml`` section.)

Usage 
-------

You can see usage ``docker run oddpoet/chrons -h``. 

```
$ docker run oddpoet/chronos -h
###########################################################
                        Chronos
###########################################################

Usage: docker run DOCKER_OPTS oddpoet/chronos OPTIONS

Options:
  -p,  --port=8080                       chronos web port
  --master=zk://zk-server:2181/mesos     url of mesos master
  --zk-hosts=zk-server:2181              zooKeeper servers for storing state
  --zk-path=/chronos/state               path in zooKeeper for storing state
  --help                                 help message

Example:
    docker run \
         -d -p 8081:8081 -h chronos \
         oddpoet/chronos --port=8081 \
         --master=zk://zookeeper:2181/mesos \
         --zk-hosts=zookeeper:2181 --zk-path=/chronos/state
```

fig.yml
--------

```
mesos0:
   image: oddpoet/mesos-master
   hostname: mesos-master
   command:
      - "--zk=zk://zk-server:2181/mesos"
      - "--port=5050"
   ports: 
      - "5050:5050"
   links:
      - zookeeper:zk-server
mesos1:
   image: oddpoet/mesos-slave
   hostname: mesos-slave1
   command:
      - "--zk=zk://zk-server:2181/mesos"
      - "--port=5051"
   ports: 
      - "5051:5051"
   links:
      - zookeeper:zk-server
mesos2:
   image: oddpoet/mesos-slave
   hostname: mesos-slave2
   command:
      - "--zk=zk://zk-server:2181/mesos"
      - "--port=5052"
   ports: 
      - "5052:5052"
   links:
      - zookeeper:zk-server
zookeeper:
  image: oddpoet/zookeeper
  hostname: zk-server
  command:
    - "--port=2181"
  ports:
    - "2181:2181"
chronos:
  image: oddpoet/chronos
  hostname: chronos 
  command:
    - "--port=8081"
    - "--master=zk://zk-server:2181/mesos"
    - "--zk-hosts=zk-server:2181"
  ports:
    - "8081:8081"
  links:
    - zookeeper:zk-server
```
