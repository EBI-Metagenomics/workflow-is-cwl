#!/usr/bin/env bash

#export PATH="tools/InterProScan:$PATH"
#echo $PATH
#bash interproscan.sh

mkdir $HOME/InterProScan
cp interproscan.sh $HOME/InterProScan
export PATH="$HOME/InterProScan:$PATH"
echo $PATH
bash interproscan.sh

cd tools/InterProScan/
cwl-runner InterProScan-v5.cwl InterProScan-apps.yaml --proteinFile test_single_protein.fasta