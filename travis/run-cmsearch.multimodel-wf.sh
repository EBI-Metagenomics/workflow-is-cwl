#!/usr/bin/env bash

export PATH="$HOME/cmsearch_tblout_deoverlap-0.02:$HOME/infernal-1.1.2/src:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd workflows
CMD="cwl-runner --no-container cmsearch-multimodel-wf.cwl cmsearch-multimodel-wf.test.job.yaml"
echo $CMD
$CMD