#!/bin/sh

DOCKER_NAME="oddpoet/zookeeper"

echo "###########################################################"
echo "            Zookeeper Server (3.4.5+cdh5.2.0)"
echo "###########################################################"
echo 
exit_with_usage() {
	echo "Usage: docker run DOCKER_OPTS ${DOCKER_NAME} OPTIONS"
	echo 
	echo "Options:"
	echo "  -p,  --port=2181     zookeeper service port"
	echo "  --help               help"
	echo 
	echo "Example: "
	echo "    docker run \\"
	echo "         -p 2181:2181 \\"
	echo "         -h zk-server \\"
	echo "         -d --name=\"zookeeper\"\\"
	echo "         ${DOCKER_NAME} -p 2181"
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
		-h|--help)
			exit_with_usage
			;;
		*)
			exit_with_usage
			;;
	esac
done

# default
port=${port:-2181}

# check 
if [[ ! ("$port" =~ (^[0-9]+)) ]];then 
	echo "> wrong port format: $port"
	echo 
	exit_with_usage
fi


echo "* starting zookeeper "
echo "* port : $port"
echo 
# change port
sed -i -r "s|clientPort=[0-9]+|clientPort=$port|" /etc/zookeeper/conf/zoo.cfg

# start
service zookeeper-server start

# infinite loop
while :; do sleep 5; done
