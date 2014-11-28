#!/bin/sh

DOCKER_NAME="oddpoet/mesos-master"

echo "###########################################################"
echo "                    Mesos-Master"
echo "###########################################################"
echo 

exit_with_usage() {
	echo "Usage: docker run DOCKER_OPTS ${DOCKER_NAME} OPTIONS"
	echo 
	echo "Options:"
	echo "  -p,  --port=5050                   mesos master port"
	echo "  --zk=zk://localhost:2181/mesos     zookeper url. If you use default value, local zookeeper-server will be run and mesos will use it."
	echo "  -h,  --help                        help message"
	echo "  shell                              get a shell in container. You should run docker with '-it' options."
	echo 
	echo "Example: "
	echo "    docker run \\"
	echo "         -d -p 5050:5050 -h mesos-master \\"
	echo "         ${DOCKER_NAME} -p 5050"
	exit 1
}

# parse option
while [[ $# > 0 ]];do 
	arg="$1"
	shift
	case $arg in 
		--zk=*)
			zk=${arg#*=}
			;;
		--port=*)
			port=${arg#*=}
			;;
		-p)
			port=$1
			shift
			;;
		shell)
			/bin/bash
			exit 0;
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
DEFAULT_ZK="zk://localhost:2181/mesos"

port=${port:-5050}
zk=${zk:-$DEFAULT_ZK}

# check
if [[ ! ("$port" =~ (^[0-9]+$)) ]];then 
	echo "> wrong port : $port"
	echo 
	exit_with_usage
fi

if [[ ! ("$zk" =~ (zk\://.+/.+)) ]];then 
	echo "> wrong zookeeper url : $zk"
	echo 
	exit_with_usage
fi

echo "* starting mesos-master"
echo "* port : $port"
echo "* zookeeper : $zk"
echo 

# use local zk
if [[ "$zk" == $DEFAULT_ZK ]];then 
	echo "* starting local zookeeper ..."
	echo
	service zookeeper-server start
fi

# set zk for mesos
echo $zk > /etc/mesos/zk 

# start master 
sed -r -i "s|PORT=[0-9]+|PORT=$port|" /etc/default/mesos-master
mesos-init-wrapper master

