#!/bin/bash

root_path=$(dirname "$(readlink -f "$0")")
echo "You Can Input q For Abort."
read -p "Input Git Commit Info: " commit_info
if [ "$commit_info" != "q" ]; then
    cd "$root_path"
    git add install/ocg-ext/*
    git add install/mcpro-ext/*
    git add install/408-ext/*
    git add install/2011_11_11-ext/*
    git add install/.gitignore
    git add -f ygopro-ocg/.gitignore
    git add -f ygopro-408/.gitignore
    git add -f ygopro-2011_11_11/.gitignore
    git add update-*.sh
    git add run-*.sh
    git add install.sh
    git add git-push.sh
    git add .gitignore
    git add account.csv
    git add duel_servers.csv
    git add lib_ygopro_launch_with_server.sh
    git add README.md
    git commit -m "$commit_info"
    git push
fi
