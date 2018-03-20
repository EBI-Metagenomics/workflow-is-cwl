#!/usr/bin/env bash

export PATH="tools/InterProScan:$PATH"
echo $PATH
bash interproscan.sh

cwl-runner InterProScan-v5.cwl InterProScan-apps.yaml --proteinFile test_single_protein.fasta