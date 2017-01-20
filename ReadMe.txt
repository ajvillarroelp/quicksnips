
######################################################################
# quicksnips version 1.3                                             #
# Thanks to Vaphell from ubuntuforums.org for rewriting the script.  #
######################################################################

The snippets rely on xclip to send to clipboard middle mouse button or right click paste(ctrl+v).
Install xclip if necessary.

To use, extract and move the folder .quicksnips to your home directory.
The .quicksnips will be hidden when first extracted. ctrl+h toshow hidden.

Make the scripts executable...
chmod +x ~/.quicksnips/date.sh ~/.quicksnips/quicksnips.sh ~/.quicksnips/snip2clip.sh


Run these 2 commands to create the ~/.local/share/applications/quicksnips.desktop file ... 
cd ~/.quicksnips
./quicksnips.sh

Open the dash and search for "quicksnips" and drag and drop to the launcher
or
open the file browser and and drag and drop  ~/.local/share/applications/quicksnips.desktop.

Right clicking the quicksnips icon shows the quicklist.

Left clicking on the launcher icon opens ~/.quicksnips/snippets.txt
where you can add your snippets.
A snippet can be a phrase or single word.
Use one snippet per line remembering that 
the length of the snippet will determine the width of the quicklist window.
The snippets will be sorted alphabetically.
Save.

Right click on launcher and select Update Launcher.
Right click again to see your newly added snippets.

You can use the quicklist item "Add Clipboard Content" to add content from the   
clipboard copy/paste buffer and update the launcher.

The "Date" quicklist item is permanment.
Have a look at the file ~/.quicksnips/date.sh for format options.

The snippets are sent to the "-selection clipboard" (right mouse copy/paste and ctrl+c/ctrl+v)
To change to "-selection primary" (left mouse selection/middle click paste) you need to edit 3 files.
Open all 3 via terminal... gedit ~/.quicksnips/quicksnips.sh ~/.quicksnips/snip2clip.sh ~/.quicksnips/date.sh
There is one instance of "-selection clipboard" in each file.
Search for and replace "-selection clipboard" with "-selection primary" in all 3 files.

#### Known Bug ###################################################################
The unity launcher interprets "\n" as newline.
eg if you add a string "test1\ntest2" the quicklist item will show as 2 lines
test1
test2

It still sends the original string "test1\ntest2", when clicked on to the clipboard.
####################################################################################
