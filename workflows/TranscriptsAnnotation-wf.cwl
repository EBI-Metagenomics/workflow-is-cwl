cwlVersion: v1.0
class: Workflow
label: Transcripts annotation workflow

requirements:
 - class: SubworkflowFeatureRequirement
 - class: SchemaDefRequirement
   types:
    - $import: ../tools/utils/esl-reformat-replace.yaml

inputs:
  transcriptsFile:
    type: File
#   TODO: Resolve: Missing required 'format' for File at runtime
#    format: edam:format_1929  # FASTA
  singleBestOnly: boolean?
  replace: ../tools/utils/esl-reformat-replace.yaml#replace?
  phmmerSeqdb:
    type: File
#   TODO: Resolve: Missing required 'format' for File at runtime
#    format: edam:format_1929  # FASTA
  diamondSeqdb: File
  blockSize: float?
  covariance_models: File[]
  clanInfoFile: File
  cmsearchCores: int

outputs:
  peptide_sequences:
    type: File
    outputSource: identify_coding_regions/peptide_sequences
  coding_regions:
    type: File
    outputSource: identify_coding_regions/coding_regions
  gff3_output:
    type: File
    outputSource: identify_coding_regions/gff3_output
  bed_output:
    type: File
    outputSource: identify_coding_regions/bed_output
  reformatted_sequences:
    type: File
    outputSource: remove_asterisks_and_reformat/reformatted_sequences
  i5Annotations:
    type: File
    outputSource: functional_analysis/i5Annotations
  phmmer_matches:
    type: File
    outputSource: calculate_phmmer_matches/matches
  diamond_matches:
    type: File
    outputSource: calculate_diamond_matches/matches

steps:
  identify_coding_regions:
    label: Identifies candidate coding regions within transcript sequences
    run: TransDecoder-v5-wf-2steps.cwl
    in:
      transcriptsFile: transcriptsFile
      singleBestOnly: singleBestOnly
    out: [ peptide_sequences, coding_regions, gff3_output, bed_output ]

  remove_asterisks_and_reformat:
    label: Removes asterisks characters from given peptide sequences
    run: ../tools/utils/esl-reformat.cwl
    in:
      sequences: identify_coding_regions/peptide_sequences
#      TODO: Check with Michael how to resolve Type property error "['null', 'replace']" not a valid Avro schema
      replace: replace
    out: [ reformatted_sequences ]

  functional_analysis:
    doc: |
        Matches are generated against predicted CDS, using a sub set of databases
        (Pfam, TIGRFAM, PRINTS, PROSITE patterns, Gene3d) from InterPro.
    run: ../tools/InterProScan/InterProScan-v5.cwl
    in:
      proteinFile: remove_asterisks_and_reformat/reformatted_sequences
    out: [ i5Annotations ]

  calculate_phmmer_matches:
    label: Calculates phmmer matches
    run: ../tools/HMMER/phmmer-v3.1b2.cwl
    in:
      seqFile: identify_coding_regions/peptide_sequences
      seqdb: phmmerSeqdb
    out: [ matches, programOutput ]

  calculate_diamond_matches:
    label: Calculates Diamond matches
    run: ../tools/Diamond/Diamon.blastx-v0.9.18.cwl
    in:
      queryInputFile: transcriptsFile
      databaseFile: diamondSeqdb
      blockSize: blockSize
    out: [ matches ]

  identify_nc_rna:
    label: Identifies non-coding RNAs using Rfams covariance models
    run: cmsearch-multimodel-wf.cwl
    in:
      query_sequences: transcriptsFile
      covariance_models: covariance_models
      clan_info: clanInfoFile
      cores: cmsearchCores
    out: [ matches ]

$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/
$schemas:
 - http://edamontology.org/EDAM_1.16.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute, 2018"