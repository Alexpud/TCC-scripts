#!/bin/bash

#Checks if less than 2 parameters were passed

if [ $# -lt 2 ]; then

	echo "Less than 2 arguments"
	exit 1
fi

#Checks first paramter is user and the second paramter, the user name, is not empty
if [ $1 = "--user" ] && [ ! -z $2 ] ; then
	echo "lol"
	sed -i 's/\/workspaces/\/workspaces\/'"$2"'/g' che.properties
fi
