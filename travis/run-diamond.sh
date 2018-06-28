#!/usr/bin/env bash

export PATH="$HOME/diamond-v0.9.18:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
#echo $PATH
source activate cwl-environment

cd tools/Diamond
CMD="cwl-runner --no-container Diamon.blastx-v0.9.18.cwl Diamon.blastx-v0.9.18.test.job.yaml"
echo $CMD
$CMD