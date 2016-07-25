#!/bin/bash

set -x

#------------------------------------Paths used in the script-----------------------------------------------#

SCRIPTS_PATH='/home/boss/nginx_scripts'
CHE_PATH='/home/boss/Desktop/eclipse-che-4.4.2'

#-----------------------------------------------------------------------------------------------------------#

#------------------------------------First parameter,for now, is the name of the user-----------------------#

#if [ $# -lt  2 ]; then
#	echo "Less than 2 arguments were entered"
#	exit 1
#fi

#Checks if the first paramter is specifying the user and the second is not empty
#if [ "$1" =  "--user" ] && [ ! -z $2 ] ; then
	
#	USER_NAME=$2

#else
	
#	echo "Failed; No user was entered"
#	echo "Error" >$SCRIPTS_PATH/status.txt
#	exit 1
#	USER_NAME=$2

#fi

#----------------------------------------------------------------------------------------------------------#


#------------------------------------Obtains the IPV4 address----------------------------------------------#
function getIP
{
	MACHINE_IP=$(ip route get 1 | awk '{print $NF;exit}')
}

#----------------------------------------------------------------------------------------------------------#



#-----------------------------------Obtains the port values------------------------------------------------#
function setPorts
{
	INC=$(cat $SCRIPTS_PATH/data.txt) #Reads the increment value
	CHE_PORT=$(expr 8080 + $INC) #New Che port
	TOMCAT_SERVER_PORT=$(expr 8005 + $INC) #New Tomcat port
	
	#Sets the new increment value on the txt file
	echo $(expr $INC + 1) > $SCRIPTS_PATH/data.txt
}

#----------------------------------------------------------------------------------------------------------#

getIP
echo $SCRIPTS_PATH
setPorts

#Reloads the environment, changing the environment variables values, more specifically, java path.

. /etc/environment

#This command edits the port attribute on the Server tag on eclipse che tomcat

xmlstarlet edit -L -u "/Server/@port" -v "$TOMCAT_SERVER_PORT" $CHE_PATH/tomcat/conf/server.xml


#-----------------------------------Executes the che instance for the ip address and port especified-------#
$CHE_PATH/bin/che.sh run -r:$MACHINE_IP -p:$CHE_PORT

#sed -i -- 's/<Server port="8005" shutdown="SHUTDOWN">/<Server port="'"$tomcat_server_port"'" shutdown="SHUTDOWN">/g' /home/boss/nginx_scripts/#teste.xml


