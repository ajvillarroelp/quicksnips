#!/bin/bash
delayfile=$HOME/.quicksnips/echodelay.sh

newdelay=`cat $delayfile | grep echo | cut -d' ' -f 2`

newdelay=`zenity  --title "Set delay in secs" --entry  --entry-text="$newdelay" --text  "Set delay \(s\):"`
if [[ $newdelay == "" ]]; then
	zenity  --title "Error" --error --text "Delay is invalid"

	exit 1
fi
echo $newdelay | grep -E "[[:digit:]]{1}"
if [ $? -ne 0 ]; then
	zenity  --title "Error" --error --text "Delay should be an integer between 1-9"

	exit 1
fi
echo "#!/bin/bash
echo $newdelay" > $delayfile
