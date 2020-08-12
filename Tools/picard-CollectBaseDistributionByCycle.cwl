#!/usr/bin/env cwl-runner

class: CommandLineTool
id: picard-CollectBaseDistributionByCycle-2.23.3
label: picard-CollectBaseDistributionByCycle-2.23.3
cwlVersion: v1.0

$namespaces:
  edam: 'http://edamontology.org/'

hints:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/picard:2.23.3--0'

requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 20000

baseCommand: [ java, -Xmx12G, -jar, /usr/local/share/picard-2.23.3-0/picard.jar, CollectBaseDistributionByCycle ]

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
      position: 2
    doc: FastA file for reference genome

outputs:
  - id: collect_base_dist_by_cycle
    type: File
    outputBinding:
      glob: $(inputs.in_bam.basename).collect_base_dist_by_cycle
  - id: chart
    type: File
    outputBinding:
      glob: $(inputs.in_bam.basename).collect_base_dist_by_cycle.chart.pdf
  - id: log
    type: stderr

stderr: $(inputs.in_bam.basename).collect_base_dist_by_cycle.log

arguments:
  - position: 3
    valueFrom: "OUTPUT=$(inputs.in_bam.basename).collect_base_dist_by_cycle"
  - position: 4
    valueFrom: "CHART=$(inputs.in_bam.basename).collect_base_dist_by_cycle.chart.pdf"
