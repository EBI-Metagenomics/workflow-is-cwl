class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  iana: 'https://www.iana.org/assignments/media-types/'
  s: 'http://schema.org/'
  sbg: 'https://www.sevenbridges.com'
baseCommand: []
inputs:
  - id: applications
    type: 'string[]?'
    inputBinding:
      position: 3
      prefix: '--applications'
      itemSeparator: ','
  - id: proteinFile
    type: File
    inputBinding:
      position: 3
      prefix: '--input'
  - id: disableResidueAnnotation
    type: boolean?
    inputBinding:
      position: 3
      prefix: '--disable-residue-annot'
    label: Disables residue annotation
    doc: 'Optional, excludes sites from the XML, JSON output.'
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
  - position: 0
    shellQuote: false
    valueFrom: cp -r /opt/interproscan $(runtime.outdir)/interproscan;
  - position: 1
    shellQuote: false
    valueFrom: >-
      cp -rs $(inputs.databases.path)/data/*
      $(runtime.outdir)/interproscan/data;
  - position: 2
    shellQuote: false
    valueFrom: $(runtime.outdir)/interproscan/interproscan.sh
  - position: 3
    prefix: '--outfile'
    valueFrom: $(runtime.outdir)/$(inputs.proteinFile.basename).i5_annotations
  - position: 3
    prefix: '--formats'
    valueFrom: TSV
  - position: 3
    prefix: '--disable-precalc'
  - position: 3
    prefix: '--goterms'
  - position: 3
    prefix: '--pathways'
  - position: 3
    prefix: '--tempdir'
    valueFrom: $(runtime.tmpdir)
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 8192
    coresMin: 3
  - class: InlineJavascriptRequirement
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
$schemas:
  - 'https://schema.org/docs/schema_org_rdfa.html'
's:copyrightHolder': 'EMBL - European Bioinformatics Institute, 2018'
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'
