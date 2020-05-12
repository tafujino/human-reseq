#!/usr/bin/env cwl-runner

class: CommandLineTool
id: samtools-idxstats-1.6
label: samtools-idxstats-1.6
cwlVersion: v1.0

$namespaces:
  edam: 'http://edamontology.org/'

hints:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/samtools:1.6--0'

requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 4000

baseCommand: [ samtools, idxstats ]

inputs:
  - id: in_cram
    type: File
    format: edam:format_3462
    inputBinding:
      position: 1
    doc: input CRAM alignment file
    secondaryFiles:
      - ^.crai

outputs:
  - id: idxstats
    type: stdout

stdout: $(inputs.in_cram.basename).idxstats

arguments: []
