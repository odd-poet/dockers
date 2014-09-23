#!/bin/bash 


# check os

# check boot2docker 


# port forwarding 
# ref : https://github.com/boot2docker/boot2docker/blob/master/doc/WORKAROUNDS.md

declare PORTS=(2181 60000 60010 60020 60030)
for i in ${PORTS[@]}; do 
	echo "port forwarding : $i"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,tcp,,$i,,$i";
	
done

# boot2docker ud
boot2docker up