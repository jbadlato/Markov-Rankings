#!/bin/sh
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"/..
for patch in ./db/patch_*.sql
do
	version=${patch:11:-4}
	version=${version//_/.}
	isApplied=`psql --command="SELECT COUNT(version) FROM db_version WHERE version = '$version';" -AtX $DEPLOY_DATABASE_URL` 
	if [ $isApplied -eq 0 ]
	then
		echo "Applying patch $patch for version $version"
		psql $DEPLOY_DATABASE_URL < $patch
	fi
done
