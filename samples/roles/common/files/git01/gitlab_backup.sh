#!/bin/sh

GITLAB_CONFIG_DIR="/etc/gitlab"
BACKUP_SRC="/var/opt/gitlab/backups"
BACKUP_DIR="/mnt/backup/"
BACKUP_TMP_GENERATION=0
BACKUP_GENERATION=20
BACKUP_HOST=`hostname`
BACKUP_MAX_RETRY=2 #バックアップリトライ回数上限

echo ">>DAILY PROCESS START>> `date` ${BACKUP_HOST} gitlab Data backup start!"

# /etc/gitlabバックアップ
echo ">>> `date` ${BACKUP_HOST} gitlab config backup START!"
tar cfpz ${BACKUP_DIR}/`date +%s_%Y_%m_%d`_gitlab_backup_etc.tar.gz ${GITLAB_CONFIG_DIR} # fixed Keiji.Uehata 20180416
echo ">>> `date` ${BACKUP_HOST} gitlab config backup END!"

### gitlab_backup_etc on nfs のデータローテーション
x=1
for f in `ls -r ${BACKUP_DIR}/*_gitlab_backup_etc.tar.gz`
do
  if [ $x -gt ${BACKUP_GENERATION} ]; then
    echo ">>> # rm -f $f"
    rm -f $f
  fi
  x=`expr $x + 1`
done

### /var/opt/gitlab/backups 以下のデータローテーション
y=1
for fff in `ls -r ${BACKUP_SRC}/*_gitlab_backup.tar`
do
  if [ $y -gt ${BACKUP_TMP_GENERATION} ]; then
    echo ">>> # rm -f $fff"
    rm -f $fff
  fi
  y=`expr $y + 1`
done

#バックアップリトライの回数
retry_count=0
while [ ${retry_count} -lt ${BACKUP_MAX_RETRY} ]; do
  ### gitlabコマンドによりローカルデータバックアップ
  echo ">>> `date` ${BACKUP_HOST} gitlab-rake gitlab:backup:create START!"
  su git -c 'gitlab-rake gitlab:backup:create --trace 1>>/var/log/backup.log 2>>/var/log/backup.log'

  #ローカルデータバックアップに成功した場合
  if [ $? -eq 0 ]; then
    echo ">>> `date` ${BACKUP_HOST} gitlab-rake gitlab:backup:create END!"
    echo ">>> `date` ${BACKUP_HOST} strage data copy STRAT!"
    cp ${BACKUP_SRC}/* ${BACKUP_DIR} # fixed Keiji.Uehata 20180416

    ###Cleaner
    echo ">>> `date` ${BACKUP_HOST} strage data LOTATION!"
    x=1
    for fff in `ls -r ${BACKUP_DIR}/*_gitlab_backup.tar`
    do
      if [ $x -gt ${BACKUP_GENERATION} ]; then
        echo ">>> # rm -f $fff"
        rm -f $fff
      fi
      x=`expr $x + 1`
    done
    echo ">>DAILY PROCESS END>> `date` ${BACKUP_HOST} gitlab Data backup done!"
    break
  fi
  retry_count=`expr ${retry_count} + 1`
done
