#!/bin/bash
ygopro_filename="KoishiPro-master-linux-zh-CN.tar.gz"
tar -zxvf "./install/$ygopro_filename" -C ./ygopro-ocg/
tar -zxvf "./install/$ygopro_filename" -C ./ygopro-408/
./update-ext.sh
./update-deck.sh
