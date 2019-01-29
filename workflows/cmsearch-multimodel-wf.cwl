class: Workflow
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'http://schema.org/'
label: Identifies non-coding RNAs using Rfams covariance models
inputs:
  clan_info:
    type: File
  cores:
    type: int
  covariance_models:
    type: File[]
  query_sequences:
    type: File
outputs:
  deoverlapped_matches:
    outputSource: remove_overlaps/deoverlapped_matches
    type: File
steps:
  cmsearch:
    label: Search sequence(s) against a covariance model database
    run: ../tools/Infernal/cmsearch/infernal-cmsearch-v1.1.2.cwl
    scatter: [ covariance_model_database ]
    scatterMethod: dotproduct
    in:
      covariance_model_database: covariance_models
      cpu: cores
      omit_alignment_section:
        default: true
      only_hmm:
        default: true
      query_sequences: query_sequences
      search_space_size:
        default: 1000
    out:
      - matches
      - programOutput
  concatenate_matches:
    run: ../utils/concatenate.cwl
    in:
      files: cmsearch/matches
    out:
      - result
  remove_overlaps:
    label: Remove lower scoring overlaps from cmsearch --tblout files.
    run: ../tools/cmsearch-deoverlap/cmsearch-deoverlap-v0.02.cwl
    in:
      clan_information: clan_info
      cmsearch_matches: concatenate_matches/result
    out:
      - deoverlapped_matches
requirements:
  - class: ScatterFeatureRequirement
$schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'
's:copyrightHolder': EMBL - European Bioinformatics Institute
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'
's:author': Maxim Scheremetjew
