cwlVersion: v1.0
class: CommandLineTool

label: "Search a single protein sequence against a protein sequence database. (BLASTP-like)"

doc: |
      The phmmer and jackhmmer programs search a single protein sequence against a protein sequence
      database, akin to BLASTP and PSIBLAST, respectively. (Internally, they just produce a profile HMM from
      the query sequence, then run HMM searches.)
      Please visit https://github.com/EddyRivasLab/hmmer for full documentation.
      
      Releases can be downloaded from https://github.com/EddyRivasLab/hmmer/releases
      TODO: Write test for example command:
      phmmer ../tutorial/HBB_HUMAN ../tutorial/globins45.fa

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
        version: [ "3.1b2" ]

inputs:
  query:
    type: File
    inputBinding:
      position: 1
    format: edam:format_1370  # HMMER

  sequences:
    type: File
    inputBinding:
      position: 2

  bitscore_threshold:
    type: int?
    label: report sequences >= this bit score threshold in output
    inputBinding:
      prefix: -T

baseCommand: [ phmmer ]

arguments:
 - --tblout
 - per_target_summary.txt
 - valueFrom: $(runtime.cores)
   prefix: --cpu

outputs:
  per_target_summary:
    type: File
    outputBinding:
      glob: per_target_summary.txt

$namespaces:
 s: http://schema.org/
 edam: http://edamontology.org/
$schemas:
 - http://edamontology.org/EDAM_1.20.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute, 2018"
