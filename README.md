This script is using GitLab API to create mirrors of CodeCommit git repos in GitLab. The script only creates the mirror, it does not copy any files around. After a mirror is  created, GitLab pulls the files from CodeCommit via git protocol and keeps repos in sync automatically. So the script only needs to be re-run when new repos are added to CodeCommit.

At the moment the script only adds mirrors, it does not clean up the old ones when the repo is renamed or deleted. In this case you need to clean up manually.

NOTE: the region is hardcoded as ap-southeast-2

## Prerequisites:
* AWS cloud shell or other internet connected machine with aws CLI, bash, node and jq (so far only tested on linux)
* Gitlab API token (has ‘api’ scope), you can create tokens under https://gitlab.com/-/profile/personal_access_tokens
* CodeCommit credentials 

## Process:
1. Open the AWS CloudShell and authenticate with AWS account holding the repos you want to mirror (e.g. using AWS environment variables)

1. Clone this repo 

1. Create the CSV repo list by running `1.create-repo-csv.sh`

1. (optional) open the CSV list with excel and review/delete the repos you don’t want to sync

1. install Newman by running `2.newman_install.sh`

1. Create the mirrors in GitLab by running `3.create-mirrors.sh` with 3 parameters in the following order: GitLab token, CodeCommit user, CodeCommit password.  
eg. : `./3.create-mirrors.sh MyT0keNLoNGsTr1nG aws-git-user pas$W0rD`
