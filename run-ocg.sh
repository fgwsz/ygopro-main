#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
#pull deck
cd "$root_path/ygopro-ocg/deck"
git pull
#run ygopro
cd "$root_path/ygopro-ocg"
./ygopro
#push deck
cd "$root_path/ygopro-ocg/deck"
./push-deck.sh

cd "$root_path"
