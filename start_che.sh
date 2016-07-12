#!/bin/bash

#THe first parameter,for now, is the name of the user.

if test -z $1 ; then
	echo "Failed. No user was entered"
	exit 1
else
	USER_NAME=$1
fi


#Obtains the machine IPv4 address
MACHINE_IP=$(ip route get 1 | awk '{print $NF;exit}')

echo $MACHINE_IP

#Reloads the environment, changing the environment variables values, more specifically, java path.

source /etc/environment

#Path to working che directory
DIRECTORY='/home/boss/Desktop/eclipse-che-4.0.1'

#Reads the number inside the file that dictates the value of the increment
INC=$(cat /home/boss/nginx_scripts/data.txt)

#The port for the che instance will be the increment added to the default port value, 8080
CHE_PORT=$(expr 8080 + $INC)

#The second port will be for the tomcat server
TOMCAT_SERVER_PORT=$(expr 8005 + $INC)

echo $TOMCAT_SERVER_PORT

#Writes the modified inc value back to the textfile, overwriting it's contents
echo $(expr $INC + 1)>/home/boss/nginx_scripts/data.txt

#This command edits the port attribute on the Server tag on the file containerd on eclipse-che-version/tomcat/conf/server.xml

xmlstarlet edit -L -u "/Server/@port" -v "$TOMCAT_SERVER_PORT" $DIRECTORY/tomcat/conf/server.xml


#Executes the che instance for the ip address and port especified
$DIRECTORY/bin/che.sh run -r:192.168.25.6 -p:$CHE_PORT

#sed -i -- 's/<Server port="8005" shutdown="SHUTDOWN">/<Server port="'"$tomcat_server_port"'" shutdown="SHUTDOWN">/g' /home/boss/nginx_scripts/#teste.xml


