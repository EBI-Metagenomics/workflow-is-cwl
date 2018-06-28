#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}

inputs:
  query_sequences: File
  covariance_models: File[]
  clan_info: File
  cores: int

outputs:
  deoverlapped_matches:
    type: File
    outputSource: remove_overlaps/deoverlapped_matches

steps:
  cmsearch:
    run: ../tools/Infernal/cmsearch/infernal-cmsearch-v1.1.2.cwl
    in:
      query_sequences: query_sequences
      covariance_model_database: covariance_models
      only_hmm: { default: true }
      omit_alignment_section: { default: true }
      search_space_size: { default: 1000 }
#      TODO: For some model files, e.g. tRNA5, the GA bit threshold is unavailable
#      cut_ga: { default: true }
      cpu: cores
    out: [ matches, programOutput ]
    scatter: covariance_model_database

  concatenate_matches:
    run: ../tools/utils/concatenate.cwl
    in:
      files: cmsearch/matches
    out: [ result ]

  remove_overlaps:
    run: ../tools/cmsearch-deoverlap/cmsearch-deoverlap.cwl
    in:
      cmsearch_matches: concatenate_matches/result
      clan_information: clan_info
    out: [ deoverlapped_matches ]