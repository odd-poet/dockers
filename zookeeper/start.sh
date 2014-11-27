#!/bin/sh

DOCKER_NAME="oddpoet/zookeeper"

exit_with_usage() {
	echo "Usage: docker run ${DOCKER_NAME} PORT"
	echo "  example: "
	echo "        docker run ${DOCKER_NAME} 2181"
	exit 1
}

if [[ $# -ne 1 ]]; then 
	exit_with_usage
fi

PORT=${1:-2181}
echo "Starting zookeeper "
echo " - port : $PORT"

# change port
sed -i -r "s|clientPort=[0-9]+|clientPort=$PORT|" /etc/zookeeper/conf/zoo.cfg

# start
service zookeeper-server start

# infinite loop
while :; do sleep 5; done
