#!/bin/sh 

. ~/.bash_profile

for SID in $(cat /etc/oratab | grep -v '#' | grep -v '^$' | awk -F":" '{ print $1 }')
do

export ORAENV_ASK=NO
export ORACLE_SID=${SID}

. oraenv

sqlplus -s "/ as sysdba"<<EOF
  startup 
EOF

done

for LIST in $(cat ${ORACLE_HOME}/network/admin/listener.ora | grep SID_LIST_ | awk -F"_" '{ print $3 }' | sed  's/ =//g')
do
  lsnrctl start $LIST
done
