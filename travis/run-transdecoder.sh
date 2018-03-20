#!/usr/bin/env bash

export PATH="$HOME/TransDecoder-TransDecoder-v5.0.2:$PATH"
echo $PATH

cd tools/TransDecoder
cwl-runner TransDecoder.LongOrfs-v5.cwl TransDecoder-v5-genetic_codes.yaml --transcriptsFile test_single_protein.fasta