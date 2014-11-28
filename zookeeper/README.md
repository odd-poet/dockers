Zookeeper
=================

- version: 3.4.5+cdh5.2.0

Usage 
-------

You can see usage ``docker run oddpoet/zookeeper -h``. 

```
$ docker run oddpoet/zookeeper -h
###########################################################
            Zookeeper Server (3.4.5+cdh5.2.0)
###########################################################

Usage: docker run DOCKER_OPTIONS oddpoet/zookeeper OPTIONS

Options:
  -p,  --port=2181     zookeeper service port
  --help               help
  shell                get a shell in container. You should run docker with '-it' options.

Example:
    docker run \
         -p 2181:2181 \
         -h zk-server \
         -d --name="zookeeper"\
         oddpoet/zookeeper -p 2181
```

fig.yml
--------

```
zookeeper:
  image: oddpoet/zookeeper
  hostname: zk-server
  command:
    - "--port=2181"
  ports:
    - "2181:2181"
```
