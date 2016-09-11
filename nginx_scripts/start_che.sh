#!/bin/bash


#------------------------------------Paths used in the script-----------------------------------------------#

SCRIPTS_PATH=$(pwd)

#-----------------------------------------------------------------------------------------------------------#

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
	echo $(expr $INC + 1) > $SCRIPTS_PATH/data.txt
}

#----------------------------------------------------------------------------------------------------------#

#----------------------------------Starts the user che container-------------------------------------------#

function start
{
	if [ -d "/home/user/$1" ]; then 
	  if [ -L "/home/user/$1" ]; then
	    # It is a symlink!
	    # Symbolic link specific commands go here.
	    echo "Error, it is not a directory, it is a symlink.?"
	  else
	    # It's a directory!
	    # Directory command goes here.
	    echo "Directory already exists. That means the container belonging to $1 already exists, starting the container..."
	    docker start $1
	  fi
	else
		echo "Attempting to create and run the container $1"
		CREATION_RESULT=$( docker run -v /var/run/docker.sock:/var/run/docker.sock -e CHE_DATA_FOLDER=/home/user/$1 -e CHE_PORT=$2 codenvy/che-launcher start)
		RENAME_RESULT=$(docker rename che-server $1)
		echo $CREATION_RESULT
		echo "Container successfully created"
	fi
}

#----------------------------------Stops the user che container-------------------------------------------#
function stop
{
	STOP_RESULT=$(docker exec -it $1 /bin/bash ./home/user/che/bin/che.sh stop --skip:uid || echo 'lol')
	echo $STOP_RESULT
}	

#----------------------------------------------------------------------------------------------------------#
#-----------------------------------First parameter,for now, is the name of the user-----------------------#

if [ $# -lt  2 ]; then
	echo "Less than 2 arguments were entered"
	exit 1
fi

#Checks if the first paramter is specifying the user and the second is not empty
if [ ! -z $2 ] ; then
	
	USER_NAME=$2
	PORT_NUMBER=$3
	# getIP
	echo $SCRIPTS_PATH
	case "$1" in
	start)
		start $USER_NAME $PORT_NUMBER
		;;
	stop)
		stop $USER_NAME
		;;
esac
	
fi






#sed -i -- 's/<Server port="8005" shutdown="SHUTDOWN">/<Server port="'"$tomcat_server_port"'" shutdown="SHUTDOWN">/g' /home/boss/nginx_scripts/#teste.xml


