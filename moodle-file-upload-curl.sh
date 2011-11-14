#!/bin/bash

#from http://moodle.org/mod/forum/discuss.php?d=119214
MOODLE_HEAD=http://localhost/moodle/
DATABASEID=1
RID=0
MOODLE_USER=admin
MOODLE_PASS="q1w2e3r4;A"
FILE=testdata/williecolon.jpg # plese, no spaces
MOODLE_COURSE=2


rm -f cook.txt ?.html
arg="-F d=$DATABASEID -F rid=$RID -F field_2_file=fakevalue -F field_2_filename= -F MAX_FILE_SIZE=20971520 -F saveandview=S -F field_2=@$FILE"
#echo -e "Enter password: "; read -s MOODLE_PASS
curl -k -b cook.txt -c cook.txt -d "username=${MOODLE_USER}&password=$MOODLE_PASS" ${MOODLE_HEAD}login/index.php > 2.html



curl -k -b cook.txt -c cook.txt ${MOODLE_HEAD}mod/data/view.php?id=2 > 3.html
sessid=`grep 'sesskey=' 3.html | head -n1|awk '{gsub(/^.*sesskey=/,"",$0);gsub(/\"/," ",$0);print $1}'`
arg=`echo "-F sesskey=$sessid $arg"`
echo "sesskey:\"$sessid\""
# -k permitir conexiones inseguras
curl -k -b cook.txt -c cook.txt `echo $arg` ${MOODLE_HEAD}mod/data/edit.php?id=2 > 4.html
#rm -f cook.txt ?.html