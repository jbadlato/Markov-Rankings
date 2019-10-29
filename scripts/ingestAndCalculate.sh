#!/bin/sh
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"/..
node ./build/scripts/ingest.js
psql $BACKEND_DATABASE_URL < ./db/scripts/UPDATE_TEAM_CONFERENCES.sql
psql $BACKEND_DATABASE_URL < ./db/scripts/UPDATE_TEAM_LOGO_FILES.sql
psql $BACKEND_DATABASE_URL < ./db/scripts/UPDATE_SCHEDULED_IND.sql
psql $BACKEND_DATABASE_URL < ./db/scripts/DELETE_CANCELLED_GAMES.sql
psql $BACKEND_DATABASE_URL < ./db/scripts/UPDATE_WIN_LOSS_RECORDS.sql
node ./build/scripts/calculateRankings.js
