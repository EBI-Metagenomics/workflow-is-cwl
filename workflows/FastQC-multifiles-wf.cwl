class: Workflow
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'http://schema.org/'
inputs:
  - id: read_files
    type: File[]
outputs:
  - id: zipped_reports
    outputSource:
      - fastqc/zipped_report
    type: File
  - id: html_reports
    outputSource:
      - fastqc/html_report
    type: File
steps:
  fastqc:
    label: Generates QC for a single read file
    run: ../tools/FastQC/FastQC-v0.11.7.cwl
    in:
      in_fastq: read_files
    scatter: in_fastq
    out: [ zipped_report, html_report ]
requirements:
  - class: ScatterFeatureRequirement
$schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'
's:copyrightHolder': EMBL - European Bioinformatics Institute
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'
's:author': Maxim Scheremetjew