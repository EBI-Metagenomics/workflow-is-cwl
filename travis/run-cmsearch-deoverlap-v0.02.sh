#!/usr/bin/env bash

export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd tools/cmsearch-deoverlap
CMD="cwl-runner cmsearch-deoverlap-v0.02.cwl cmsearch-deoverlap-v0.02.test.job.yaml"
echo $CMD
$CMD