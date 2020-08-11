#!/usr/bin/env cwl-runner

class: CommandLineTool
id: picard-CollectWgsMetrics-2.22.5
label: picard-CollectWgsMetrics-2.22.5
cwlVersion: v1.0

$namespaces:
  edam: 'http://edamontology.org/'

hints:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/picard:2.22.5--0'

requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 20000

baseCommand: [ java, -Xmx12G, -jar, /usr/local/share/picard-2.22.5-0/picard.jar, CollectWgsMetrics ]

inputs:
  - id: in_bam
    type: File
    format: edam:format_2572
    inputBinding:
      prefix: "INPUT="
      position: 1
    doc: input BAM alignment file
  - id: reference
    type: File
    format: edam:format_1929
    secondaryFiles:
      - .fai
    inputBinding:
      prefix: "REFERENCE_SEQUENCE="
      position: 3
    doc: FastA file for reference genome
  - id: reference_interval_name
    type: string
  - id: reference_interval_list
    type: File
    inputBinding:
      prefix: "INTERVALS="
      position: 4
    doc: Interval list for reference genome
  - id: minimum_base_quality
    type: int?
    inputBinding:
      prefix: "MINIMUM_BASE_QUALITY="
      position: 5
    doc: Minimum base quality for a base to contribute coverage
  - id: minimum_mapping_quality
    type: int?
    inputBinding:
      prefix: "MINIMUM_MAPPING_QUALITY="
      position: 6
    doc: Minimum mapping quality for a read to contribute coverage

outputs:
  - id: wgs_metrics
    type: File
    outputBinding:
      glob: $(inputs.in_bam.basename).$(inputs.reference_interval_name).wgs_metrics
  - id: log
    type: stderr

stderr: $(inputs.in_bam.basename).$(inputs.reference_interval_name).wgs_metrics.log

arguments:
  - position: 2
    valueFrom: "OUTPUT=$(inputs.in_bam.basename).$(inputs.reference_interval_name).wgs_metrics"
  - position: 5
    valueFrom: "TMP_DIR=temp"
  - position: 6
    valueFrom: "VALIDATION_STRINGENCY=LENIENT"
