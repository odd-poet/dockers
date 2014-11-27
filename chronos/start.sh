#!/bin/sh

DOCKER_NAME="oddpoet/chronos"

exit_with_usage() {
	echo "Usage: docker run ${DOCKER_NAME} [mesos|chronos] ZK PORT"
	echo "  example: "
	echo "        docker run ${DOCKER_NAME} mesos zk://zk-server/mesos 5050"
	echo "        docker run ${DOCKER_NAME} chronos zk://zk-server/mesos 8081"
	exit 1
}

if [[ $# -ne 2 && $# -ne 3 ]]; then 
	exit_with_usage
fi

declare SERVICE=$1
declare ZK=$2
declare PORT=$3

case $SERVICE in
	mesos)
		MASTER_PORT=${PORT:-5050}
		SLAVE_PORT=$((MASTER_PORT +1))
		echo "Starting mesos..."
		echo " - master port : $MASTER_PORT"
		echo " - slave port : $SLAVE_PORT"
		
		# set zk
		echo $ZK > /etc/mesos/zk
		# change master port
		sed -r -i "s|PORT=[0-9]+|PORT=$MASTER_PORT|" /etc/default/mesos-master
		# change slave port
		echo "$SLAVE_PORT" > /etc/mesos-slave/port
		mesos-init-wrapper slave &
		mesos-init-wrapper master &
		;;
	chronos)
		CHRONOS_PORT=${PORT:-8081}
		echo "Starting chronos..."
		echo " - port : $CHRONOS_PORT"
		
		/chronos/bin/start-chronos.bash --master $ZK --zk_hosts zk-server:2181 --http_port $CHRONOS_PORT &
		;;
	*) 
		exit_with_usage
		;;
esac

# infinite loop
while :; do sleep 5; done
