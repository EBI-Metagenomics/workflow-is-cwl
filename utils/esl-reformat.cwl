class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'http://schema.org/'
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - esl-reformat
inputs:
  - id: replace
    type: esl-reformat-replace.yaml#replace?
    inputBinding:
      position: 1
      prefix: '--replace'
      valueFrom: '$(self.find):$(self.replace)'
  - format: 'edam:format_1929'
    id: sequences
    type: File
    inputBinding:
      position: 3
outputs:
  - id: reformatted_sequences
    type: stdout
    format: 'edam:format_1929'
doc: |
  normalizes input sequeces to FASTA with fixed number of sequence characters
  per line using esl-reformat from https://github.com/EddyRivasLab/easel
label: normalize to fasta
arguments:
  - position: 2
    valueFrom: fasta
requirements:
  - class: SchemaDefRequirement
    types:
      - $import: esl-reformat-replace.yaml
  - class: ResourceRequirement
    ramMin: 100
    coresMax: 1
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.2--hfc679d8_3
stdout: $(inputs.sequences.basename).reformatted_seqs
$schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'
's:copyrightHolder': 'EMBL - European Bioinformatics Institute, 2017'
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'
'sbg:wrapperAuthor': Maxim Scheremetjew
