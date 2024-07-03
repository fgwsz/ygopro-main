#!/bin/bash

echo "You Can Input q For Abort."
read -p "Input Git Commit Info: " commit_info
if [ "$commit_info" != "q" ]; then
    git add install/ocg-ext/*
    git add install/408-ext/*
    git add install/.gitignore
    git add -f ygopro-ocg/.gitignore
    git add -f ygopro-408/.gitignore
    git add download-*.sh
    git add reset-*.sh
    git add update-*.sh
    git add run-*.sh
    git add git-push.sh
    git add .gitignore
    git add README.md
    git commit -m "$commit_info"
    git push
fi
