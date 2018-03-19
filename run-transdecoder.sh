#!/usr/bin/env bash

cd tools/TransDecoder/
cwl-runner TransDecoder.Predict-v5.cwl TransDecoder-v5-genetic_codes.yaml
