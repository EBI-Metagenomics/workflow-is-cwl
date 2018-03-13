#!/usr/bin/env bash

cd tools/InterProScan/
cwl-runner InterProScan-5.cwl InterProScan-apps.yaml --proteinFile test_single_protein.fasta