#!/bin/bash

passfile=$HOME/.quicksnips/.key
zenity  --question --text "Really want to reset the key? Cannot undo."

if [ $? -eq 1 ] ; then #answer no
	exit 1
fi
rm -f $passfile
touch $passfile
chmod 700 $passfile
keyword=`zenity  --title "Edit Snippets list" --entry --hide-text --text  "Password"`
if [[ $keyword != "" ]]; then
	echo $keyword | openssl enc -base64 > $passfile
	echo "Password file created!\n"
fi
