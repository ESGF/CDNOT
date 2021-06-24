#!/bin/bash

# bash ~/esgf/conda.sh
# . ~/.bashrc
eval "$(conda shell.bash hook)"
conda activate docs
REPO=$1
FILE=$2
BASEDIR=/home/ewitham/cdnot-lw/docs

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
  git commit -m $commitstr
  git push origin master
fi

cd $BASEDIR
rm $REPO/$RSTFILE
