cwlVersion: v1.0
class: Workflow
label: Transcriptome assembly workflow

inputs:
  read_files:
    type: File[]
    format: edam:format_1930  # Zipped fastq
    doc: FASTQ file of reverse reads in Paired End mode
  forward_reads:
    type: File?
    format: edam:format_1930  # Zipped fastq
  reverse_reads:
    type: File?
    format: edam:format_1930  # Zipped fastq
  end_mode:
    type:
      type: enum
      symbols:
        - SE
        - PE
  trinity_library_type:
    type:
      type: enum
      symbols:
        - FR
        - RF
  trinity_max_mem:
    type: int
  trinity_cpu:
    type: int?
  trinity_normalized_reads:
    type: boolean?

outputs:
  raw_qc_report:
    type: File
#    format: TODO: Zip format not found in edam ontology
    outputSource: generate_raw_stats/raw_qc_report
  raw_html_report:
    type: File
    format: edam:format_2331
    outputSource: generate_raw_stats/raw_html_report
  filtered_qc_report:
    type: File
    outputSource: generate_filtered_stats/filtered_qc_report
  filtered_html_report:
    type: File
    format: edam:format_2331
    outputSource: generate_filtered_stats/filtered_html_report
  forward_reads_paired:
    type: File
    format: edam:format_1930
  reverse_reads_paired:
    type: File
    format: edam:format_1930
  assembly_output_dir:
    type: Directory
    outputSource: run_assembly/assembly_output_dir
  assembled_contigs:
    type: File
    format: edam:format_1929 # FASTA
    outputSource: run_assembly/assembled_contigs
  evaluation_matrix:
    type: File
    format: edam:format_3752 # CSV
    outputSource: evaluate_contigs/evaluation_matrix
  transrate_output_dir:
    type: Directory
    outputSource: evaluate_contigs/transrate_output_dir

steps:
  generate_raw_stats:
    label: Generates a QC for the provided read file(s).
    doc: |
       Provide reverse and forward read files for paired-end (PE)
       or a single read file for single-end (SE).
    run: ../tools/FASTQC-multi-read-files.cwl
    in:
      read_files: read_files
    out: [ raw_qc_report, raw_html_report ]

  filter_reads:
    doc: |
        Low quality trimming (low quality ends and sequences with < quality scores
        less than 15 over a 4 nucleotide wide window are removed)
    run: ../tools/trimmomatic-v0.36.cwl
    in:
      reads1: forward_reads
      reads2: reverse_reads
      phred: { default: '33' }
      leading: { default: 3 }
      trailing: { default: 3 }
      end_mode: end_mode
      minlen: { default: 100 }
      slidingwindow:
        default:
          windowSize: 4
          requiredQuality: 15
    out: [forward_reads_paired, reverse_reads_paired]

  run_assembly:
    label: Runs the actual assembly
    run: ../tools/Trinity-v2.6.5.cwl
    in:
      forward_reads: filter_reads/forward_reads_paired
      reads_reverse: filter_reads/reverse_reads_paired
      library_type: trinity_library_type
      max_mem: trinity_max_mem
      cpu: trinity_cpu
      normalized_reads: trinity_normalized_reads
    out: [ assembly_output_dir, assembled_contigs ]

  generate_filtered_stats:
    label: Generates a QC for the filtered read file(s).
    doc: |
         Provide filtered read files
    run: ../tools/FASTQC-multi-read-files.cwl
    in:
      read_files: [ filter_reads/forward_reads_paired, filter_reads/reverse_reads_paired ]
    out: [ filtered_qc_report, filtered_html_report ]

  evaluate_contigs:
    label: Evaluates the contig quality.
    run: ../tools/Transrate-v1.0.2.cwl
    in:
      assembled_contigs: run_assembly/assembled_contigs
    out: [ transrate_output_dir, evaluation_matrix ]

$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/
$schemas:
 - http://edamontology.org/EDAM_1.16.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"