#!/bin/sh

DOCKER_NAME="oddpoet/zookeeper"

echo "###########################################################"
echo "            Zookeeper Server (3.4.5+cdh5.2.0)"
echo "###########################################################"
echo 
exit_with_usage() {
	echo "Usage: docker run ${DOCKER_NAME} port=PORT"
	echo " example: docker run \\"
	echo "         -p 2181:2181 \\"
	echo "         -h zk-server \\"
	echo "         -d --name=\"zookeeper\"\\"
	echo "         ${DOCKER_NAME} port=2181"
	exit 1
}

if [[ $# -ne 1 ]]; then 
	exit_with_usage
fi

for i in "$@"; do 
	case $i in 
		port=*)
			port=${i#*=}
			shift
			;;
		-h|--help)
			exit_with_usage
			;;
	esac
done

echo "* starting zookeeper "
echo "* port : $port"
echo 
# change port
sed -i -r "s|clientPort=[0-9]+|clientPort=$port|" /etc/zookeeper/conf/zoo.cfg

# start
service zookeeper-server start

# infinite loop
while :; do sleep 5; done
