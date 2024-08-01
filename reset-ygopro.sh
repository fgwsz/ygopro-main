#!/bin/bash

ygopro_filename="KoishiPro-master-linux-zh-CN.tar.gz"
ygopro_path="./install/$ygopro_filename"

tar -zxvf "$ygopro_path" -C ./ygopro-ocg/
tar -zxvf "$ygopro_path" -C ./ygopro-408/
./reset-ext.sh
./reset-deck.sh
./reset-ygopro-super-pre.sh
