#!/usr/bin/env bash

export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd tools/TransDecoder
CMD="cwl-runner TransDecoder.Predict-v5.cwl TransDecoder.Predict-v5.test.job.yaml"
echo $CMD
$CMD