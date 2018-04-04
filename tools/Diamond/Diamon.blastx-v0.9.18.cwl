cwlVersion: v1.0
class: CommandLineTool

label: "diamond blastx: Align DNA query sequences against a protein reference database"

doc: |
      DIAMOND is a sequence aligner for protein and translated DNA searches,
      designed for high performance analysis of big sequence data.
      
      The key features are:
            + Pairwise alignment of proteins and translated DNA at 500x-20,000x speed of BLAST.
            + Frameshift alignments for long read analysis.
            + Low resource requirements and suitable for running on standard desktops or laptops.
            + Various output formats, including BLAST pairwise, tabular and XML, as well as taxonomic classification.

      Please visit https://github.com/bbuchfink/diamond for full documentation.
      
      Releases can be downloaded from https://github.com/bbuchfink/diamond/releases

requirements:
  ResourceRequirement:
    ramMin: 1024
    coresMin: 1
  SchemaDefRequirement:
    types:
      - $import: Diamond-output_formats.yaml
      - $import: Diamond-strand_values.yaml
#hints:
#  SoftwareRequirement:
#    packages:
#      diamond:
#        specs: [ "" ]
#        version: [ "0.9.18" ]

inputs:
  databaseFile:
    label: "DIAMOND database input file"
    type: File
    doc: "Path to the DIAMOND database file."
    format: edam:format_2333  # Binary format
    inputBinding:
      prefix: --db
  queryInputFile:
    label: "Query input file in FASTA"
    type: File
    doc: |
          Path to the query input file in FASTA or FASTQ format (may be gzip compressed). If this
          parameter is omitted, the input will be read from stdin
    format: edam:format_1929  # FASTA
    inputBinding:
      prefix: --query
  taxonList:
    label: "Protein accession to taxon identifier NCBI mapping file"
    type: []?
    doc: |
          Comma-separated list of NCBI taxonomic IDs to filter the database by. Any taxonomic rank
          can be used, and only reference sequences matching one of the specified taxon ids will
          be searched against. Using this option requires setting the --taxonmap and --taxonnodes
          parameters for makedb.
    inputBinding:
      prefix: --taxonlist
  queryGeneticCode:
    label: "Genetic code used for the translation of the query sequences"
    type: int?
    doc: |
          Genetic code used for translation of query in BLASTX mode. A list of possible values can
          be found at the NCBI website. By default, the Standard Code is used. Note: changing the
          genetic code is currently not fully supported for the DAA format.
    inputBinding:
      prefix: --query-gencode
  strand:
    label: "Set strand of query to align for translated searches"
    type: Diamond-strand_values.yaml#strand?
    doc: "Set strand of query to align for translated searches. By default both strands are searched. Valid values are {both, plus, minus}"
    inputBinding:
      prefix: --strand
  queryGeneticCode:
    label: "Genetic code used for the translation of the query sequences"
    type: int?
    doc: |
          Ignore translated sequences that do not contain an open reading frame of at least this length.
          By default this feature is disabled for sequences of length below 30, set to 20 for sequences
          of length below 100, and set to 40 otherwise. Setting this option to 1 will disable this feature.
    inputBinding:
      prefix: --min-orf
  outputFormat:
    label: "Format of the output file"
    type: Diamond-output_formats.yaml#output_formats?
    doc: "The format of the output file."
    inputBinding:
      prefix: --outfmt
  threads:
    label: "Number of CPU threads"
    type: int?
    doc: |
          Number of CPU threads. By default, the program will auto-detect and use all available virtual
          cores on the machine.
    inputBinding:
      prefix: --threads

baseCommand: [diamond, blastx]

arguments:
 - valueFrom: $(inputs.proteinFile.nameroot).i5_annotations
   prefix: --out

outputs:
  diamondDatabaseFile:
    type: File
    format: edam:format_2333  # Binary format
    outputBinding: { glob: "$(inputs.outputDBFile.nameroot)*" }

$namespaces:
 s: http://schema.org/
 edam: http://edamontology.org/
$schemas:
 - http://edamontology.org/EDAM_1.20.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute, 2018"