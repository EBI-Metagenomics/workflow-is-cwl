#!/usr/bin/env bash

export PATH="$HOME/TransDecoder-TransDecoder-v5.0.2:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
#echo $PATH
source activate cwl-environment

cd tools/TransDecoder
CMD="cwl-runner --no-container TransDecoder.LongOrfs-v5.cwl TransDecoder.LongOrfs-v5.test.job.yaml"
echo $CMD
$CMD