#!/usr/bin/env bash

export PATH="$HOME/infernal-1.1.2/src:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
#echo $PATH
source activate cwl-environment

cd tools/Infernal/cmsearch
CMD="cwl-runner --no-container infernal-cmsearch-v1.1.2.cwl infernal-cmsearch.test.job.yaml"
echo $CMD
$CMD