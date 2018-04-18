#!/usr/bin/env bash

export PATH="$HOME/cmsearch_tblout_deoverlap-0.02:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
#echo $PATH
source activate cwl-environment

cd tools/cmsearch-deoverlap
CMD="cwl-runner cmsearch-deoverlap.cwl test-inputs.yml"
echo $CMD
$CMD