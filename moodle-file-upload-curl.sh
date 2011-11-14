#!/bin/bash

#from http://moodle.org/mod/forum/discuss.php?d=119214
./moodle-config.sh


cookiefile="/tmp/moodle_cookie.txt"
FILE=testdata/williecolon.jpg # plese, no spaces

#removing old files
rm -f ${cookiefile}
rm -f ?.html

arg="-F d=$DATABASEID -F rid=$RID -F field_2_file=fakevalue -F field_2_filename= -F MAX_FILE_SIZE=20971520 -F saveandview=S -F field_2=@$FILE"
#echo -e "Enter password: "; read -s MOODLE_PASS

logindata="username=$MOODLE_USER&password=$MOODLE_PASS"



curl -k -b ${cookiefile} -c ${cookiefile} -d "${logindata}" ${MOODLE_HEAD}login/index.php > 2.html



curl -k -b ${cookiefile} -c ${cookiefile} ${MOODLE_HEAD}mod/data/view.php?id=2 > 3.html
sessid=`grep 'sesskey=' 3.html | head -n1|awk '{gsub(/^.*sesskey=/,"",$0);gsub(/\"/," ",$0);print $1}'`
arg=`echo "-F sesskey=$sessid $arg"`
echo "sesskey:\"$sessid\""
# -k permitir conexiones inseguras
curl -k -b ${cookiefile} -c ${cookiefile} `echo $arg` ${MOODLE_HEAD}mod/data/edit.php?id=2 > 4.html
#rm -f ${cookiefile} ?.html