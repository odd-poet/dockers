Mesos Master
=================

Usage 
-------

You can see usage ``docker run oddpoet/mesos-master -h``. 

```
$ docker run oddpoet/mesos-master -h
###########################################################
                    Mesos-Master
###########################################################

Usage: docker run DOCKER_OPTS oddpoet/mesos-master OPTIONS

Options:
  -p,  --port=5050                   mesos master port
  --zk=zk://localhost:2181/mesos     zookeper url. If you use default value, local zookeeper-server will be run and mesos will use it.
  -h,  --help                        help message
  shell                              get a shell in container

Example:
    docker run \
         -d -p 5050:5050 -h mesos-master \
         oddpoet/mesos-master -p 5050
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
zookeeper:
  image: oddpoet/zookeeper
  hostname: zk-server
  command:
    - "--port=2181"
  ports:
    - "2181:2181"
```
