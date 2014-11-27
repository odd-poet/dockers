#!/bin/sh

DOCKER_NAME="oddpoet/mesos"

echo "###########################################################"
echo "            Mesos Server (0.21.0)"
echo "###########################################################"
echo 

exit_with_usage() {
	echo "Usage: docker run ${DOCKER_NAME} OPTIONS"
	echo 
	echo "Options:"
	echo "  -p,  --port=5050                   master port"
	echo "       --slave-port=5051             slave port"
	echo "  --zk=zk://zk-server:2181/mesos     zookeper url"
	echo "  --help                             help message"
	echo 
	echo "Example: "
	echo "    docker run \\"
	echo "         -d -p 5050 -h mesos\\"
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
		--slave-port=*)
			slave_port=${arg#*=}
			;;
		-h|--help)
			exit_with_usage
			;;
		*)
			exit_with_usage
			;;
	esac
done

if [[ ! ("$port" =~ (^[0-9]+$)) ]];then 
	echo "> wrong port : $port"
	echo 
	exit_with_usage
fi

if [[ ! ("$slave_port" =~ (^[0-9]+$)) ]];then 
	echo "> wrong slave port : $port"
	echo 
	exit_with_usage
fi


if [[ ! ("$zk" =~ (zk\://.+/.+)) ]];then 
	echo "> wrong zookeeper url : $zk"
	echo 
	exit_with_usage
fi

echo "* starting mesos (master & slave) "
echo "* master port : $port"
echo "* slave port : $slave_port"
echo "* zookeeper : $zk"

# set zk.
echo $zk > /etc/mesos/zk 

# start master 
sed -r -i "s|PORT=[0-9]+|PORT=$port|" /etc/default/mesos-master
mesos-init-wrapper master &

#start slave 
echo "$slave_port" > /etc/mesos-slave/port
mesos-init-wrapper slave &

# infinite loop
while :; do sleep 5; done
