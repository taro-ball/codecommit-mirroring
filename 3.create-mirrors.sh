#!/bin/bash

if [ "$#" -ne 3 ]; then
        echo
        echo "this script takes 3 arguments in the following order: gitlab token, codecommit user, codecommit password. "
        echo 'eg.:'
        echo
        echo './3.create-mirrors.sh MyT0keNLoNGsTr1nG git-user pas$W0rD'
        echo
        echo "Wrong number of arguments, exiting..."
        echo
    exit 1
fi

gitlab_token=$1
aws_git_user=$2
aws_git_password=$3

npx newman run -d tmp-detail-list.csv --global-var "gLabToken=$gitlab_token" --global-var CClogin=${aws_git_user} --global-var CCpass=${aws_git_password} gitlab-automation.postman_collection.json | tee tmp-mirror.log
