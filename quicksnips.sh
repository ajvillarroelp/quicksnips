#!/bin/bash
#set -x

snipfile=$HOME/.quicksnips/snippets.txt
desktopfile=$HOME/.local/share/applications/quicksnips.desktop
snipdir=${snipfile%/*}

mkdir -p "${desktopfile%/*}"
readarray -t -O1 snips < <( sed -r '/^#|^\s*$/d' "$snipfile" | sort )
printf -v xadshorts "Snippet%s;" ${!snips[@]} {96..99} 

tee "$desktopfile" << END
[Desktop Entry]
Version=1.0
Name=quicksnips
Comment=Snippets to clipboard using xclip
GenericName=quicksnips
Exec=gedit ${snipdir}/snippets.txt
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
Exec=${snipdir}/snip2clip.sh $i
TargetEnvironment=Unity
END
done | tee -a "$desktopfile"

tee -a "$desktopfile" << END
[Snippet96 Shortcut Group]
Name=Date
Exec=${snipdir}/date.sh
TargetEnvironment=Unity
[Snippet97 Shortcut Group]
Name=__________________________________________________
Exec=notify-send -i ${snipdir}/mp2.jpeg 'Go Away...or I shall taunt you a second time !'
TargetEnvironment=Unity
[Snippet98 Shortcut Group]
Name=Add Clipboard Content
Exec=sh -c "echo >> ${snipdir}/snippets.txt && xclip -selection clipboard -o >> ${snipdir}/snippets.txt; ${snipdir}/quicksnips.sh"
TargetEnvironment=Unity
[Snippet99 Shortcut Group]
Name=Update Launcher
Exec=gnome-terminal -e ${snipdir}/quicksnips.sh
TargetEnvironment=Unity
END
