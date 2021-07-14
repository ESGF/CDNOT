#!/bin/bash

BASEDIR=~/cdnot/docs
REPODIR=~/docs-repos
REPO=$1
WD=$(pwd)
if [ -z "$1"]
then
  echo "No repository supplied."
  exit 1
fi

cp $BASEDIR/index.rst $BASEDIR/.index.rst.bak

cd $REPODIR/$REPO

if [ -z "$2" ]
then
  echo "No filename supplied."
  exit 1
else
  FN=$2
  echo "bash update-repo.sh $REPODIR/$REPO $FN" >> update-docs.sh
  BASEFN="${FN%.*}"
  sed -i '/idp_user_accounts/ a \   $BASEFN' $BASEDIR/index.rst
fi
cd $BASEDIR
git add index.rst .index.rst.bak
git commit -m "updated toc tree"
echo "New changes to CDNOT docs, review and push." | sendmail witham3@llnl.gov 
