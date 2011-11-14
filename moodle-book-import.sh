#!/bin/bash


./moodle-config.sh

#import formurl
# http://localhost/moodle/mod/book/tool/importhtml/index.php?id=6

# <form action="http://localhost/moodle/mod/book/tool/importhtml/index.php" method="post" accept-charset="utf-8" id="mform1" class="mform">
# 	<div style="display: none;"><input name="id" type="hidden" value="6" />
# <input name="chapterid" type="hidden" value="0" />
# <input name="sesskey" type="hidden" value="BYB7y9v8bL" />
# <input name="_qf__booktool_importhtml_form" type="hidden" value="1" />
# </div>

# 	<fieldset class="clearfix"  id="general">
# 		<legend class="ftoggler">Importar</legend>
# 		<div class="advancedbutton"></div><div class="fcontainer clearfix">
# 		
# 		<div class="fitem"><div class="fitemtitle"><label for="id_type">Tipo </label></div><div class="felement fselect"><select name="type" id="id_type">
# 	<option value="1">Cada directorio representa un capítulo</option>
# 	<option value="2" selected="selected">Cada archivo HTML representa un capítulo</option>
# </select></div></div>




MAX_SIZE=1000000
cookiefile="/tmp/moodle_cookie.txt"
rawfile="/tmp/moodle_rawfile"
# inspired by http://kangry.com/topics/viewcomment.php?index=18544
# The first few lines set some specific settings. you will need to change the values for username
# and password. $cookiefile and $rawfile are tempoary files used by the program.
# the cookie file stores your login credentials. 
# the Raw file is used to store the urlencoded version of each file that is uploaded. 
# Maxsize could be increased but the webserver won't accept files over 2Mb (encoded, this could be increased)

# peligro con name o username
logindata="name=$MOODLE_USER&password=$MOODLE_PASS"
loginurl="${MOODLE_HEAD}login.php"

wget -q --save-cookies $cookiefile --post-data '${logindata}' -O /dev/null ${loginurl}



