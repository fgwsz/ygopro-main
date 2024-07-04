#!/bin/bash

#pull deck
cd ./ygopro-408/deck
git pull
cd ../..
#run ygopro
cd ./ygopro-408
./ygopro
cd ..
#push deck
cd ./ygopro-408/deck
./push-deck.sh
cd ../..
