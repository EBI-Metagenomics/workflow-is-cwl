#!/usr/bin/env bash

export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd utils/
CMD="cwl-runner cut_fasta_headers.cwl cut_fasta_headers.test.job.yaml"
echo $CMD
$CMD