#!/usr/bin/env bash

travis/install-cwl-runner.sh
wget https://github.com/nawrockie/cmsearch_tblout_deoverlap/archive/0.02.tar.gz
tar -xvzf 0.02.tar.gz -C $HOME
chmod +x -R $HOME/cmsearch_tblout_deoverlap-0.02