cwlVersion: v1.0
class: Workflow
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'http://schema.org/'
label: Chunked version of InterProScan-v5.cwl

requirements:
 ScatterFeatureRequirement: {}

inputs:
  - format: 'edam:format_1929'
    id: inputFile
    type: File
    label: Input file path
    doc: >-
      Optional, path to fasta file that should be loaded on Master startup.
      Alternatively, in CONVERT mode, the InterProScan 5 XML file to convert.
  - id: applications
    type: 'string[]?'
    label: Analysis
    doc: >-
      Optional, comma separated list of analyses. If this option is not set, ALL
      analyses will be run.
  - id: outputFormat
    type:
      type: enum
      symbols:
        - TSV
        - XML
        - JSON
        - GFF3
      name: outputFormat
    label: output format
    doc: >-
      Optional, case-insensitive, comma separated list of output formats.
      Supported formats are TSV, XML, JSON, GFF3, HTML and SVG. Default for
      protein sequences are TSV, XML and GFF3, or for nucleotide sequences GFF3
      and XML.
  - id: databases
    type: Directory
  - id: disableResidueAnnotation
    type: boolean?
    label: Disables residue annotation
    doc: 'Optional, excludes sites from the XML, JSON output.'
  - id: seqtype
    type:
      - 'null'
      - type: enum
        symbols:
          - p
          - n
        name: seqtype
    label: Sequence type
    doc: >-
      Optional, the type of the input sequences (dna/rna (n) or protein (p)).
      The default sequence type is protein.

outputs:
  - id: i5Annotations
    type: File
    outputSource: combine_interproscan_results/result

steps:
  split_seqs:
    run: ../utils/fasta_chunker.cwl
    in:
      seqs: inputFile
      chunk_size: { default: 1000 }
    out: [ chunks ]

  run_interproscan:
    label: Run InterProScan on chunked sequence files
    run: ../tools/InterProScan/InterProScan-v5.cwl
    in:
      inputFile: split_seqs/chunks
      applications: applications
      outputFormat: outputFormat
      databases: databases
      disableResidueAnnotation: disableResidueAnnotation
    scatter: inputFile
    out: [ i5Annotations ]

  combine_interproscan_results:
    run: ../utils/concatenate.cwl
    in:
      files: run_interprosca/i5Annotations
    out: [ result ]

$schemas:
  - 'http://edamontology.org/EDAM_1.20.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'
's:author': 'Maxim Scheremetjew'
's:copyrightHolder': EMBL - European Bioinformatics Institute
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'