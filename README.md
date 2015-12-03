# backup-datas

##Purpose
two scripts, in bash languages; very simples to backup some datas on distant servers. You can setup this scripts in web environnments and  lauch them with crontab.

##How to get 
git clone https://github.com/bobiwembley/backup-datas.git

##change the scripts to content your needs
You have to setup scripts for your needs


1. change $BACKUP with the name of your remote-server
2. change $USER_RSYNC with the name of your account on the remote server 

I used rsync to copy the files. I don't give in the script, the password, because between the local server and the remote server, authentification is defined by ssh-key 
you have to exchange key between the servers
```bash ssh-copy-id```
