class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  iana: 'https://www.iana.org/assignments/media-types/'
  s: 'http://schema.org/'
id: i5
baseCommand: []
inputs:
  - format: 'edam:format_1929'
    id: inputFile
    type: File?
    inputBinding:
      position: 9
      prefix: '--input'
    label: Input file path
    doc: >-
      Optional, path to fasta file that should be loaded on Master startup.
      Alternatively, in CONVERT mode, the InterProScan 5 XML file to convert.
  - id: applications
    type:
      - 'null'
      - type: array
        items:
          type: enum
          name: applications
          symbols:
            - TIGRFAM
            - SFLD
            - ProDom
            - Hamap
            - SMART
            - CDD
            - ProSiteProfiles
            - ProSitePatterns
            - SUPERFAMILY
            - PRINTS
            - PANTHER
            - Gene3D
            - PIRSF
            - Pfam
            - Coils
            - MobiDBLite
            - SignalP_GRAM_POSITIVE
            - SignalP_EUK
            - Phobius
            - TMHMM
            - SignalP_GRAM_NEGATIVE
    inputBinding:
      position: 10
      prefix: '--applications'
      itemSeparator: ','
    label: Analysis
    doc: >-
      Optional, comma separated list of analyses. If this option is not set, ALL
      analyses will be run.
  - id: outputFormats
    type:
      - 'null'
      - type: array
        items:
          type: enum
          name: outputFormats
          symbols:
            - TSV
            - XML
            - JSON
            - GFF3
            - HTML
            - SVG
    inputBinding:
      position: 11
      prefix: '--formats'
      itemSeparator: ','
    label: output formats
    doc: >-
      Optional, case-insensitive, comma separated list of output formats.
      Supported formats are TSV, XML, JSON, GFF3, HTML and SVG. Default for
      protein sequences are TSV, XML and GFF3, or for nucleotide sequences GFF3
      and XML.
  - id: databases
    type: Directory?
outputs:
  - id: i5Annotations
    type: File
    outputBinding:
      glob: $(inputs.inputFile.nameroot).i5_annotations
doc: >-
  InterProScan is the software package that allows sequences (protein and
  nucleic) to be scanned against InterPro's signatures. Signatures are
  predictive models, provided by several different databases, that make up the
  InterPro consortium.


  This tool description is using a Docker container tagged as version
  v5.30-69.0.


  Documentation on how to run InterProScan 5 can be found here:
  https://github.com/ebi-pf-team/interproscan/wiki/HowToRun
label: 'InterProScan: protein sequence classifier'
arguments:
  - position: 0
    valueFrom: cp -r /opt/interproscan $(runtime.outdir)/interproscan;
  - position: 1
    valueFrom: rm -rf $(runtime.outdir)/interproscan/data;
  - position: 2
    valueFrom: cp -rs $(inputs.databases.path)/data $(runtime.outdir)/interproscan/;
  - position: 3
    valueFrom: bash $(runtime.outdir)/interproscan/interproscan.sh
  - position: 4
    prefix: '--outfile'
    valueFrom: |
      $(runtime.outdir)/$(inputs.inputFile.nameroot).i5_annotations
  - position: 5
    prefix: '--disable-precalc'
  - position: 6
    prefix: '--goterms'
  - position: 7
    prefix: '--pathways'
  - position: 8
    prefix: '--tempdir'
    valueFrom: $(runtime.tmpdir)
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 8192
    coresMin: 3
  - class: DockerRequirement
    dockerPull: 'biocontainers/interproscan:v5.30-69.0_cv1'
  - class: InlineJavascriptRequirement
$schemas:
  - 'http://edamontology.org/EDAM_1.20.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'
's:author': 'Michael Crusoe, Aleksandra Ola Tarkowska, Maxim Scheremetjew'
's:copyrightHolder': EMBL - European Bioinformatics Institute
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'