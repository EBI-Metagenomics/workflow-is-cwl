#!/usr/bin/env bash

APP_VERSION=3.2.1
travis/install-cwl-runner.sh
wget http://eddylab.org/software/hmmer/hmmer-$APP_VERSION.tar.gz
mkdir $HOME/temp
tar -xvzf hmmer-$APP_VERSION.tar.gz -C $HOME/temp
cd $HOME/temp/hmmer-$APP_VERSION
./configure --prefix $HOME/hmmer-$APP_VERSION
make -j
make install
cd easel
make install