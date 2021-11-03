#!/bin/sh 
. ~/.bash_profile

for SID in $(ps -ef |grep smon | grep -v grep | grep -v ASM | awk -F"_" '{ print $3 }')
do

export ORAENV_ASK=NO
export ORACLE_SID=${SID}

. oraenv

sqlplus -s "/ as sysdba"<<EOF
  shutdown immediate 
EOF

done

for LIST in $(ps -ef | grep lsn | grep -v grep | awk -F" " '{ print $9 }')
do
 lsnrctl stop $LIST  
done 
