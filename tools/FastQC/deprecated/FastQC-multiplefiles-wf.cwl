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
 - id: fastqc
   in:
     - id: in_fastq
       source: read_files
   out:
     - id: zipped_report
     - id: html_report
   run: FastQC-v0.11.5.cwl
   label: Generates QC for a single read file
   scatter:
     - in_fastq
requirements:
 - class: ScatterFeatureRequirement
$schemas:
 - 'http://edamontology.org/EDAM_1.16.owl'
 - 'https://schema.org/docs/schema_org_rdfa.html'
's:copyrightHolder': EMBL - European Bioinformatics Institute
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'
'sbg:wrapperAuthor': Maxim Scheremetjew
