#!/usr/bin/env bash

export PATH="$HOME/diamond-v0.9.18:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
#echo $PATH
source activate cwl-environment

cd tools/Diamond
CMD="cwl-runner Diamon.blastx-v0.9.18.cwl Diamond-strand_values.yaml --databaseFile test-input/uniref90_subset.dmnd --queryInputFile test-input/test_transcripts.fasta --strand plus"
echo $CMD
$CMD