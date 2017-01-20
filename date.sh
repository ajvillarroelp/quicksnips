#!/bin/bash

# Current out put is yyyy-mm-dd_HH:MM   eg...2013-10-31_12:17   See date --help


## mouse middle click
#date +"%Y-%m-%d_%H:%M" | tr -d '\n' | xclip

## clipboard ctrl+v
date +"%Y-%m-%d_%H:%M" | tr -d '\n' | xclip -selection clipboard
