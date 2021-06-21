#!/bin/bash -x

echo this script takes 3 parameters in the following order: gitlab token, codecommit user, codecommit password. 
echo eg.: 3.create-mirrors.sh MyT0keNLoNGsTr1nG git-user pas$W0rD

gitlab_token=$1
aws_git_user=$2
aws_git_password=$3

newman run -d tmp-detail-list.csv --global-var "gLabToken=$gitlab_token" --global-var "CClogin=$aws_git_user" --global-var \"CCpass=$aws_git_password\" gitlab-automation.postman_collection.json | tee tmp-mirror.log
