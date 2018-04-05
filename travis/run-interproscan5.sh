#!/usr/bin/env bash

export PATH="$HOME/InterProScan:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
echo $PATH
bash interproscan.sh
source activate cwl-environment

cd tools/InterProScan
cwl-runner InterProScan-v5.cwl InterProScan-apps.yaml --proteinFile test_single_protein.fasta