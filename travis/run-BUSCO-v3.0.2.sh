#!/usr/bin/env bash

export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd tools/BUSCO
CMD="cwl-runner BUSCO-v3.cwl BUSCO-v3.test.job.yaml"
echo $CMD
$CMD