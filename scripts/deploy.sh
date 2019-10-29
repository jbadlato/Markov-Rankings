#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"/..
git fetch --all
git reset --hard origin/master
./scripts/applyPatchToDB
npm install
npm run build
npm restart