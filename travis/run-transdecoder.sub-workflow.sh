#!/usr/bin/env bash

export PATH="$HOME/TransDecoder-TransDecoder-v5.0.2:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd workflows
CMD="cwl-runner --no-container TransDecoder-v5-wf-2steps.cwl TransDecoder-v5-wf-2steps.test.job.yaml"
echo $CMD
$CMD