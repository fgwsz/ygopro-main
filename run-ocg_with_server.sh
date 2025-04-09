#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_deck.sh"
source "$root_path/lib_ygopro_launch_with_server.sh"

ygopro_ocg_path="$root_path/ygopro-ocg"
#update ygopro
"$root_path/update-ygopro.sh"
#check ygopro-ocg/deck
pull_deck "$ygopro_ocg_path"
#run ygopro-ocg
ygopro_launch_with_server "$ygopro_ocg_path"
#push deck
push_deck "$ygopro_ocg_path" "ocg"
