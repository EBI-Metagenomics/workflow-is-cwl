cwlVersion: v1.0
class: CommandLineTool

label: "TransDecoder.Predict: Perl script, which predicts the likely coding regions"

doc: |
      TransDecoder identifies candidate coding regions within transcript sequences, 
      such as those generated by de novo RNA-Seq transcript assembly using Trinity,
      or constructed based on RNA-Seq alignments to the genome using Tophat and Cufflinks.
      
      TransDecoder identifies likely coding sequences based on the following criteria:
            + a minimum length open reading frame (ORF) is found in a transcript sequence
            + a log-likelihood score similar to what is computed by the GeneID software is > 0.
            + the above coding score is greatest when the ORF is scored in the 1st reading frame
            as compared to scores in the other 2 forward reading frames.
            + if a candidate ORF is found fully encapsulated by the coordinates of another candidate ORF,
            the longer one is reported. However, a single transcript can report multiple ORFs 
            (allowing for operons, chimeras, etc).
            + a PSSM is built/trained/used to refine the start codon prediction.
            + optional the putative peptide has a match to a Pfam domain above the noise cutoff score.
            
      Please visit https://github.com/TransDecoder/TransDecoder/wiki for full documentation.
      
      Releases can be downloaded from https://github.com/TransDecoder/TransDecoder/releases

requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.transcriptsFile)
      - entry: $(inputs.longOpenReadingFrames)
        entryname: $(inputs.transcriptsFile.basename).transdecoder_dir
  ResourceRequirement:
    ramMin: 1024
    coresMin: 1
  SchemaDefRequirement:
    types: 
      - $import: TransDecoder-v5-genetic_codes.yaml
#hints:
#  SoftwareRequirement:
#    packages:
#      transdecoder:
#        specs: [ "" ]
#        version: [ "5.0.0", "5.0.1", "5.0.2" ]

inputs:
  longOpenReadingFrames: Directory
  transcriptsFile:
    label: "transcripts.fasta"
    type: File
    doc: "FASTA formatted sequence file containing your transcripts."
#    format: edam:format_1929  # FASTA
    inputBinding:
      prefix: -t
  retainLongOrfsMode:
    label: "Retain long ORFs mode"
    type: string?
    doc: "'dynamic' (default) or 'strict'. In dynamic mode, sets range according to 1%FDR in random sequence of same GC content."
    inputBinding:
      prefix: --retain_long_orfs_mode
  retainLongOrfsLength:
    label: "Retain long ORFs length"
    type: int?
    doc: |
          Under 'strict' mode, retain all ORFs found that are equal or longer than these many nucleotides
          even if no other evidence marks it as coding (default: 1000000) so essentially turned off by default.
    inputBinding:
      prefix: --retain_long_orfs_length
  retainPfamHits:
    label: "Retain Pfam hits"
    type: string?
    doc: |
          Domain table output file from running hmmscan to search Pfam (see transdecoder.github.io for info).
          Any ORF with a pfam domain hit will be retained in the final output.
    inputBinding:
      prefix: --retain_pfam_hits
  retainBlastpHits:
    label: "Retain Blastp hits"
    type: string?
    doc: |
          blastp output in '-outfmt 6' format.
          Any ORF with a blast match will be retained in the final output.
    inputBinding:
      prefix: --retain_blastp_hits
  singleBestOnly:
    label: "Single best only"
    type: boolean?
    doc: "Retain only the single best ORF per transcript (prioritized by homology then ORF length)"
    inputBinding:
      prefix: --single_best_only
  geneticCode:
    label: "genetic code"
    type: TransDecoder-v5-genetic_codes.yaml#genetic_codes[]?
    doc: "genetic code (default: universal; see PerlDoc; options: Euplotes, Tetrahymena, Candida, Acetabularia)"
    inputBinding:
      prefix: -G
  noRefineStarts:
    label: "No refine starts"
    type: boolean?
    doc: "Start refinement identifies potential start codons for 5' partial ORFs using a PWM, process on by default."
    inputBinding:
      prefix: --no_refine_starts
  train:
    label: "minimum protein length"
    type: int?
    doc: |
          If no --train, top longest ORFs to train Markov Model (hexamer stats) (default: 500)
          Note, 10x this value are first selected for removing redundancies,
          and then this -T value of longest ORFs are selected from the non-redundant set.
    inputBinding:
      prefix: -T

baseCommand: TransDecoder.Predict

outputs:
  peptide_sequences:
    type: File
    format: edam:format_1929  # FASTA
    outputBinding:
      glob: $(inputs.transcriptsFile.basename).transdecoder.pep
  coding_regions:
    type: File
    format: edam:format_1929  # FASTA
    outputBinding:
      glob: $(inputs.transcriptsFile.basename).transdecoder.cds
  gff3_output:
    type: File
    format: edam:format_1975  # GFF3
    outputBinding:
      glob: $(inputs.transcriptsFile.basename).transdecoder.gff3
  bed_output:
    type: File
    format: edam:format_3003  # BED
    outputBinding:
      glob: $(inputs.transcriptsFile.basename).transdecoder.bed

$namespaces:
 s: http://schema.org/
 edam: http://edamontology.org/
$schemas:
 - http://edamontology.org/EDAM_1.20.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute, 2018"
