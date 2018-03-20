#!/usr/bin/env bash

cd tools/InterProScan/
cwl-runner InterProScan-v5.cwl InterProScan-apps.yaml --proteinFile test_single_protein.fasta