#!/usr/bin/env bash

travis/install-cwl-runner.sh
wget https://github.com/TransDecoder/TransDecoder/archive/TransDecoder-v5.0.2.tar.gz
tar -xvzf TransDecoder-v5.0.2.tar.gz -C $HOME