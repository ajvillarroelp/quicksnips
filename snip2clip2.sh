#!/bin/bash

#snipfile=$HOME/.quicksnips/snippets2.txt
snipfile=$HOME/.quicksnips/snip2.cr
keyfile=$HOME/.quicksnips/.key

storedpass=`cat $keyfile | openssl enc -base64 -d`
snip=$(openssl aes-256-cbc -d -in $snipfile -pass pass:$storedpass | sed -r '/^#|^\s*$/d' | sort | sed -n $1p | cut -d\; -f 2)
if [[ $snip == "" ]];then
	notify-send -i ${snipdir}/mp2.jpeg 'Snippet $1 is empty! check snippet file'
	exit 1
fi
#snip=$( sed -r '/^#|^\s*$/d' "$snipfile" | sort | sed -n $1p | cut -d\; -f 2)
arr=()
mplayer /usr/share/sounds/gnome/default/alerts/drip.ogg
sleep 1.5

check=$(echo \'$snip\' | grep -E \\?? ) 
if [[ $check != "" ]]; then
    perl $HOME/.quicksnips/sendtext.pl "$snip"
    exit
fi

check=$(echo "$snip" | grep '|')
if [[ $check != "" ]]; then
	
     arr[0]=$(echo "$snip" | cut -d'|' -f 1)
     arr[1]=$(echo "$snip" | cut -d'|' -f 2)
     echo "AA ${arr[0]} -- ${arr[1]}\n"
     xdotool getactivewindow type ${arr[0]} 
     sleep 0.5
     xdotool getactivewindow key Tab
     sleep 0.5
     xdotool getactivewindow type ${arr[1]} 
     exit
fi

#if [ -z $check ]; then
    printf '%s' "$snip" | xclip -i -selection clipboard 
     xdotool getactivewindow type "$snip"
     exit
#fi

