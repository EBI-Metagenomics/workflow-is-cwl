#!/usr/bin/env bash

export PATH="$HOME/interproscan5:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd tools/InterProScan
CMD="cwltool --validate InterProScan-v5.cwl"
echo $CMD
$CMD