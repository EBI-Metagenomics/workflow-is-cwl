#!/usr/bin/env bash

APP_VERSION=0.11.7
travis/install-cwl-runner.sh
wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v$APP_VERSION.zip
mkdir $HOME/FastQC-v$APP_VERSION
unzip fastqc_v$APP_VERSION.zip -d $HOME/FastQC-v$APP_VERSION
chmod a+x $HOME/FastQC-v$APP_VERSION/FastQC/fastqc