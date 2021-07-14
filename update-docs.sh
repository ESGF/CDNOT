#!/bin/bash

BASEDIR=~/cdnot/docs
REPOS=~/docs-repos

bash update-repo.sh $REPOS/esgf-docker/docs deploy-ansible.md
for FILE in $REPOS/esgf-docker/docs/kubernetes/*
do
  fn=$(basename $FILE)
  bash update-repo.sh $REPOS/esgf-docker/docs/kubernetes $fn
done
bash update-repo.sh $REPOS/esgf.github.io idp-registration.md
bash update-repo.sh $REPOS/esgf.github.io idp_user_accounts.md
