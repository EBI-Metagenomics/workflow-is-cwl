class: Workflow
cwlVersion: v1.0
label: >-
  TransDecoder 2 step workflow, running TransDecoder.LongOrfs (step 1) followed
  by TransDecoder.Predict (step2)
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'http://schema.org/'
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: singleBestOnly
    type: boolean?
  - format: edam:format_1929  # FASTA
    id: transcriptsFile
    type: File
outputs:
  - id: bed_output
    outputSource:
      - predict_coding_regions/bed_output
    type: File
  - id: coding_regions
    outputSource:
      - predict_coding_regions/coding_regions
    type: File
  - id: gff3_output
    outputSource:
      - predict_coding_regions/gff3_output
    type: File
  - id: peptide_sequences
    outputSource:
      - predict_coding_regions/peptide_sequences
    type: File
steps:
  - id: extract_long_orfs
    in:
      - id: transcriptsFile
        source: transcriptsFile
    out:
      - id: workingDir
    run: ../tools/TransDecoder/TransDecoder.LongOrfs-v5.cwl
    label: Extracts the long open reading frames
  - id: predict_coding_regions
    in:
      - id: longOpenReadingFrames
        source: extract_long_orfs/workingDir
      - id: singleBestOnly
        source: singleBestOnly
      - id: transcriptsFile
        source: transcriptsFile
    out:
      - id: bed_output
      - id: coding_regions
      - id: gff3_output
      - id: peptide_sequences
    run: ../tools/TransDecoder/TransDecoder.Predict-v5.cwl
    label: Predicts the likely coding regions
requirements: []
$schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'
's:copyrightHolder': 'EMBL - European Bioinformatics Institute, 2018'
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'
#'sbg:wrapperLicense': Maxim Scheremtjew