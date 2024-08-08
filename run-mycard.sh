#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
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
#check mycard ygopro/deck
deck_path="$mcpro_path/deck"
if [[ ! -e "$deck_path/.git" ]]; then
    cd "$mcpro_path"
    git clone "git@github.com:fgwsz/ygopro-deck.git"
    mv "$deck_path"/*.ydk "$mcpro_path/ygopro-deck/ocg/"
    "$mcpro_path/ygopro-deck/push-deck.sh"
    rm -rf "$deck_path"
    mv "$mcpro_path/ygopro-deck" "$mcpro_path/deck"
else
    cd "$deck_path"
    git pull
fi
#check mycard ygopro/super pre
if [[ ! -e "$mcpro_path/expansions/ygopro-super-pre.ypk" ]]; then
    super_pre_path="$root_path/install/ygopro-super-pre.ypk"
    if [[ ! -e "$super_pre_path" ]]; then
        super_pre_download_url="https://cdn02.moecube.com:444/ygopro-super-pre/archive/ygopro-super-pre.ypk"
        curl -C - -o "$super_pre_path" "$super_pre_download_url"
    fi
    cp "$super_pre_path" "$mcpro_path/expansions/"
fi
#run mycard
"$mycard_main_path/run.sh"
#push deck
mv "$deck_path"/*.ydk "$deck_path/ocg/"
"$deck_path/push-deck.sh"
