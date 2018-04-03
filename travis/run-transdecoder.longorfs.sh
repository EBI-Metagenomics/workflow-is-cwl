#!/usr/bin/env bash

export PATH="$HOME/TransDecoder-TransDecoder-v5.0.2:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
#echo $PATH
source activate cwl-environment

cd tools/TransDecoder
CMD="cwl-runner TransDecoder.LongOrfs-v5.cwl TransDecoder-v5-genetic_codes.yaml --transcriptsFile test-input/test_transcripts.fasta"
echo $CMD
$CMD
