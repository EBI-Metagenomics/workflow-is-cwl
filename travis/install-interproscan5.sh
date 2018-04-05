#!/usr/bin/env bash

travis/install-cwl-runner.sh
mkdir $HOME/interproscan5
cd $HOME/interproscan5
wget https://raw.githubusercontent.com/mscheremetjew/workflow-is-cwl/master/tools/InterProScan/interproscan.sh
chmod +x interproscan.sh