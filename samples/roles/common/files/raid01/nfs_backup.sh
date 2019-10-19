#!/bin/sh
BACKUP_GENERATION=20

### user group backup
cp -p /etc/passwd /etc/group /etc/shadow /mnt/nfs/

### cvs backup
BACKUP_SRC=/backup/cvsroot
BACKUP_DIR=/mnt/nfs/archives_cvs

echo "`date` cvs backup start!"

mkdir -p ${BACKUP_DIR}
file_num=`ls -U1 ${BACKUP_DIR}/cvs_bak_*.tar.gz|wc -l`
if [ $file_num -gt ${BACKUP_GENERATION} ];then
  delete_num=`expr $file_num - ${BACKUP_GENERATION}`
  ls -tr ${BACKUP_DIR}/cvs_bak_*.tar.gz|head -$delete_num|xargs -IFILENAME rm -f FILENAME
fi

tar cfpz ${BACKUP_DIR}/cvs_bak_`date '+%Y%m%d%H%M%S'`.tar.gz ${BACKUP_SRC}

echo "`date` cvs backup done!"

### svn backup
BACKUP_SRC=/backup/svnroot
BACKUP_DIR=/mnt/nfs/archives_svn

echo "`date` svn backup start!"

mkdir -p ${BACKUP_DIR}
file_num=`ls -U1 ${BACKUP_DIR}/svn_bak_*.tar.gz|wc -l`
if [ $file_num -gt ${BACKUP_GENERATION} ];then
  delete_num=`expr $file_num - ${BACKUP_GENERATION}`
  ls -tr ${BACKUP_DIR}/svn_bak_*.tar.gz|head -$delete_num|xargs -IFILENAME rm -f FILENAME
fi

tar cfpz ${BACKUP_DIR}/svn_bak_`date '+%Y%m%d%H%M%S'`.tar.gz ${BACKUP_SRC}

echo "`date` svn backup done!"
