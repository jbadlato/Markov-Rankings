#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"/..
tsc
cd client
npm install
npm run build
cd ..
rm -rf ./build/client
mv ./client/build ./build/client