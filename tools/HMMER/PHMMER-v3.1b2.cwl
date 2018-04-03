cwlVersion: v1.0
class: CommandLineTool

label: "??"

doc: |
      phmmer is a ...
      Please visit ?? for full documentation.
      
      Releases can be downloaded from ??

requirements:
  ResourceRequirement:
    ramMin: 1024
    coresMin: 1
  
hints:
  SoftwareRequirement:
    packages:
      hmmer:
        specs: [ "https://identifiers.org/rrid/RRID:SCR_005305" ]
        version: [ "3.1b2" ]

inputs:
  transcriptsFile:
    label: "transcripts.fasta"
    type: File
    doc: "FASTA formatted sequence file containing your transcripts."
#    format: edam:format_1929  # FASTA
    inputBinding:
      prefix: -t

baseCommand: phmmer

outputs:
  workingDir:
    type: Directory
    outputBinding:
      glob: $(inputs.transcriptsFile.basename)

$namespaces:
 s: http://schema.org/
 edam: http://edamontology.org/
$schemas:
 - http://edamontology.org/EDAM_1.20.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute, 2018"
