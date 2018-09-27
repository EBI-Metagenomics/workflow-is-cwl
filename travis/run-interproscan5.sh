#!/usr/bin/env bash

export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd tools/InterProScan
CMD="cwl-runner InterProScan-v5.cwl InterProScan-v5.test.job.yaml"
echo $CMD
$CMD