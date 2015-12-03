#!/bin/bash

###variables
DATE="date +%F"
WWW="/var/www/html"

USER_RSYNC="server_backup"
BACKUP="name_of_remote_server"
FOLDER_BACKUP="/home/backup_web"
LOCAL_BACKUP="/var/backup/sites/"

###TEMPORARY CREATE A FOLDER TO BACKUP IN
if  [ ! -d /var/backup ]
	then mkdir /var/backup
fi
###/var/www/html/ listing
cd $WWW
LISTING=ls 

###compression  with tar format
for server in $($LISTING) ; do tar -czf /var/backup/$server`$DATE`.tar.gz $server ; done


###transfert tar backup from server to backup server

rsync -a $LOCAL_BACKUP $USER_RSYNC@$BACKUP:$FOLDER_BACKUP

##clean the folder
rm /var/backup/sites*

exit 0
