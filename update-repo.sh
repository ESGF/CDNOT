#!/bin/bash

ENV=docs
bash ./conda.sh
. ~/.bashrc
conda activate $ENV
REPO=$1
FILE=$2
BASEDIR=~/cdnot/docs
WD=$(pwd)

cd $REPO
git pull
m2r $FILE
RSTFILE="${FILE%.*}.rst"
dif=$(diff -q $RSTFILE $BASEDIR/$RSTFILE | wc -l)

if (($dif > 0))
then
  echo files are different!
  cp $RSTFILE $BASEDIR/$RSTFILE
  cd $BASEDIR
  git add $RSTFILE
  commitstr="updated $RSTFILE"
  git commit -m "$commitstr"
  echo "New changes to CDNOT docs, review and push." | sendmail witham3@llnl.gov 
fi

cd $BASEDIR
rm $REPO/$RSTFILE
