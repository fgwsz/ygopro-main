#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
source "$root_path/lib_deck.sh"

ygopro_408_path="$root_path/ygopro-408"
#update ygopro
"$root_path/update-ygopro.sh"
#check ygopro-408/deck
pull_deck "$ygopro_408_path"
#run ygopro-408
cd "$ygopro_408_path"
./ygopro
#push deck
push_deck "$ygopro_408_path" "408"
