#!/usr/bin/env bash

export PATH="$HOME/cmsearch_tblout_deoverlap-0.02:$HOME/infernal-1.1.2/src:$PATH"
export PATH="$HOME/miniconda/bin:$PATH"
source activate cwl-environment

cd workflows
CMD="cwl-runner cmsearch-multimodel-wf.cwl --cores 1 --covariance_models ../tools/Infernal/cmsearch/test-input/tRNA5.c.cm --query_sequences ../tools/Infernal/cmsearch/test-input/mrum-genome.fa --clan_info ../tools/cmsearch-deoverlap/test-input/ribo.claninfo"
echo $CMD
$CMD