#!/bin/bash

git fetch --all
git reset --hard origin/master
./applyPatchToDB
cd client
npm install
npm run build
cd ..
npm install
npm run build
npm restart