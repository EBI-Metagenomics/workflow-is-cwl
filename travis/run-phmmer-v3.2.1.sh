#!/usr/bin/env bash

export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd tools/HMMER
CMD="cwl-runner phmmer-v3.2.cwl phmmer-v3.2.test.job.yaml"
echo $CMD
$CMD