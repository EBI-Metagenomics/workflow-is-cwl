class: Workflow
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com'
inputs:
  - id: clan_info
    type: File
  - id: cores
    type: int
  - id: covariance_models
    type: File[]
  - id: query_sequences
    type: File
outputs:
  - id: deoverlapped_matches
    outputSource:
      - remove_overlaps/deoverlapped_matches
    type: File
steps:
  - id: cmsearch
    in:
      - id: covariance_model_database
        source: covariance_models
      - id: cpu
        source: cores
      - id: omit_alignment_section
        default: true
      - id: only_hmm
        default: true
      - id: query_sequences
        source: query_sequences
      - id: search_space_size
        default: 1000
    out:
      - id: matches
      - id: programOutput
    run: ../tools/Infernal/cmsearch/infernal-cmsearch-v1.1.2.cwl
    label: Search sequence(s) against a covariance model database
    scatter:
      - covariance_model_database
  - id: concatenate_matches
    in:
      - id: files
        source:
          - cmsearch/matches
    out:
      - id: result
    run: ../tools/utils/concatenate.cwl
  - id: remove_overlaps
    in:
      - id: clan_information
        source: clan_info
      - id: cmsearch_matches
        source: concatenate_matches/result
    out:
      - id: deoverlapped_matches
    run: ../tools/cmsearch-deoverlap/cmsearch-deoverlap-v0.02.cwl
    label: Remove lower scoring overlaps from cmsearch --tblout files.
requirements:
  - class: ScatterFeatureRequirement
'sbg:wrapperAuthor': Maxim Scheremetjew
