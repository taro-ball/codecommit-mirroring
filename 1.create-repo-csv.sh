#!/bin/bash

echo Please remember to authenticate as CommonTools account.
echo This may take a couple of minutes. Run "tail -f tmp-repo-list.json" in another tab if you want to check the progress.

# Get repo properties list: 
aws codecommit list-repositories | jq '.repositories[].repositoryName' | grep \"hip | xargs -L 1 aws codecommit get-repository --repository-name | jq ".repositoryMetadata | {repositoryName,repositoryDescription,cloneUrlHttp, lastModifiedDate,creationDate}" > tmp-repo-list.json

# Add commas and brackets to make it a proper json array:
sed -z 's/}\n{/},\n{/g' tmp-repo-list.json | sed '1i[' | sed '$a]' > tmp-proper-list.json

# convert to csv:
jq -r '(.[0] | keys_unsorted) as $keys | $keys, map([.[ $keys[] ]])[] | @csv' tmp-proper-list.json > tmp-detail-list.csv
