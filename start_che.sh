#!/bin/bash
set -x

user_name=$1

echo $user

#Reloads the environment, changing the environment variables values, more specifically, java path.

source /etc/environment

#Path to working che directory
directory='/home/boss/Desktop/eclipse-che-4.0.1'

#Reads the number inside the file that dictates the value of the increment
inc=$(cat /home/boss/nginx_scripts/data.txt)

#The port for the che instance will be the increment added to the default port value, 8080
che_port=$(expr 8080 + $inc)

#The second port will be for the tomcat server
tomcat_server_port=$(expr 8005 + $inc)

echo $tomcat_server_port

#Writes the modified inc value back to the textfile, overwriting it's contents
echo $(expr $inc + 1)>/home/boss/nginx_scripts/data.txt

#This command edits the port attribute on the Server tag on the file containerd on eclipse-che-version/tomcat/conf/server.xml

xmlstarlet edit -L -u "/Server/@port" -v "$tomcat_server_port" $directory/tomcat/conf/server.xml


#Executes the che instance for the ip address and port especified
$directory/bin/che.sh run -r:192.168.25.6 -p:$che_port

#sed -i -- 's/<Server port="8005" shutdown="SHUTDOWN">/<Server port="'"$tomcat_server_port"'" shutdown="SHUTDOWN">/g' /home/boss/nginx_scripts/#teste.xml


