#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
#pull deck
cd "$root_path/ygopro-408/deck"
git pull
#run ygopro
cd "$root_path/ygopro-408"
./ygopro
#push deck
"$root_path/ygopro-408/deck/push-deck.sh"
