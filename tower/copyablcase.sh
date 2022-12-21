#!/bin/bash

mkdir $1

cd $1 

cp $2/*.yaml .
cp $2/*.inp .
cp $2/*.txt .
cp $2/*.lsf .


