#!/bin/bash

#pull deck
cd ./ygopro-ocg/deck
git pull
cd ../..
#run ygopro
cd ./ygopro-ocg
./ygopro
cd ..
#push deck
cd ./ygopro-ocg/deck
./push-deck.sh
cd ../..
