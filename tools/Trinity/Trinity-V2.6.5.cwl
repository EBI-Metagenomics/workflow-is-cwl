class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'http://schema.org/'

baseCommand: [ /usr/local/bin/trinityrnaseq/Trinity, --full_cleanup ]

inputs:
  - id: seq_type
    type: string
    inputBinding:
      position: 1
      prefix: '--seqType'
    label: 'type of reads: (fa or fq)'
  - id: max_mem
    type: string
    inputBinding:
      position: 2
      prefix: '--max_memory'
    label: 'suggested max memory to use by Trinity where limiting can be enabled. (jellyfish, sorting, etc) provided in Gb of RAM, ie. --max_memory 10G'
  - id: left_fastq
    type: File
    inputBinding:
      position: 3
      prefix: '--left'
    label: 'left reads, one or more file names'
  - id: right_fastq
    type: File
    inputBinding:
      position: 4
      prefix: '--right'
    label: 'right reads, one or more file names'
  - id: ss_lib_type
    type:
      type: enum
      symbols:
        - FR
        - RF
    inputBinding:
      position: 5
      prefix: '--SS_lib_type'
    label: 'Strand-specific RNA-Seq read orientation. if paired: RF or FR, if single: F or R. (dUTP method = RF). See web documentation'
  - id: cpu
    type: int?
    inputBinding:
      position: 6
      prefix: '--CPU'
    label: 'number of CPUs to use, default: 2'

outputs:
  assembly_dir:
    type: Directory
    outputBinding:
      glob: .
    label: 'Assembly directory containing assembly results'

doc: >
  Trinity, developed at the Broad Institute and the Hebrew University of Jerusalem, 
  represents a novel method for the efficient and robust de novo reconstruction 
  of transcriptomes from RNA-seq data. 
  Trinity combines three independent software modules: Inchworm, Chrysalis, and 
  Butterfly, applied sequentially to process large volumes of RNA-seq reads.

  Documentation at https://github.com/trinityrnaseq/trinityrnaseq/wiki

label: Trinity assembles transcript sequences from Illumina RNA-Seq data.

hints:
  - class: SoftwareRequirement
    packages:
      Trinity:
       version:
          - 2.6.5
  - class: DockerRequirement
    dockerPull: 'trinityrnaseq/trinityrnaseq:2.6.5'

$schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'
's:copyrightHolder': EMBL - European Bioinformatics Institute
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'