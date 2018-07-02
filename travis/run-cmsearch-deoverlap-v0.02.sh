#!/usr/bin/env bash

export PATH="$HOME/cmsearch_tblout_deoverlap-0.02:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
#echo $PATH
source activate cwl-environment

cd tools/cmsearch-deoverlap
CMD="cwl-runner --no-container cmsearch-deoverlap-v0.02.cwl cmsearch-deoverlap-v0.02.test.job.yaml"
echo $CMD
$CMD