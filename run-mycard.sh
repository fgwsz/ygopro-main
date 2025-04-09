#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_deck.sh"

#check install/mycard-main
mycard_main_path="$root_path/install/mycard-main"
if [[ ! -e "$mycard_main_path" ]]; then
    cd "$root_path/install"
    git clone "git@github.com:fgwsz/mycard-main.git"
    "$mycard_main_path/install.sh"
    "$mycard_main_path/build.sh"
fi
#check mycard ygopro
mcpro_path=~/.config/MyCardLibrary/ygopro
if [ ! -e "$mcpro_path" ]; then
    "$mycard_main_path/run.sh"
    exit 1
fi
#update super pre
"$root_path/update-super-pre.sh"
#check mycard ygopro/deck
pull_deck "$mcpro_path"
#run mycard
"$mycard_main_path/run.sh"
#push deck
push_deck "$mcpro_path" "ocg"
