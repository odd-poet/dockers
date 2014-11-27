#!/bin/bash 



while [[ $# > 0 ]];do 
arg="$1"
shift
echo ">>>$port"
case $arg in 
	--port=*)
		port=${arg#*=}
		echo "port=$port"
		;;
	-p)
		port=$1
		shift
		echo "p=$port"
		;;
	-h|--help)
		echo "help"
		exit 1
		;;
	*)
		echo "WRONG"
		exit 1
		;;
esac
done

echo "------"
echo "port=$port"