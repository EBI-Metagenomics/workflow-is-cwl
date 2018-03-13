cwlVersion: v1.0
class: CommandLineTool

label: "TransDecoder.LongOrfs: Perl script, which extracts the long open reading frames"

doc: |
      Releases can be downloaded from:
      https://github.com/TransDecoder/TransDecoder/releases
      
      Documentation can be found here:
      https://github.com/TransDecoder/TransDecoder/wiki

requirements:
  ResourceRequirement:
    ramMin: 1024
    coresMin: 1
  SchemaDefRequirement:
    types: 
      - $import: TransDecoder.LongOrfs-5-genetic_codes.yaml
#hints:
#  SoftwareRequirement:
#    packages:
#      transdecoder:
#        specs: [ "" ]
#        version: [ "5.0.0", "5.0.1", "5.0.2" ]

inputs:
  transcriptsFile:
    label: transcripts.fasta
    doc: FASTA formatted sequence file containing your transcripts.
    type: File
    inputBinding:
      prefix: -t
  minimumProteinLength:
    label: minimum protein length (default: 100)
    type: int?
    inputBinding:
      prefix: -m
  geneToTranscriptMap:
    label: gene-to-transcript mapping
    type: File?
    doc: gene-to-transcript identifier mapping file (tab-delimited, gene_id<tab>trans_id<return>)
    inputBinding:
      prefix: --gene_trans_map
  strandSpecific:
    label: strand-specific
    type: boolean?
    doc: strand-specific (only analyzes top strand)
    inputBinding:
      prefix: -S
  geneticCode:
    label: genetic code
    type: TransDecoder.LongOrfs-5-genetic_codes.yaml#genetic_codes[]?
    doc: genetic code (default: universal; see PerlDoc; options: Euplotes, Tetrahymena, Candida, Acetabularia)
    inputBinding:
      prefix: -G

baseCommand: TransDecoder.LongOrfs

outputs:
  workingDir:
    type: Directory
    outputBinding:
      glob: $(inputs.transcriptsFile.nameroot).transdecoder_dir

$namespaces:
 s: http://schema.org/
$schemas:
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute, 2018"