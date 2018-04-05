#!/usr/bin/env bash

export PATH="$HOME/diamond-v0.9.18:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
echo $PATH
source activate cwl-environment

cd tools/Diamond
CMD="cwl-runner Diamon.blastx-v0.9.18.cwl Diamond-strand_values.yaml --databaseFile nr.dmnd --queryInputFile test_transcripts.fasta --strand plus"
echo $CMD
$CMD