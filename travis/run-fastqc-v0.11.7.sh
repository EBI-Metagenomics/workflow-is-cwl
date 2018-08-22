#!/usr/bin/env bash

APP_VERSION=0.11.7
export PATH="$HOME/diamond-v$APP_VERSION:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
echo $PATH
source activate cwl-environment

cd tools/FastQC
CMD="cwl-runner --no-container FastQC-v0.11.7.cwl FastQC-V0.11.7.test.job.yaml"
echo $CMD
$CMD