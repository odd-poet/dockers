Mesos Master
=================

Usage 
-------

You can see usage ``docker run oddpoet/mesos-master -h``. 

```
$ docker run oddpoet/mesos-slave -h
###########################################################
                    Mesos-Slave
###########################################################

Usage: docker run DOCKER_OPTS oddpoet/mesos-slave OPTIONS

Options:
  -p,  --port=5051                   mesos slave port
  --zk=zk://zk-server:2181/mesos     zookeper url
  --help                             help message

Example:
    docker run \
         -d -p 5051:5051 -h mesos-slave\
         oddpoet/mesos-slave -p 5051
```

fig.yml
--------

```
mesos0:
   image: oddpoet/mesos-master
   hostname: mesos-master
   command:
      - "--port=5050"
   ports: 
      - "5050:5050"
   expose:
      - "2181:2181"
mesos1:
   image: oddpoet/mesos-slave
   hostname: mesos-slave1
   command:
      - "--zk=zk://zk-mesos:2181/mesos"
      - "--port=5051"
   ports: 
      - "5051:5051"
   links:
      - mesos0:zk-mesos
mesos2:
   image: oddpoet/mesos-slave
   hostname: mesos-slave2
   command:
      - "--zk=zk://zk-mesos:2181/mesos"
      - "--port=5052"
   ports: 
      - "5052:5052"
   links:
      - mesos0:zk-mesos
```
