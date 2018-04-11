cwlVersion: v1.0
class: Workflow
label: TransDecoder 2 step workflow, running TransDecoder.LongOrfs (step 1) followed by TransDecoder.Predict (step2)

requirements:
 - class: SchemaDefRequirement
   types:
    - $import: ../tools/TransDecoder/TransDecoder-v5-genetic_codes.yaml

inputs:
  transcriptsFile:
    type: File
#   TODO: Resolve: Missing required 'format' for File at runtime
#    format: edam:format_1929  # FASTA
  singleBestOnly: boolean?

outputs:
  peptide_sequences:
    type: File
    outputSource: predicts_coding_regions/peptide_sequences
  coding_regions:
    type: File
    outputSource: predicts_coding_regions/coding_regions
  gff3_output:
    type: File
    outputSource: predicts_coding_regions/gff3_output
  bed_output:
    type: File
    outputSource: predicts_coding_regions/bed_output

steps:
  extract_long_orfs:
    label: Extracts the long open reading frames
    run: ../tools/TransDecoder/TransDecoder.LongOrfs-v5.cwl
    in:
      transcriptsFile: transcriptsFile
    out: [ workingDir ]

  predict_coding_regions:
    label: Predicts the likely coding regions
    run: ../tools/TransDecoder/TransDecoder.Predict-v5.cwl
    in:
      transcriptsFile: transcriptsFile
      longOpenReadingFrames: extract_long_orfs/workingDir
      singleBestOnly: singleBestOnly
    out: [ peptide_sequences, coding_regions, gff3_output, bed_output ]

$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/
$schemas:
 - http://edamontology.org/EDAM_1.16.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute"