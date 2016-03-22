#!/usr/bin/env cwl-runner

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/
  doap: http://usefulinc.com/ns/doap#
  adms: http://www.w3.org/ns/adms#
  dcat: http://www.w3.org/ns/dcat#

$schemas:
- http://dublincore.org/2012/06/14/dcterms.rdf
- http://xmlns.com/foaf/spec/20140114.rdf
- http://usefulinc.com/ns/doap#
- http://www.w3.org/ns/adms#
- http://www.w3.org/ns/dcat.rdf

cwlVersion: "cwl:draft-3.dev3"

class: CommandLineTool

# Details about the command line tool
adms:includedAsset:
  doap:name: "Sage"
  doap:description: |

  doap:homepage: "http://ccb.jhu.edu/software/tophat/fusion_tutorial.shtml"
  dcat:downloadURL: "http://ccb.jhu.edu/software/tophat/tutorial.shtml#inst"
  doap:release:
  - class: doap:Version
    doap:revision: "2"
  doap:license: "GPL"
  doap:category: "commandline tool"
  doap:programming-language: "C"
  foaf:publications:
  doap:developer:

description: |
  tophat2.cwl is developed for SMC-RNA Challenge

  Original tool usage: #update tool usage


doap:name: "tophat2.cwl"
dcat:downloadURL: "" #Github Repo here later

doap:maintainer:
- class: foaf:Organization
  foaf:name: "Sage Bionetworks"
  foaf:member:
  - class: foaf:Person
    id: ""
    foaf:openid: ""
    foaf:name: ""
    foaf:mbox: ""

#Import other CWL files
requirements:
  - class: InlineJavascriptRequirement
  - $import: envvar-global.cwl
  - $import: tophat2-docker.cwl

# The position determines where the commands are placed in command line
inputs:

  ## Not required fields ##
  #Adding the ["null",type] allows you to designate a variable that is not required,
  #Don't input a prefix field and it won't display a prefix

  - id: "#r"
    type: ["null",int]
    inputBinding:
      position: 1
      prefix: "-r"

  - id: "#p"
    type: ["null",int]
    description: | 
      Change number of threads used
    inputBinding:
      position: 1
      prefix: "-p"

  - id: "#mate-std-dev"
    type: ["null",int]
    inputBinding:
      position: 1
      prefix: "--mate-std-dev"

  - id: "#max-intron-length"
    type: ["null",int]
    inputBinding:
      position: 1
      prefix: "--max-intron-length" 

  - id: "#fusion-min-dist"
    type: ["null",int]
    inputBinding:
      position: 1
      prefix: "--fusion-min-dist" 

  - id: "#fusion-anchor-length"
    type: ["null",int]
    inputBinding:
      position: 1
      prefix: "--fusion-anchor-length" 

  - id: "#fusion-ignore-chromosomes"
    type: ["null",string]
    inputBinding:
      position: 1
      prefix: "--fusion-ignore-chromosomes" 

  # Boolean values, shows prefix only
  - id: "#fusion-search"
    type: boolean
    default: false
    description: | 
      Turn on fusion algorithm (tophat-fusion)
    inputBinding:
      prefix: "--fusion-search"
      position: 1

  - id: "#keep-fasta-order"
    type: boolean
    default: false
    description: | 
      Keep ordering of fastq file
    inputBinding:
      prefix: "--keep-fasta-order"
      position: 1
  
  - id: "#bowtie1"
    type: boolean
    default: false
    description: | 
      Use bowtie1
    inputBinding:
      prefix: "--bowtie1"    
      position: 1

  - id: "#no-coverage-search"
    type: boolean
    default: false
    description: | 
      Turn off coverage-search, which takes lots of memory and is slow
    inputBinding:
      prefix: "--no-coverage-search"    
      position: 1

  ## Required files ##
  - id: "#bowtie_index"
    type: string
    inputBinding:
      position: 2
  
  - id: "#fastq1"
    type: File
    inputBinding:
      position: 3

  - id: "#fastq2"
    type: File
    inputBinding:
      position: 4
  
  ## output of tophat is the directory ##
  - id: "#output_folder"
    type: string
    inputBinding:
      prefix: "-o"
      position: 5


outputs:
  - id: "#tophatOut"
    type: File
    outputBinding:
      # The output file is align_summary.txt
      # Make sure the output files match
      glob: $(inputs.output_folder+'/fusions.out')

baseCommand: ["tophat"]