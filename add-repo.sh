#!/bin/bash

BASEDIR=/export/witham3/cdnot/docs
REPODIR=/export/witham3/docs-repos
REPOURL=$1
if [ -z "$1"]
then
  echo "No repository supplied"
  exit 0
fi
REPOGIT=${REPOURL##*/}
REPO="${REPOGIT%.*}"
TEMPLATE="for FILE in $REPO/docs/*
do
  fn=\$(basename \$FILE)
  bash update-repo.sh $REPO \$fn
done"

cd $REPODIR
git clone $REPOURL

if [ -z "$2" ]
then
  echo "$TEMPLATE" >> update-docs.sh
else
  FN=$2
  echo "bash update-repo.sh $REPO $FN" >> update-docs.sh
fi
cd $BASEDIR
