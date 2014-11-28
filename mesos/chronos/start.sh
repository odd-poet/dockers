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
	echo "  --master=zk://zk-server:2181/mesos     url of mesos master"
	echo "  --zk-hosts=zk-server:2181              zooKeeper servers for storing state"
	echo "  --zk-path=/chronos/state               path in zooKeeper for storing state"
	echo "  --help                                 help message"
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
		*)
			exit_with_usage
			;;
	esac
done

# default
port=${port:-8080}
master=${master:-"zk://zk-server:2181/mesos"}
zk_hosts=${zk_hosts:-"zk-server:2181"}
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

/chronos/bin/start-chronos.bash \ 
	--http_port $port
	--master $master \
	--zk_hosts $zk_hosts \
	--zk_path $zk_path

