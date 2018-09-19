class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  iana: 'https://www.iana.org/assignments/media-types/'
  s: 'http://schema.org/'
hints:
  - class: SoftwareRequirement
    packages:
      interproscan:
        specs:
          - 'https://identifiers.org/rrid/RRID:SCR_005829'
        version:
          - 5.30-69.0
  - class: DockerRequirement
    dockerPull: 'biocontainers/interproscan:v5.30-69.0_cv1'
baseCommand: []
#  - interproscan.sh
inputs:
  - id: applications
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--applications'
      itemSeparator: ','
  - id: proteinFile
    type: File
    inputBinding:
      position: 0
      prefix: '--input'
  - id: databases
    type: Directory
outputs:
  - id: i5Annotations
    type: File
    outputBinding:
      glob: $(inputs.proteinFile.basename).i5_annotations
    format: 'iana:text/tab-separated-values'
doc: |
  Releases can be downloaded from:
  ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/

  Documentation on how to run InterProScan 5 can be found here:
  https://github.com/ebi-pf-team/interproscan/wiki/HowToRun
label: 'InterProScan: protein sequence classifier'
arguments:
  - cp
  - -r
  - /opt/interproscan
  - $(runtime.outdir)/interproscan
  - ;

  - rm
  - -rf
  - $(runtime.outdir)/interproscan/data
  - ;

  - cp
  - -rs
  - $(inputs.databases.path)/data
  - $(runtime.outdir)/interproscan/
  - ;

  - find
  - $(runtime.outdir)/interproscan/
  - ;


  - bash
  - $(runtime.outdir)/interproscan/interproscan.sh

  - position: 0
    prefix: '--outfile'
    valueFrom: $(runtime.outdir)/$(inputs.proteinFile.basename).i5_annotations
  - position: 0
    prefix: '--formats'
    valueFrom: TSV
  - '--disable-precalc'
  - '--goterms'
  - '--pathways'
  - position: 0
    prefix: '--tempdir'
    valueFrom: $(runtime.tmpdir)

requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 8192
    coresMin: 3

$schemas:
  - 'https://schema.org/docs/schema_org_rdfa.html'
's:copyrightHolder': 'EMBL - European Bioinformatics Institute, 2018'
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'