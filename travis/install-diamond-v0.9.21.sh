#!/usr/bin/env bash

travis/install-cwl-runner.sh
wget http://github.com/bbuchfink/diamond/releases/download/v0.9.21/diamond-linux64.tar.gz
mkdir $HOME/diamond-v0.9.21
tar -xvzf diamond-linux64.tar.gz -C $HOME/diamond-v0.9.21