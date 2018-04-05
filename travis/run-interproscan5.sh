#!/usr/bin/env bash

ls -l $HOME/interproscan5
export PATH="$HOME/interproscan5:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
bash interproscan.sh
source activate cwl-environment

cd tools/InterProScan
cwl-runner InterProScan-v5.cwl InterProScan-apps.yaml --proteinFile test_single_protein.fasta