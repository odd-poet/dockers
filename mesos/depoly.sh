#!/bin/bash

TAG=oddpoet/mesos

cd $(dirname $0)
docker build -t $TAG . 
docker push $TAG