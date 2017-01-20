#!/bin/bash
#set -x

#snipfile=$HOME/.quicksnips/snippets.txt
snipfile=$HOME/.quicksnips/snip2.cr
keyfile=$HOME/.quicksnips/.key
basedir=$HOME/.quicksnips
desktopfile=$HOME/.local/share/applications/quicksnips.desktop
snipdir=${snipfile%/*}

storedpass=`cat $keyfile | openssl enc -base64 -d`
mkdir -p "${desktopfile%/*}"
readarray -t -O1 snips < <( openssl aes-256-cbc -d -in $snipfile -pass pass:$storedpass|sed -r '/^#|^\s*$/d' | sort | cut -d\; -f 1)
printf -v xadshorts "Snippet%s;" ${!snips[@]} {96..98}

tee "$desktopfile" << END
[Desktop Entry]
Version=1.0
Name=quicksnips
Comment=Snippets to clipboard using xclip
GenericName=quicksnips
Exec=${snipdir}/editsnippets.sh
Icon=${snipdir}/Snippets.png
Terminal=false
X-MultipleArgs=false
Type=Application
Categories=GNOME;System;
X-Ayatana-Desktop-Shortcuts=${xadshorts%;}
END

for i in ${!snips[@]}
do
  cat << END
[Snippet$i Shortcut Group]
Name=${snips[$i]}
Exec=perl ${snipdir}/snip2clip.pl $i
TargetEnvironment=Unity
END
done | tee -a "$desktopfile"

tee -a "$desktopfile" << END
[Snippet96 Shortcut Group]
Name=Set Delay
Exec=${basedir}/setdelay.sh
TargetEnvironment=Unity
[Snippet97 Shortcut Group]
Name=__________________________________________________
Exec=notify-send -i ${snipdir}/mp2.jpeg 'Go Away...or I shall taunt you a second time !'
TargetEnvironment=Unity
[Snippet98 Shortcut Group]
Name=Update Launcher
Exec=gnome-terminal -e ${snipdir}/quicksnips2.sh
TargetEnvironment=Unity
END
notify-send -i ${snipdir}/mp2.jpeg 'Snippets launchers updated!'
