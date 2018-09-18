#!/usr/bin/env bash

export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd tools/TransDecoder
CMD="cwl-runner TransDecoder.LongOrfs-v5.cwl TransDecoder.LongOrfs-v5.test.job.yaml"
echo $CMD
$CMD