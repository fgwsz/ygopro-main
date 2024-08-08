#!/bin/bash

#download ygopro
root_path=$(dirname "$(readlink -f "$0")")
ygopro_path="$root_path/install/ygopro.tar.gz"
if [[ -e "$ygopro_path" ]]; then
    rm -rf "$ygopro_path"
fi
ygopro_download_url="https://cdn02.moecube.com:444/koishipro/archive/KoishiPro-master-linux-zh-CN.tar.gz"
curl -C - -o "$ygopro_path" "$ygopro_download_url"
tar -zxvf "$ygopro_path" -C "$root_path/ygopro-ocg/"
tar -zxvf "$ygopro_path" -C "$root_path/ygopro-408/"
#reset ext
cp -r "$root_path/install/ocg-ext"/* "$root_path/ygopro-ocg/"
cp -r "$root_path/install/408-ext"/* "$root_path/ygopro-408/"
#reset deck
ygopro_deck_path="$root_path/install/ygopro-deck"
if [[ ! -e "$ygopro_deck_path" ]]; then
    cd "$root_path/install"
    git clone "git@github.com:fgwsz/ygopro-deck.git"
else
    cd "$ygopro_deck_path"
    git pull
fi
mv -f "$root_path/ygopro-ocg/deck"/*.ydk "$ygopro_deck_path/ocg/"
"$ygopro_deck_path/push-deck.sh"
rm -rf "$root_path/ygopro-ocg/deck"
rm -rf "$root_path/ygopro-408/deck"
cp -r "$ygopro_deck_path" "$root_path/ygopro-ocg/deck"
cp -r "$ygopro_deck_path" "$root_path/ygopro-408/deck"
#update super pre
"$root_path/update-super-pre.sh"
