#!/usr/bin/env bash

export PATH="$HOME/interproscan5:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd tools/InterProScan
touch test_single_protein.fasta.i5_annotations
CMD="cwl-runner --no-container InterProScan-v5.cwl InterProScan-v5.test.job.yaml"
echo $CMD
$CMD