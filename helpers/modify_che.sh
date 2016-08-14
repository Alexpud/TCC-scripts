#!/bin/bash

#!

function change_che_port()
{
	sed -i 's/CHE_PORT=[0-9]\+/CHE_PORT='$1'/' /home/boss/nginx_scripts/che.sh
}

change_che_port 8082