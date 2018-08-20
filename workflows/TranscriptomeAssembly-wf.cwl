cwlVersion: v1.0
class: Workflow
label: Transcriptome assembly workflow

inputs:
  reads_reverse:
    type: File?
    format: edam:format_1930  # fastq
    doc: FASTQ file of reverse reads in Paired End mode

  reads_forward:
    type: File
    format: edam:format_1930  # fastq
    label: FASTQ file of reads (forward reads in Paired End mode)

outputs:
  qc_reports:
    type: Directory
    outputSource: identify_coding_regions/peptide_sequences
  html_report:
    type: File
    outputSource: identify_coding_regions/coding_regions

steps:
  generate_stats:
    label: TODO: Add label
    run: ../tools/FASTQC-v0.11.5.cwl
    in:
      reads_forward: reads_forward
      reads_reverse: reads_reverse
    out: [ qc_reports, html_report ]

  filter_reads:
    doc: |
        Low quality trimming (low quality ends and sequences with < quality scores
        less than 15 over a 4 nucleotide wide window are removed)
    run: ../tools/trimmomatic.cwl
    in:
      reads1: reads_forward
      reads2: reads_reverse
      phred: { default: '33' }
      leading: { default: 3 }
      trailing: { default: 3 }
      end_mode: { default: PE }
      minlen: { default: 100 }
      slidingwindow:
        default:
          windowSize: 4
          requiredQuality: 15
      out: [reads1_trimmed, reads2_trimmed, others]

$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/
$schemas:
 - http://edamontology.org/EDAM_1.16.owl
 - https://schema.org/docs/schema_org_rdfa.html

s:license: "https://www.apache.org/licenses/LICENSE-2.0"