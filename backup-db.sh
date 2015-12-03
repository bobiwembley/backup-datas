#!/bin/bash

###variables
DATE="date +%F"
USER_RSYNC="server_backup"
BACKUP="xxxxxx"
FOLDER_BACKUP="/home/backup_web/databases"
LOCAL_BACKUP="/var/backup/databases/"
DB_USER="root"
DB_PASSWD="xxxxx"

###TEMPORARY CREATE A FOLDER TO BACKUP IN
if  [ ! -d /var/backup/databases ]
	then mkdir /var/backup/databases
fi

###LISTING DATABASES
databases=`mysql -u $DB_USER -p$DB_PASSWD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

###DUMP DATABASES AND COMPRESS 
cd $LOCAL_BACKUP

for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
mysqldump -u $USER -p$DB_PASSWD --databases $db > `date +%Y%m%d`.$db.sql
        gzip `$DATE`.$db.sql
    fi

done

###transfert tar backup from server to backup server

rsync -a $LOCAL_BACKUP $USER_RSYNC@$BACKUP:$FOLDER_BACKUP

##clean the folder
rm /var/backup/databases/*

exit 0

