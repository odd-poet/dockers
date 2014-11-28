#!/bin/sh
DOCKER_NAME="oddpoet/chronos"

echo "###########################################################"
echo "                        Chronos "
echo "###########################################################"
echo 

exit_with_usage() {
	echo "Usage: docker run DOCKER_OPTS ${DOCKER_NAME} OPTIONS"
	echo 
	echo "Options:"
	echo "  -p,  --port=8080                       chronos web port"
	echo "  --master=zk://localhost:2181/mesos     url of mesos master. If you use default value, local zookeeper-server will be run and mesos will use it. "
	echo "  --zk-hosts=localhost:2181              zookeeper servers for storing state. If you use default value, local zookeeper-server will be run and mesos will use it. "
	echo "  --zk-path=/chronos/state               path in zookeeper for storing state"
	echo "  --help                                 help message"
	echo "  shell                                  get a shell in container. You should run docker with '-it' options."
	echo 
	echo "Example: "
	echo "    docker run \\"
	echo "         -d -p 8081:8081 -h chronos \\"
	echo "         ${DOCKER_NAME} --port=8081 \\"
	echo "         --master=zk://zookeeper:2181/mesos \\"
	echo "         --zk-hosts=zookeeper:2181 --zk-path=/chronos/state "
	exit 1
}

# parse option
while [[ $# > 0 ]];do 
	arg="$1"
	shift
	case $arg in 
		--port=*)
			port=${arg#*=}
			;;
		-p)
			port=$1
			shift
			;;
		--master=*)
			master=${arg#*=}
			;;
		--zk-hosts=*)
			zk_hosts=${arg#*=}
			;;
		--zk-path=*)
			zk_path=${arg#*=}
			;;
		--help)
			exit_with_usage
			;;
		shell)
			/bin/bash
			exit 0;
			;;
		*)
			exit_with_usage
			;;
	esac
done

# default
DEFAULT_MASTER="zk://localhost:2181/mesos"
DEFAULT_ZK_HOSTS="localhost:2181"

port=${port:-8080}
master=${master:-$DEFAULT_MASTER}
zk_hosts=${zk_hosts:-$DEFAULT_ZK_HOSTS}
zk_path=${zk_path:-"/chronos/state"}

# check 
if [[ ! ("$port" =~ (^[0-9]+$)) ]];then 
	echo "> wrong port : $port"
	echo 
	exit_with_usage
fi

# start...
echo "* starting chronos"
echo "* port : $port"
echo "* master : $master"
echo "* zk-hosts : $zk_hosts"
echo "* zk-path : $zk_path"

# use local zk
if [[ "$zk_hosts" == $DEFAULT_ZK_HOSTS || "$master" == $DEFAULT_MASTER ]];then 
	echo "* starting local zookeeper ..."
	echo
	service zookeeper-server start
fi

/chronos/bin/start-chronos.bash --http_port $port --master $master --zk_hosts $zk_hosts --zk_path $zk_path 


