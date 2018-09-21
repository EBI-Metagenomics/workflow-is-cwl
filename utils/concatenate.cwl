class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  s: 'http://schema.org/'
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - cat
inputs:
  - id: files
    type: 'File[]'
    inputBinding:
      position: 1
    streamable: true
outputs:
  - id: result
    type: File
    outputBinding:
      glob: result
      outputEval: |
        ${ self[0].format = inputs.files[0].format;
           return self; }
requirements:
  - class: ResourceRequirement
    ramMin: 100
    coresMax: 1
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: 'alpine:3.7'
stdout: result
$schemas:
  - 'https://schema.org/docs/schema_org_rdfa.html'
's:copyrightHolder': EMBL - European Bioinformatics Institute
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'
