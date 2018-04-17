#!/usr/bin/env bash

export PATH="$HOME/infernal-1.1.2/src:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
#echo $PATH
source activate cwl-environment

cd tools/Infernal/cmsearch
CMD="cwl-runner infernal-cmsearch.cwl --covariance_model_database test-input/tRNA5.c.cm --query_sequences test-input/mrum-genome.fa"
echo $CMD
$CMD