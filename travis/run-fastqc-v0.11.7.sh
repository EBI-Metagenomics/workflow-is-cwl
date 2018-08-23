#!/usr/bin/env bash

APP_VERSION=0.11.7
export PATH="$HOME/FastQC-v$APP_VERSION/FastQC:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
echo $PATH
source activate cwl-environment

cd tools/FastQC
CMD="cwl-runner --no-container FastQC-v$APP_VERSION.cwl FastQC-v$APP_VERSION.test.job.yaml"
echo $CMD
$CMD