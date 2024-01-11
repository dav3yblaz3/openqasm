#!/bin/bash
# This script makes sure a reno has been updated in the PR.

#reno lint

git fetch origin main
CHANGED_FILES=$(git diff --name-only origin/main $GITHUB_SHA)

echo Changed files
echo $CHANGED_FILES

for file in $CHANGED_FILES
do
   root=$(echo "./$file" | awk -F/ '{print FS $2}' | cut -c2-)
   if [ "$root" = "releasenotes" ]; then
       echo "Reno added or updated: $file"
       exit 0;
   fi
done

echo Please add or update a release note in ./releasenotes >&2
exit 1
