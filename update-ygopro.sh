#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
ygopro_path="$root_path/install/ygopro.tar.gz"
ygopro_download_url="https://cdn02.moecube.com:444/koishipro/archive/KoishiPro-master-linux-zh-CN.tar.gz"
ygopro_remote_size=$(curl -sI "$ygopro_download_url" | grep -i Content-Length | awk '{print $2}' | tr -d '\r')
download_flag=false
#check remote ygopro size
if [ -z "$ygopro_remote_size" ]; then
    download_flag=true
    echo "Unable to retrieve the size of the remote ygopro file."
fi
ygopro_remote_size=${ygopro_remote_size% }
if [ -f "$ygopro_path" ]; then
    ygopro_size=$(stat -c%s "$ygopro_path")
else
    download_flag=true
    echo "install/ygopro file does not exist."
fi
if [ "$ygopro_remote_size" -eq "$ygopro_size" ]; then
    download_flag=false
    echo "install/ygopro is up to date."
else
    download_flag=true
    echo "ygopro has updates available."
fi
#update install/ygopro
if [ $download_flag = true ]; then
    while true; do
        if [[ -e "$ygopro_path" ]]; then
            rm -rf "$ygopro_path"
        fi
        curl -C - -o "$ygopro_path" "$ygopro_download_url"
        if [ $? -eq 0 ]; then
            break
        fi
    done
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-ocg/"
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-408/"
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-2011_11_11/"
    #reset ext
    cp -r "$root_path/install/ocg-ext"/* "$root_path/ygopro-ocg/"
    cp -r "$root_path/install/408-ext"/* "$root_path/ygopro-408/"
    cp -r "$root_path/install/2011_11_11-ext"/* "$root_path/ygopro-2011_11_11/"
    #reset deck
    ygopro_deck_path="$root_path/install/ygopro-deck"
    if [[ ! -e "$ygopro_deck_path" ]]; then
        cd "$root_path/install"
        git clone "git@github.com:fgwsz/ygopro-deck.git"
    else
        cd "$ygopro_deck_path"
        git pull
    fi
    if find "$root_path/ygopro-ocg/deck" -maxdepth 1 -type f -name "*.ydk" | grep -q .; then
        mv -f "$root_path/ygopro-ocg/deck"/*.ydk "$ygopro_deck_path/ocg/"
    fi 
    rm -rf "$root_path/ygopro-ocg/deck"
    rm -rf "$root_path/ygopro-408/deck"
    rm -rf "$root_path/ygopro-2011_11_11/deck"
    cp -r "$ygopro_deck_path" "$root_path/ygopro-ocg/deck"
    cp -r "$ygopro_deck_path" "$root_path/ygopro-408/deck"
    cp -r "$ygopro_deck_path" "$root_path/ygopro-2011_11_11/deck"
    "$ygopro_deck_path/push-deck.sh"
fi
#check ygopro ocg
if [ ! -e "$root_path/ygopro-ocg/ygopro" ]; then
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-ocg/"
    #reset ext
    cp -r "$root_path/install/ocg-ext"/* "$root_path/ygopro-ocg/"
    #reset deck
    ygopro_deck_path="$root_path/install/ygopro-deck"
    if [[ ! -e "$ygopro_deck_path" ]]; then
        cd "$root_path/install"
        git clone "git@github.com:fgwsz/ygopro-deck.git"
    else
        cd "$ygopro_deck_path"
        git pull
    fi
    if find "$root_path/ygopro-ocg/deck" -maxdepth 1 -type f -name "*.ydk" | grep -q .; then
        mv -f "$root_path/ygopro-ocg/deck"/*.ydk "$ygopro_deck_path/ocg/"
    fi 
    "$ygopro_deck_path/push-deck.sh"
    rm -rf "$root_path/ygopro-ocg/deck"
    cp -r "$ygopro_deck_path" "$root_path/ygopro-ocg/deck"
fi
#check ygopro 408
if [ ! -e "$root_path/ygopro-408/ygopro" ]; then
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-408/"
    #reset ext
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
    rm -rf "$root_path/ygopro-408/deck"
    cp -r "$ygopro_deck_path" "$root_path/ygopro-408/deck"
fi
#check ygopro 2011_11_11
if [ ! -e "$root_path/ygopro-2011_11_11/ygopro" ]; then
    tar -zxvf "$ygopro_path" -C "$root_path/ygopro-2011_11_11/"
    #reset ext
    cp -r "$root_path/install/2011_11_11-ext"/* "$root_path/ygopro-2011_11_11/"
    #reset deck
    ygopro_deck_path="$root_path/install/ygopro-deck"
    if [[ ! -e "$ygopro_deck_path" ]]; then
        cd "$root_path/install"
        git clone "git@github.com:fgwsz/ygopro-deck.git"
    else
        cd "$ygopro_deck_path"
        git pull
    fi
    rm -rf "$root_path/ygopro-2011_11_11/deck"
    cp -r "$ygopro_deck_path" "$root_path/ygopro-2011_11_11/deck"
fi
#update super pre
"$root_path/update-super-pre.sh"
