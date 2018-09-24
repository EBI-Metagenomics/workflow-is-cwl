#!/usr/bin/env bash

export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd tools/Diamond
CMD="cwl-runner Diamon.makedb-v0.9.21.cwl Diamon.makedb-v0.9.21.test.job.yaml"
echo $CMD
$CMD