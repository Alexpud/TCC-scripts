#!/bin/bash




#Usei o seguinte comando para modificar o padrao /primeiro/segundo

#Takes the parameter, and searchs for the pattern: /workspaces/$1. When the pattern is found, it is replaced by: /workspaces

function reset_workspace()
{
	sed -ri 's/\/workspaces\/\w+/\/workspaces/g' /home/boss/Desktop/eclipse-che-4.4.2/conf/che.properties
}

function set_workspace()
{
	sed -i 's/\/workspaces/\/workspaces\/'$1'/g' /home/boss/Desktop/eclipse-che-4.4.2/conf/che.properties
}

#reset_workspace "alexandre"

#I managed to make a regex that searched for the pattern: com/(anyword) with the following regex: /com\/(a-z)\w+. So i adapted it to what i needed, including \w+ to the regex i already had. It didn't work. I searched a little and found that i need to add the -r option to sed, for the extended regex and it worked like a charm.

#sed -ri 's/\/workspaces\/\w+/\/workspaces/g' che.properties

#sed -i 's/\/workspaces/\/segundo\/'$a'/g' che.properties

case "$1" in
	-r)
		reset_workspace
		;;
	-s)
		set_workspace $2
		;;
esac
