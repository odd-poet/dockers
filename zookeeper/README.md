Zookeeper
=================

- version: 3.4.5+cdh5.2.0

Usage 
-------

You can see usage ``docker run`` without commands. 

```
$ docker run oddpoet/zookeeper
Usage: docker run oddpoet/zookeeper port=PORT
 example: docker run \
         -p 2181:2181 \
         -h zk-server \
         -d --name="zookeeper" \
         oddpoet/zookeeper port=2181
```

fig.yml
--------

```
zookeeper:
  image: oddpoet/zookeeper
  hostname: zk-server
  command:
    - "port=2181"
  ports:
    - 2181:2181
```
