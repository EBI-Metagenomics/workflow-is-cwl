#!/usr/bin/env bash

travis/install-cwl-runner.sh
wget http://eddylab.org/infernal/infernal-1.1.2.tar.gz
tar -xvzf infernal-1.1.2.tar.gz -C $HOME
cd $HOME/infernal-1.1.2
./configure
make