#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0
baseCommand: ["java"]
arguments:
- -cp
- /data/annotation/annotation_foreground.jar
- org.forome.annotation.annotator.main.AnnotatorMainFork
- -config
- /data/annotation/config.json
- -inventory
- $(inputs.directory.path)/$(inputs.case_name).cfg

inputs:
  case_name:
    type: string
  directory:
    type: Directory

outputs:
  out:
    type: stdout

stdout: java_annotation.log
