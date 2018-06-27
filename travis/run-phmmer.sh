#!/usr/bin/env bash

export PATH="$HOME/hmmer-3.1b2-linux-intel-x86_64/binaries:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
#echo $PATH
source activate cwl-environment

cd tools/HMMER
CMD="cwl-runner --no-container phmmer-v3.1b2.cwl phmmer-v3.1b2.test.job.yaml"
echo $CMD
$CMD