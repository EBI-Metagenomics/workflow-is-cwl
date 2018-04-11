#!/usr/bin/env bash

export PATH="$HOME/TransDecoder-TransDecoder-v5.0.2:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd workflows
CMD="cwl-runner TransDecoder-v5-wf-2steps.cwl --transcriptsFile ../tools/TransDecoder/test-input/test_transcripts.fasta --singleBestOnly"
echo $CMD
$CMD