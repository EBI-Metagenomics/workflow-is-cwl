class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'http://schema.org/'
  
baseCommand: transrate-1.0.3-linux-x86_64/transrate
  
inputs:
  - id: in_fasta
    type: File
    inputBinding:
      position: 1
      prefix: '--assembly='
    label: 'Assembly file in FASTA format'   
  - id: left_fastq
    type: File
    inputBinding:
      position: 2
      prefix: '--left='
    label: 'Left reads file(s) in FASTQ format'  
  - id: right_fastq
    type: File
    inputBinding:
      position: 3
      prefix: '--right='
    label: 'Right reads file(s) in FASTQ format'
  - id: n_threads
    type: int?
    inputBinding:
      position: 4
      prefix: '--threads='
      separate: false
    label: 'Number of threads to use (default: 8)'
  - id: log_level
    type: string?
    inputBinding:
      prefix: '--loglevel='
      separate: false
    label: 'Log level. One of [error, info, warn, debug] (default: info)'
  - id: output
    type: string?
    inputBinding:
      prefix: '--output='
      separate: false
    label: 'Directory where results are output (will be created) (default: transrate_results)'

outputs:
  evaluation_dir:
    type: Directory
    outputBinding:
      glob: .
    label: 'Evaluation directory containing reports'

doc: >
  Analyse a de-novo transcriptome assembly using three kinds of metrics:
  1. sequence based (if --assembly is given)
  2. read mapping based (if --left and --right are given)
  3. reference based (if --reference is given)

  Documentation at http://hibberdlab.com/transrate
        
label: Transrate - A de-novo transcriptome assembly evaluation facility.

hints:
  - class: SoftwareRequirement
    packages:
      transrate:
       version:
          - 1.0.3
  - class: DockerRequirement
    dockerPull: 'ycogne/transrate:1.0.3'

#$schemas:
#  - 'http://edamontology.org/EDAM_1.16.owl'
#  - 'https://schema.org/docs/schema_org_rdfa.html'
#'s:copyrightHolder': EMBL - European Bioinformatics Institute
#'s:license': 'https://www.apache.org/licenses/LICENSE-2.0'
