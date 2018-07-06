#!/usr/bin/env bash

export PATH="$HOME/hmmer-3.2.1:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
echo $PATH
source activate cwl-environment

cd tools/HMMER
CMD="cwl-runner --no-container phmmer-v3.2.cwl phmmer-v3.2.test.job.yaml"
echo $CMD
$CMD