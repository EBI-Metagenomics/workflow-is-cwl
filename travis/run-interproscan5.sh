#!/usr/bin/env bash

export PATH="$HOME/interproscan5:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd tools/InterProScan
cwl-runner InterProScan-v5.cwl InterProScan-apps.yaml --proteinFile test_single_protein.fasta