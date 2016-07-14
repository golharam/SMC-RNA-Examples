#!/usr/bin/env cwl-runner
#
# Authors: Thomas Yu, Ryan Spangler, Kyle Ellrott

class: Workflow
cwlVersion: v1.0

doc: "INTEGRATE workflow: untar, tophat align, samtools index, Integrate fusion"

hints:
  - class: synData
    input: index
    entity: syn7058443

inputs: 

  index:
    type: File

  TUMOR_FASTQ_1:
    type: File

  TUMOR_FASTQ_2:
    type: File
    
outputs:

  OUTPUT:
    type: File
    outputSource: integrate/integrate_fusions

steps:

  tar:
    run: ../integrate/cwl/tar.cwl
    in:
      index: index
    out: [output]

  tophat:
    run: ../tophat/cwl/tophat.cwl
    in:
      p: { default: 5 }
      bowtie1: { default: true }
      o: { default: tophat_out }
      bowtie_index: tar/output
      fastq1: TUMOR_FASTQ_1
      fastq2: TUMOR_FASTQ_2
    out: [tophatOut_accepted_hits,tophatOut_unmapped]
  
  samtools_accepted:
    run: ../integrate/cwl/samtools_index.cwl
    in:
      bam: tophat/tophatOut_accepted_hits
    out: [out_index]

  samtools_unmapped:
    run: ../integrate/cwl/samtools_index.cwl
    in:
      bam: tophat/tophatOut_unmapped
    out: [out_index]

  integrate:
    run: ../integrate/cwl/integrate.cwl
    in:
      accepted: samtools_accepted/out_index
      unmapped: samtools_unmapped/out_index
      reference: { default:     }
      o: { default: "fusions.bedpe" }
      index: index
    out: [integrate_fusions]