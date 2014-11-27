#!/bin/bash

TAG=oddpoet/centos6:jdk7

cd $(dirname $0)
docker build -t $TAG . 
docker push $TAG