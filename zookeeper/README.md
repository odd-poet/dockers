Zookeeper
=================

- version: CDH5.2

Usage 
-------

You can see usage ``docker run`` without commands. 

```
$ docker run oddpoet/zookeeper
Usage: docker run oddpoet/zookeeper PORT
  example: 
        docker run oddpoet/zookeeper 2181
```

fig.yml
--------

```
zookeeper:
  image: oddpoet/zookeeper
  hostname: zk-server
  command:
    - "2181"
  ports:
    - 2181:2181
```
