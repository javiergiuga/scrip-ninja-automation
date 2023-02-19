#!/bin/bash
# table utils
source ./scrip-ninja-automation/shopping-cart/printTable.sh
# check version
if [ -z "$VERSION" ]
      then
      VERSION=`jq -r '.version' ./shopping-cart/package.json`
      
fi

#get reponame
git_url=$(basename $(git config --get remote.origin.url))
REPONAME=${git_url/\.git/''}
AUTOMATION_SHORT=$(cd scrip-ninja-automation/shopping-cart;git rev-parse --short HEAD)
AUTOMATION_BRANCH_NAME=$(cd scrip-ninja-automation/shopping-cart;git rev-parse --abbrev-ref HEAD)
GIT_SHORT=$(git rev-parse --short HEAD) 
GIT_LAST_TAG=$(git tag --sort=committerdate|tail -n 1)  > /dev/null 2>&1
#get BRANCH_NAME from  GIT
if [ -z $GIT_BRANCH ]; then
  BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
else 
  BRANCH_NAME=$GIT_BRANCH
fi

# check repository
if [ -z "$REPOSITORY" ]
then
      REPOSITORY="$REPONAME"
fi
# check REGISTRY
if [ -z "$REGISTRY" ]
then
      REGISTRY="javiergiuga"
fi
# check NAME CONTAINER
if [ -z "$NAMES" ]
then
      NAMES="ms-shopping-$BRANCH_NAME"
fi

# check git user
if [ -z "$GITLAB_USER_LOGIN" ]
      then
            GIT_USER=$(git log -1 --pretty=format:'%an')
      else
            GIT_USER=$GITLAB_USER_LOGIN
fi
# check git user_email
if [ -z "$GITLAB_USER_EMAIL" ]
      then
            GIT_USER_EMAIL=$(git log -1 --pretty=format:'%ae')
      else
            GIT_USER_EMAIL=$GITLAB_USER_EMAIL
fi
# echo result

echo -e "\n\e[1;32m»» AUTOMATION: $AUTOMATION_SHORT $AUTOMATION_BRANCH_NAME \e[1;34m"
printTable ',' "$(cat <<EOF
VAR,VALUE
GIT_SHORT,$GIT_SHORT
BRANCH_NAME,$BRANCH_NAME 
REGISTRY,$REGISTRY
NAMES,$NAMES 
VERSION,$VERSION 
REPOSITORY,$REPOSITORY 
DOCKER_IMAGENAME,$REGISTRY/$NAMES:$VERSION
GIT_USER,$GIT_USER 
GIT_USER_EMAIL,$GIT_USER_EMAIL 

EOF
)
"
echo -e "\e[0m \n\n\n"
set +x