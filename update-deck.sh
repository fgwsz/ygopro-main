#!/bin/bash
cd ./install/ygopro-deck/
git pull
cd ../..
cp -r ./install/ygopro-deck/* ./ygopro-ocg/deck/
cp -r ./install/ygopro-deck/* ./ygopro-408/deck/
