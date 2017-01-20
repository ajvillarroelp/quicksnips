#!/bin/bash

snipfile=$HOME/.quicksnips/snippets.txt

snip=$( sed -r '/^#|^\s*$/d' "$snipfile" | sort | sed -n $1p )
printf '%s' "$snip" | xclip -i -selection clipboard 
