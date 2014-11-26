#!/bin/sh

echo ">> recieved arguments: $*"
echo 

SERVICE=$1
ZK=$2
PORT="$3"

check_zk() {
	if [[ "$ZK" == "" ]];then 
		echo "Need zookeeper info. (e.g. zk://localhost:2181/mesos)"
		exit 1
	fi
	echo "$ZK" > /etc/mesos/zk
	echo "zookeeper : $ZK"
}

case $SERVICE in
	mesos)
		echo "Starting mesos..."
		PORT=${PORT:-5050}
		echo " - port : $PORT"
		check_zk
		# change master port
		sed -r -i "s|PORT=[0-9]+|PORT=$PORT|" /etc/default/mesos-master
		# change slave port
		echo "$((PORT + 1))" > /etc/mesos-slave/port
		mesos-init-wrapper slave &
		mesos-init-wrapper master &
		;;
	chronos)
		echo "Starting chronos..."
		PORT=${PORT:-8081}
		echo " - port : $PORT"
		check_zk
		/chronos/bin/start-chronos.bash --master $ZK --zk_hosts $ZK --http_port $PORT &
		;;
	*) 
		echo "Usage: [mesos|chronos] zk port"
		exit 1
		;;
esac
while :; do sleep 5; done
