#!/usr/bin/env bash

export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd utils/
CMD="cwl-runner fasta_chunker.cwl fasta_chunker.test.job.yaml"
echo $CMD
$CMD