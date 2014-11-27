#!/bin/sh

DOCKER_NAME="oddpoet/mesos"

echo "###########################################################"
echo "            Mesos Server (0.21.0)"
echo "###########################################################"
echo 

exit_with_usage() {
	echo "Usage: docker run ${DOCKER_NAME} [master|slave] port=PORT zk=ZK_URL"
	echo " example: docker run \\"
	echo "         -p 5050:5050 \\"
	echo "         -h mesos-master \\"
	echo "         -d --name=\"mesos-master\"\\"
	echo "         ${DOCKER_NAME} port=5050 zk=zk://zk-server/mesos"
	exit 1
}

service=$1
shift
# parsing args.
for i in "$@"; do 
	case $i in 
		port=*)
			port=${i#*=}
			shift
			;;
		zk=*)
			zk=${i#*=}
			shift
			;;
		-h|--help)
			exit_with_usage
			;;
		*)
			echo "Wrong argument: $1"
			echo 
			exit_with_usage
			;;
	esac
done

if [[ "$service" == "master" ]];then 
	port=${port:-5050}
elif [[ "$service" == "slave" ]];then 
	port=${port:-5051}
else 
	echo "Wrong service : $service"
	echo 
	exit_with_usage
fi

if [[ ! ("$port" =~ (^[0-9]+$)) ]];then 
	echo "Wrong port : $port"
fi

if [[ ! ("$zk" =~ (zk\://.+/.+)) ]];then 
	echo "Wrong zookeeper : $zk"
	echo 
	exit_with_usage
fi

echo "* starting mesos-$service "
echo "* port : $port"
echo "* zookeeper : $zk"

# set zk.
echo $zk > /etc/mesos/zk 
case "$service" in 
	master)
		sed -r -i "s|PORT=[0-9]+|PORT=$port|" /etc/default/mesos-master
		mesos-init-wrapper master
		;;
	slave)
		echo "$port" > /etc/mesos-slave/port
		mesos-init-wrapper slave
		;;
	*)
		exit 1
		;;
esac

