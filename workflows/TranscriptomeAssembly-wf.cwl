cwlVersion: v1.0
class: Workflow
label: Transcriptome assembly workflow

requirements:
 SchemaDefRequirement:
   types:
    - $import: ../tools/Trimmomatic/trimmomatic-end_mode.yaml
    - $import: ../tools/Trimmomatic/trimmomatic-sliding_window.yaml
    - $import: ../tools/Trimmomatic/trimmomatic-phred.yaml
    - $import: ../tools/Trimmomatic/trimmomatic-illumina_clipping.yaml
    - $import: ../tools/Trimmomatic/trimmomatic-max_info.yaml
 InlineJavascriptRequirement: {}
 ShellCommandRequirement: {}

inputs:
  read_files:
    type: File[]
    format: edam:format_1930  # Zipped fastq
    doc: FASTQ file of reverse reads in Paired End mode
  forward_reads:
    type: File
    format: edam:format_1930  # Zipped fastq
  reverse_reads:
    type: File?
    format: edam:format_1930  # Zipped fastq
  end_mode: ../tools/Trimmomatic/trimmomatic-end_mode.yaml#end_mode
  trinity_max_mem:
    type: string
  trinity_cpu:
    type: int?
  trinity_seq_type:
    type:
      type: enum
      symbols:
        - fa
        - fq
  trinity_ss_lib_type:
    type:
      type: enum
      symbols:
        - FR
        - RF
        - F
        - R

outputs:
  raw_qc_report:
    type: File[]
#    format: TODO: Zip format not found in edam ontology
    outputSource: generate_raw_stats/zipped_report
  raw_html_report:
    type: File[]
    format: edam:format_2331
    outputSource: generate_raw_stats/html_report
  filtered_qc_report:
    type: File[]
    outputSource: generate_filtered_stats/zipped_report
  filtered_html_report:
    type: File[]
    format: edam:format_2331
    outputSource: generate_filtered_stats/html_report
  trimmomatic_log_file:
      type: File?
      outputSource: filter_reads/log_file
  forward_reads_paired:
    type: File
    format: edam:format_1930
    outputSource: filter_reads/reads1_trimmed
  forward_reads_unpaired:
    type: File?
    format: edam:format_1930
    outputSource: filter_reads/reads1_trimmed_unpaired
  reverse_reads_paired:
    type: File?
    format: edam:format_1930
    outputSource: filter_reads/reads2_trimmed_paired
  reverse_reads_unpaired:
    type: File?
    format: edam:format_1930
    outputSource: filter_reads/reads2_trimmed_unpaired
  assembly_output_dir:
    type: Directory
    outputSource: run_assembly/assembly_dir
  assembled_contigs:
    type: File
    format: edam:format_1929 # FASTA
    outputSource: run_assembly/assembled_contigs
#    TODO: Get this back in
#  evaluation_matrix:
#    type: File
#    format: edam:format_3752 # CSV
#    outputSource: evaluate_contigs/evaluation_matrix
  transrate_output_dir:
    type: Directory
    outputSource: evaluate_contigs/transrate_output_dir

steps:
  generate_raw_stats:
    label: Generates a QC for the provided read file(s).
    doc: |
       Provide reverse and forward read files for paired-end (PE)
       or a single read file for single-end (SE).
    run: ../tools/FastQC/FastQC-v0.11.7.cwl
    in:
      in_fastq: read_files
    out: [ zipped_report, html_report ]

  filter_reads:
    doc: |
        Low quality trimming (low quality ends and sequences with < quality scores
        less than 15 over a 4 nucleotide wide window are removed)
    run: ../tools/Trimmomatic/trimmomatic.cwl
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
    out: [log_file, reads1_trimmed, reads1_trimmed_unpaired, reads2_trimmed_paired, reads2_trimmed_unpaired]

  run_assembly:
    label: Runs the actual assembly
    run: ../tools/Trinity/Trinity-V2.6.5.cwl
    in:
      left_reads: filter_reads/reads1_trimmed
      right_reads: filter_reads/reads2_trimmed_paired
      single reads:
        - filter_reads/reads1_trimmed
      max_mem: trinity_max_mem
      cpu: trinity_cpu
      seq_type: trinity_seq_type
      ss_lib_type: trinity_ss_lib_type
    out: [ assembly_dir, assembled_contigs ]

  generate_filtered_stats:
    label: Generates a QC for the filtered read file(s).
    doc: |
         Provide filtered read files
    run: ../tools/FastQC/FastQC-v0.11.7.cwl
    in:
      in_fastq: [ filter_reads/reads1_trimmed, filter_reads/reads2_trimmed_paired ]
    out: [ zipped_report, html_report ]

  evaluate_contigs:
    label: Evaluates the contig quality.
    run: ../tools/Transrate/Transrate-V1.0.3.cwl
    in:
      in_fasta: run_assembly/assembled_contigs
      left_fastq: forward_reads
      right_fastq: reverse_reads
    out: [ transrate_output_dir ]

$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/
$schemas:
 - http://edamontology.org/EDAM_1.16.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"