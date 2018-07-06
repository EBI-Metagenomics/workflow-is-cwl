#!/usr/bin/env bash

APP_VERSION=3.2.1
travis/install-cwl-runner.sh
wget http://eddylab.org/software/hmmer/hmmer-$APP_VERSION.tar.gz
tar -xvzf hmmer-$APP_VERSION.tar.gz -C $HOME
cd hmmer-$APP_VERSION
./configure
make -j
make install
cd easel
make install