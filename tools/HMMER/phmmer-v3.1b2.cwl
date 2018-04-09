cwlVersion: v1.0
class: CommandLineTool

label: "Search a single protein sequence against a protein sequence database. (BLASTP-like)"

doc: |
      The phmmer and jackhmmer programs search a single protein sequence against a protein sequence
      database, akin to BLASTP and PSIBLAST, respectively. (Internally, they just produce a profile HMM from
      the query sequence, then run HMM searches.)
      Please visit https://github.com/EddyRivasLab/hmmer for full documentation.
      
      Releases can be downloaded from https://github.com/EddyRivasLab/hmmer/releases

requirements:
  ResourceRequirement:
    ramMin: 1024 # just a default, could be lowered
    coresMin: 2 # TODO: not really sure about that
    coresMax: 4 # TODO: not really sure about that
  
hints:
  SoftwareRequirement:
    packages:
      hmmer:
        specs: [ "https://identifiers.org/rrid/RRID:SCR_005305" ]
        version: [ "3.1b2", "3.1b3" ]

inputs:
  seqFile:
    label: "Query sequence(s) file"
    doc: |
          Search one or more query protein sequences against a protein sequence database.
    type: File
    inputBinding:
      position: 1

  seqdb:
    label: "Target database of sequences"
    type: File
    inputBinding:
      position: 2

  outputFile:
    label: "Output file"
    type: File?
    doc: |
          Direct output to file <f>, not stdout
    inputBinding:
      prefix: -o

  bitscoreThreshold:
    type: int?
    label: report sequences >= this bit score threshold in output
    inputBinding:
      prefix: -T

baseCommand: [ phmmer ]

arguments:
 - valueFrom: $(inputs.seqFile.nameroot).tblout
   prefix: --tblout
# TODO: Roll back if needed
# - valueFrom: $(runtime.cores)
#   prefix: --cpu

outputs:
  perTargetSummary:
    type: File
    outputBinding:
      glob: $(inputs.seqFile.nameroot).tblout
  programOutput:
    type: File
    outputBinding:
      glob: $(inputs.seqFile.nameroot).out

$namespaces:
 s: http://schema.org/
 edam: http://edamontology.org/
$schemas:
 - http://edamontology.org/EDAM_1.20.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute, 2018"