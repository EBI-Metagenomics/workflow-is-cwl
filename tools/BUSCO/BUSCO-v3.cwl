cwlVersion: v1.0
class: CommandLineTool

label: "BUSCO: assessing genome assembly and annotation completeness with single-copy orthologs"

doc: |
      BUSCO v3 provides quantitative measures for the assessment of genome assembly, gene set,
      and transcriptome completeness, based on evolutionarily-informed expectations of gene content
      from near-universal single-copy orthologs selected from OrthoDB v9.

      BUSCO assessments are implemented in open-source software, with a large selection of
      lineage-specific sets of Benchmarking Universal Single-Copy Orthologs. These conserved
      orthologs are ideal candidates for large-scale phylogenomics studies, and the annotated
      BUSCO gene models built during genome assessments provide a comprehensive gene predictor
      training set for use as part of genome annotation pipelines.

      Please visit http://busco.ezlab.org/ for full documentation.
      
      The BUSCO assessment software distribution is available from the public GitLab project:
      https://gitlab.com/ezlab/busco where it can be downloaded or cloned using a git client
      (git clone https://gitlab.com/ezlab/busco.git). We encourage users to opt for the git
      client option in order to facilitate future updates.

      BUSCO is written for Python 3.x and Python 2.7+. It runs with the standard packages. We
      recommend using Python3 when available.
      

requirements:
  ResourceRequirement:
    coresMin: 1
  SchemaDefRequirement:
    types: 
      - $import: BUSCO-assessment_modes.yaml
hints:
  - class: SoftwareRequirement
    packages:
      BUSCO:
        specs: [ "https://identifiers.org/rrid/RRID:SCR_015008" ]
        version: [ "3.0.2" ]

inputs:
  mode:
    label: "Sets the assessment MODE: genome, proteins, transcriptome"
    type: BUSCO-assessment_modes.yaml#assessment_modes
    doc: |
          Specify which BUSCO analysis mode to run.
          There are three valid modes:
          - geno or genome, for genome assemblies (DNA).
          - tran or transcriptome, for transcriptome assemblies (DNA).
          - prot or proteins, for annotated gene sets (protein).
    inputBinding:
      prefix: --mode
  sequenceFile:
    label: "Sequence file in FASTA format"
    doc: |
          Input sequence file in FASTA format (not compressed/zipped!).
          Can be an assembled genome (genome mode) or transcriptome (DNA,
          transcriptome mode), or protein sequences from an annotated gene set
          (proteins mode).
          NB: select just one transcript/protein per gene for your input,
          otherwise they will appear as ‘Duplicated’ matches.
    type: File
#    format: edam:format_1929  # FASTA
    inputBinding:
      prefix: --in
  outputName:
    label: "Name to use for the run and all temporary files (appended)"
    type: string
    doc: |
          Give your analysis run a recognisable short name.
          Output folders and files will be labelled (prepended) with this name.
          WARNING: do not provide a path.
    inputBinding:
      prefix: --out
  lineage:
    label: "Location of the BUSCO lineage data to use (e.g. fungi_odb9)"
    type: string
    doc: |
          Specify location of the BUSCO lineage data to be used.
          Visit http://busco.ezlab.org/ for available lineages.
    inputBinding:
      prefix: --lineage_path
  cpu:
    label: "Specify the number of threads/cores to use (default: 1)"
    type: int?
#    default: $(runtime.cores)
    inputBinding:
      prefix: --cpu
  evalue:
    label: "E-value cutoff for BLAST searches"
    type: float?
    doc: |
          Allowed formats: 0.001 or 1e-03 (default: 1e-03).
    inputBinding:
      prefix: --evalue
  force:
    label: "Force rewriting of existing files/folders"
    type: boolean?
    doc: |
          Must be used when output files with the provided name already exist.
    inputBinding:
      prefix: --force
  species:
    label: "Name of existing Augustus species gene finding parameters"
    type: string?
    doc: |
          See Augustus documentation for available options.
          Each lineage has a default species (see below on assessment sets).
          Selecting a closely-related species usually produces better results.
    inputBinding:
      prefix: --species
  tempPath:
    label: "Where to store temporary files (default: ./tmp)"
    type: File?
    inputBinding:
      prefix: --tmp
  tarzip:
    label: "Results folders with many files will be tarzipped"
    type: boolean?
    inputBinding:
      prefix: --tarzip
  restart:
    label: "Restart the BUSCO run from the last successfully-completed step"
    type: boolean?
    doc: |
          NB: If all the required results files from previous steps are not all found
          then this will not be possible.
    inputBinding:
      prefix: --restart
  regionLimit:
    label: "How many candidate regions to consider (integer, default: 3)"
    type: int?
    doc: |
          NB: this limit is on scaffolds, chromosomes, or transcripts, not individual
          hit regions.
    inputBinding:
      prefix: --limit
  long:
    label: "Turn on Augustus optimization mode for self-training (default: Off)"
    type: boolean?
    doc: |
          Adds substantially to the run time!
          Can improve results for some non-model organisms.
    inputBinding:
      prefix: --long
  quiet:
    label: "Disable the info logs, display only errors"
    type: boolean?
    inputBinding:
      prefix: --quiet
  blastSingleCore:
    label: "Force tblastn to run on a single core"
    type: boolean?
    doc: |
          Force tblastn to run on a single core and ignore the --cpu argument for
          this step only. Useful if inconsistencies when using multiple threads are
          noticed
    inputBinding:
      prefix: --blast_single_core
  version:
    label: "Show this version information and exit"
    type: boolean?
    inputBinding:
      prefix: --version
  help:
    label: "Show this help message and exit"
    type: boolean?
    inputBinding:
      prefix: --help

baseCommand: run_BUSCO.py

outputs:
  shortSummary:
    doc: |
          Contains a plain text summary of the results in BUSCO notation.
          Also gives a brief breakdown of the metrics.
    type: File
#    format: iana:text/tab-separated-values
    outputBinding:
      glob: short_summary_*.txt
  fullTable:
    doc: |
          Contains the complete results in a tabular format with scores and lengths of
          BUSCO matches, and coordinates (for genome mode) or gene/protein IDs
          (for transcriptome or proteins mode).
    type: File
    format: iana:text/tab-separated-values
    outputBinding:
      glob: full_table_*.tsv
  missingBUSCOs
    label: Contains a list of missing BUSCOs
    type: File
    format: iana:text/tab-separated-values
    outputBinding:
      glob: missing_buscos_list_*.tsv
  hmmerOutput:
    label: Tabular format HMMER output of searches with BUSCO HMMs
    type: Directory
    outputBinding:
      glob: hmmer_output
  translatedProteins:
    label: Transcript sequence translations, only created during transcriptome assessment
    type: Directory
    outputBinding:
      glob: translated_proteins
  blastOutput:
    doc: |
          tBLASTn results, not created for assessment of proteins.
          File: tblastn_XXXX.txt = tabular tBLASTn results
          File: coordinates_XXXX.txt = locations of BUSCO matches (genome mode)
    type: Directory
    outputBinding:
      glob: blast_output

$namespaces:
 s: http://schema.org/
 iana: https://www.iana.org/assignments/media-types/
 edam: http://edamontology.org/
$schemas:
 - http://edamontology.org/EDAM_1.20.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute, 2018"