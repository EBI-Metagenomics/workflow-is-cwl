cwlVersion: v1.0
class: CommandLineTool
label: search sequence(s) against a covariance model database
doc: |
      Infernal ("INFERence of RNA ALignment") is for searching DNA sequence databases for RNA structure and sequence
      similarities. It is an implementation of a special case of profile stochastic context-free grammars called
      covariance models (CMs). A CM is like a sequence profile, but it scores a combination of sequence consensus
      and RNA secondary structure consensus, so in many cases, it is more capable of identifying RNA homologs that
      conserve their secondary structure more than their primary sequence.

      Please visit http://eddylab.org/infernal/ for full documentation.

      Version 1.1.2 can be downloaded from http://eddylab.org/infernal/infernal-1.1.2.tar.gz
hints:
  - class: SoftwareRequirement
    packages:
      infernal:
        specs: [ "https://identifiers.org/rrid/RRID:SCR_011809" ]
        version: [ "1.1.2" ]
  #- $import: infernal-docker.yml

inputs:
  covariance_model_database:
    type: File
    inputBinding:
      position: 1

  query_sequences:
    type: File
    streamable: true
    inputBinding:
      position: 1
#    TODO: Resolve: Missing required 'format' for File at runtime
#    format:
#      - edam:format_1929  # FASTA
#      - edam:format_1927  # EMBL
#      - edam:format_1936  # Genbank entry format
#      - edam:format_1961  # Stockholm
#      - edam:format_3281  # A2M
#      - edam:format_1982  # Clustal
#      - edam:format_1997  # PHYLIP
      # ddbj ?
      # pfam ?
      # afa ?

  search_space_size:
    type: int
    label: search space size in *Mb* to <x> for E-value calculations
    inputBinding:
      prefix: -Z

  omit_alignment_section:
    label: Omit the alignment section from the main output.
    type: boolean?
    inputBinding:
      prefix: --noali
    doc: This can greatly reduce the output volume.

  only_hmm:
    label: Only use the filter profile HMM for searches, do not use the CM
    type: boolean?
    default: false
    inputBinding:
      prefix: --hmmonly
    doc: |
      Only filter stages F1 through F3 will be executed, using strict P-value
      thresholds (0.02 for F1, 0.001 for F2 and 0.00001 for F3). Additionally
      a bias composition filter is used after the F1 stage (with P=0.02
      survival threshold).  Any hit that survives all stages and has an HMM
      E-value or bit score above the reporting threshold will be output.

  cut_ga:
    label: use CM's GA gathering cutoffs as reporting thresholds
    type: boolean?
    default: false
    inputBinding:
      prefix: --cut_ga

  cpu:
    label: Number of parallel CPU workers to use for multithreads
    type: int?
#    default: $(runtime.cores)
    inputBinding:
      prefix: --cpu

baseCommand: cmsearch

arguments:
  - valueFrom: $(inputs.query_sequences.basename).cmsearch_matches.tbl
    prefix: --tblout
  - valueFrom: $(inputs.query_sequences.basename).cmsearch.out
    prefix: -o

outputs:
  matches:
    label: target hits table, format 2
    doc: "http://eddylab.org/infernal/Userguide.pdf#page=60"
    type: File
    outputBinding:
      glob: $(inputs.query_sequences.basename).cmsearch_matches.tbl
  programOutput:
    label: direct output to file, not stdout
    type: File
    outputBinding:
      glob: $(inputs.query_sequences.basename).cmsearch.out

$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/
$schemas:
 - http://edamontology.org/EDAM_1.16.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute"