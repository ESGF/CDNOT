#!/bin/bash

BASEDIR=/export/witham3/cdnot/docs
REPODIR=/export/witham3/docs-repos
REPOURL=$1
WD=$(pwd)
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

cp $BASEDIR/index.rst $BASEDIR/.index.rst.bak

cd $REPODIR
git clone $REPOURL

if [ -z "$2" ]
then
  echo "$TEMPLATE" >> update-docs.sh
  for FILE in $REPO/docs/*
  do
    BASEFN="${FILE%.*}"
    sed -i '/idp_user_accounts/ a \   $BASEFN' $BASEDIR/index.rst
  done
else
  FN=$2
  echo "bash update-repo.sh $REPO $FN" >> update-docs.sh
  BASEFN="${FN%.*}"
  sed -i '/idp_user_accounts/ a \   $BASEFN' $BASEDIR/index.rst
fi
cd $BASEDIR
git add index.rst .index.rst.bak
git commit -m "updated toc tree"
echo "New changes to CDNOT docs, review and push." | sendmail witham3@llnl.gov 
