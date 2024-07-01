#!/bin/bash
ygopro_filename="KoishiPro-master-linux-zh-CN.tar.gz"
tar -zxvf "./install/$ygopro_filename" -C ./ygopro-ocg/
tar -zxvf "./install/$ygopro_filename" -C ./ygopro-408/
./update-ext.sh
rm -rf ./ygopro-ocg/deck/*
rm -rf ./ygopro-408/deck/*
./update-deck.sh
