#!/usr/bin/env bash

APP_VERSION=3.2.1
travis/install-cwl-runner.sh
wget http://eddylab.org/software/hmmer/hmmer-$APP_VERSION.tar.gz
tar -xvzf hmmer-$APP_VERSION.tar.gz -C $HOME/src
cd $HOME/src/hmmer-$APP_VERSION
./configure --prefix $HOME/hmmer-$APP_VERSION
make -j
make install
cd easel
make install