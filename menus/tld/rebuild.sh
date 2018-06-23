#!/bin/bash
#
# [PlexGuide Menu]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705 - Deiteq
# URL:      https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################
domain=$( cat /var/plexguide/server.domain )
choice=$( cat /var/plexguide/tld.choice )

heimdall=$(docker ps -a --format "{{.Names}}" | grep heimdall)
ombi=$(docker ps -a --format "{{.Names}}" | grep ombi)
organizr=$(docker ps -a --format "{{.Names}}" | grep organizr)
muximux=$(docker ps -a --format "{{.Names}}" | grep muximux)
htpcmanager=$(docker ps -a --format "{{.Names}}" | grep htpcmanager)
tautulli=$(docker ps -a --format "{{.Names}}" | grep tautulli)
wordpress=$(docker ps -a --format "{{.Names}}" | grep wordgrep -v db | head -1 -c8)

echo "" > /var/plexguide/tld.heimdall
echo "" > /var/plexguide/tld.ombi
echo "" > /var/plexguide/tld.organizr
echo "" > /var/plexguide/tld.muximux
echo "" > /var/plexguide/tld.htpcmanager
echo "" > /var/plexguide/tld.tautulli
echo "" > /var/plexguide/tld.wordpress

program=heimdall
if [ "$choice" == "$program" ]
then
	echo ",$domain" > /var/plexguide/tld.$program
else
	echo "" > /var/plexguide/tld.$program
fi

program=ombi
if [ "$choice" == "$program" ]
then
	echo ",$domain" > /var/plexguide/tld.$program
else
	echo "" > /var/plexguide/tld.$program
fi

program=organizr
if [ "$choice" == "$program" ]
then
	echo ",$domain" > /var/plexguide/tld.$program
else
	echo "" > /var/plexguide/tld.$program
fi

program=muximux
if [ "$choice" == "$program" ]
then
	echo ",$domain" > /var/plexguide/tld.$program
else
	echo "" > /var/plexguide/tld.$program
fi

program=htpcmanager
if [ "$choice" == "$program" ]
then
	echo ",$domain" > /var/plexguide/tld.$program
else
	echo "" > /var/plexguide/tld.$program
fi

program=tautulli
if [ "$choice" == "$program" ]
then
	echo ",$domain" > /var/plexguide/tld.$program
else
	echo "" > /var/plexguide/tld.$program
fi

program=wordpress
if [ "$choice" == "$program" ]
then
	echo ",$domain" > /var/plexguide/tld.$program
else
	echo "" > /var/plexguide/tld.$program
fi

################# If role exist, rebuild
if [ "$heimdall" == "heimdall" ]
then
	ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags heimdall &>/dev/null &
fi

if [ "$ombi" == "ombi" ]
then
	ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags ombi &>/dev/null &
fi

if [ "$organizr" == "organizr" ]
then
	ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags organizr &>/dev/null &
fi

if [ "$muximux" == "muximux" ]
then
	ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags muximux &>/dev/null &
fi

if [ "$htpcmanager" == "htpcmanager" ]
then
	ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags htpcmanager &>/dev/null &
fi

if [ "$tautulli" == "tautulli" ]
then
	ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags tautulli &>/dev/null &
fi

if [ "$wordpress" == "wordpress" ]
then
  
docker ps -a --format "{{.Names}}" | grep wordpress | grep -v | head -1 1> $p

while read p; do
  echo $p > /tmp/program_var
  echo 'INFO - Rebuilding Container: $p' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
  echo "$p" > /var/plexguide/wp.id
  dialog --infobox "Reconstructing Your Container: $app" 3 50
  clear
  ansible-playbook /opt/plexguide/ansible/wordpress.yml --tags wordpress
  sleep 1
  #read -n 1 -s -r -p "Press any key to continue "
done </opt/appdata/plexguide/running
  echo 'INFO - Finished Rebuilding Containers' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
fi

dialog --msgbox "The containers are rebuilding!\n\nCheck the Top Level Domain in 1 - 3 Minutes\n\nNote: This only REBUILDS the App. If you never deployed it, make sure to do so!" 0 0
dialog --msgbox "\n$choice is your supported Top Level Domain!" 0 0