#!/usr/bin/env bash

ls -l $HOME/hmmer-3.1b2-linux-intel-x86_64/binaries
export PATH="$HOME/hmmer-3.1b2-linux-intel-x86_64/binaries:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
echo $PATH
source activate cwl-environment

cd tools/HMMER
CMD="cwl-runner phmmer-v3.1b2.cwl --seqFile test-input/HBB_HUMAN --seqdb test-input/globins45.fa"
echo $CMD
$CMD