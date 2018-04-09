#!/usr/bin/env bash

travis/install-cwl-runner.sh
wget wget http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-linux-intel-x86_64.tar.gz
tar -xvzf hmmer-3.1b2-linux-intel-x86_64.tar.gz -C $HOME