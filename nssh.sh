#!/bin/bash

confDir=~/.config/nssh
node=$(cat ${confDir}/nodes | fzf)
nodeName=$(echo ${node} | awk '{print $1}')
accessType=$(echo ${node} | awk '{print $3}') 
ip=$(echo ${node} | grep -oE "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")
port=$(echo ${node} | cut -d' ' -f 4)
user=$(grep -m1 ${nodeName} ${confDir}/pass | awk '{print $2}')
pass=$(grep -m1 ${nodeName} ${confDir}/pass | awk '{print $3}')
echo ${node}${nodeName}${ip}${port}${user}${pass}
echo "node ${node}"
echo "nodeName ${nodeName}"
echo "ip ${ip}"
echo "port ${port}"
echo "user ${user}"
echo "pass ${pass}"
echo "accesstype ${accessType}"
echo "SSHing to node ${node} ..."

#if [[ $nodeType == "HOST" ]]
#sshpass -p "${pass}" ssh root@${ip} -o StrictHostKeyChecking=false
if [[ ${accessType} == "ssh" ]];then
	sshpass -p "${pass}" ssh -p ${port} ${user}@${ip} -o HostKeyAlgorithms=ssh-rsa -o StrictHostKeyChecking=false
	exit 0
elif [[ ${accessType} == "web" ]];then
	firefox ${ip} & disown
	exit 0
else
	echo "Unknown Access Type ___${accessType}___"
	exit 1
fi

# impliment sshpass
# enrypt passwords file
# add ssh to site nodes + node type (BEZ ALs, BKH MPEs ... etc)
# add ssh to node type (AL, PRE, MPE...etc)
# add idrac via default browser
	#chromium ip
# add command on all nodes + node types (gen SBs for all or MPEs only... etc)
	# sshpass -p "password" ssh -p 42002 admin@10.44.45.133 -o HostKeyAlgorithms=ssh-rsa <<EOF
	# show system information machine-id
	# EOF
# Prepare nodes file if not already done 
	# from hostnames and ip files
	# paste hostnames ips > nodes
