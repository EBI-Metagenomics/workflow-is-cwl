#!/usr/bin/env bash

export PATH="$HOME/miniconda/bin:$PATH"
export PATH="$HOME/infernal-1.1.2/src:$PATH"
source activate cwl-environment

cd workflows
CMD="cwl-runner cmsearch-multimodel-wf.cwl cmsearch-multimodel-wf.test.job.yaml"
echo $CMD
$CMD