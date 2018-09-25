#!/usr/bin/env bash

export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd tools/Infernal/cmsearch
CMD="cwl-runner infernal-cmsearch-v1.1.2.cwl infernal-cmsearch.test.job.yaml"
echo $CMD
$CMD