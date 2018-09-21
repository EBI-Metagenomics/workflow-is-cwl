class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  iana: 'https://www.iana.org/assignments/media-types/'
  s: 'http://schema.org/'
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - interproscan.sh
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
    prefix: '--outfile'
    valueFrom: $(inputs.proteinFile.basename).i5_annotations
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
  - class: SchemaDefRequirement
    types:
      - name: apps
        symbols:
          - TIGRFAM
          - SFLD
          - SUPERFAMILY
          - Gene3D
          - Hamap
          - Coils
          - ProSiteProfiles
          - SMART
          - CDD
          - PRINTS
          - PIRSF
          - ProSitePatterns
          - Pfam
          - ProDom
          - MobiDBLite
          - SignalP_GRAM_POSITIVE
          - SignalP_GRAM_NEGATIVE
          - SignalP_EUK
          - Phobius
          - TMHMM
        type: enum
      - name: protein_formats
        symbols:
          - TSV
          - XML
          - GFF3
        type: enum
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
          - 5.21-60
          - 5.22-61.0
          - 5.23-62.0
          - 5.24-63.0
          - 5.25-64.0
          - 5.26-65.0
          - 5.27-66.0
          - 5.28-67.0
  - class: DockerRequirement
    dockerPull: 'olat/interproscan:latest'
$schemas:
  - 'https://schema.org/docs/schema_org_rdfa.html'
's:copyrightHolder': 'EMBL - European Bioinformatics Institute, 2018'
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'
'sbg:wrapperAuthor': Maxim Scheremetjew
