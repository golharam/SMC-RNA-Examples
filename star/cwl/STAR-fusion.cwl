#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [STAR-Fusion]

doc: "STAR Fusion Detection"

hints:
  DockerRequirement:
    dockerPull: dreamchallenge/star

requirements:
  - class: InlineJavascriptRequirement

inputs:

  index: Directory

  J:
    type: File
    inputBinding:
      prefix: -J
      position: 1

  output_dir:
    type: string
    inputBinding:
      prefix: --output_dir
      position: 2

  threads:
    type: int?
    inputBinding:
      prefix: --CPU
      position: 2

outputs:

  output:
    type: File
    outputBinding:
      glob: $(inputs.output_dir+'/star-fusion.fusion_candidates.final.abridged')

arguments:
  - valueFrom: $(inputs.index.listing[0].path)
    prefix: --genome_lib_dir
    position: 0