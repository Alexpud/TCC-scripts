#!/bin/bash
#---------------------------------------Variable---------------------------------------------------------------#
#Scripts paths

HELPERS_PATH=$(pwd)'/helpers'
CHE_FILES_PATH=$(pwd)'/che_files'

MACHINE_IP=0

#Default CHE ports values
CHE_PORT=8080
TOMCAT_SERVER_PORT=8005

USAGE="
Usage:
	modify_che [OPTIONS] [COMMAND]
		-p:port portnumber 						The new port value for the CHE_PORT variable

	Command
		run 													Executes the modification on the CHE_PORT variable on che.sh script to be mounted
"

#------------------------------------------------------------------------------------------------------------#
function usage()
{
	echo "${USAGE}"
}


#-----------------------------------Obtains the port values------------------------------------------------#
function setPorts
{
	INC=$(cat $HELPERS_PATH/data.txt) #Reads the increment value
	CHE_PORT=$(expr 8080 + $INC) #New Che port
	TOMCAT_SERVER_PORT=$(expr 8005 + $INC) #New Tomcat port
	
	#Sets the new increment value on the txt file
	echo $(expr $INC + 1) > $HELPERS_PATH/data.txt
}


#------------------------------------Obtains the IPV4 address----------------------------------------------#
function getIP
{
	MACHINE_IP=$(ip route get 1 | awk '{print $NF;exit}')
}

#----------------------------------------------------------------------------------------------------------#


#-----------------------------------Modify the che ports values---------------------------------------------#

#Modifies the CHE_PORT variable on the che.sh script to be mounted on the container.The variable sets the default
#port in which eclipse che will be executed.
function change_che_port()
{
	sed -i 's/CHE_PORT=[0-9]\+/CHE_PORT='$CHE_PORT'/' $CHE_FILES_PATH/bin/che.sh
}

function change_che_server_port()
{
	xmlstarlet edit -L -u "/Server/@port" -v "$TOMCAT_SERVER_PORT" $CHE_FILES_PATH/conf-tomcat/server.xml 
}
#----------------------------------------------------------------------------------------------------------#

#----------------------------------Starts the che container------------------------------------------------#
function start_che_container()
{
	docker run --net=host --name $1 -v $CHE_FILES_PATH/workspaces:/home/user/che/workspaces -v $CHE_FILES_PATH/storage:/home/user/che/storage -v $CHE_FILES_PATH/conf:/home/user/che/conf -v $CHE_FILES_PATH/lib:/home/user/che/lib-copy -v /var/run/docker.sock:/var/run/docker.sock -v $CHE_FILES_PATH/conf-tomcat:/home/user/che/tomcat/conf -v $CHE_FILES_PATH/bin:/home/user/che/bin codenvy/che
}

#----------------------------------------------------------------------------------------------------------#
if [ $# -lt  1 ]; then
	usage
	exit 1
else 
	setPorts
	change_che_port
	change_che_server_port
	getIP
	start_che_container alexandre
fi
