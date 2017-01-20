#!/bin/bash


snipfile=$HOME/.quicksnips/snip2.cr
keyfile=$HOME/.quicksnips/.key

tmpfile=/tmp/.quicksnip.$$ 

keyword=`zenity  --title "Unlock Snippets list" --entry --hide-text --text  "Password"`
if [[ $keyword == "" ]]; then
	zenity  --title "Error" --error --text "Password is null"
	
	exit 1
fi
storedpass=`cat $keyfile | openssl enc -base64 -d`
if [[ $storedpass != $keyword ]]; then
	zenity  --title "Error" --error --text "Password does not match!"
fi

touch $tmpfile
chmod 700 $tmpfile
#decrypt file

openssl aes-256-cbc -d -in $snipfile -pass pass:$storedpass > $tmpfile
geany -i $tmpfile 
if [ $? -eq 0 -a -f  $tmpfile ] ; then
#encrypt file back

	openssl aes-256-cbc -in $tmpfile -out $snipfile -pass pass:$storedpass
fi
rm -f $tmpfile
