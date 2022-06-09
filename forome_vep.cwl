#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.2

baseCommand: ["docker"]

arguments:
- run
- --user
- "1001:1001"
- -e
- 'HOME=/opt/vep'
- --rm
- --init
- -v
- /data/vep/vep-cache-GRCh$(inputs.case_assembly)-release_105.0:/opt/vep/.vep
- -v
- $(inputs.directory.path):/data
- ensemblorg/ensembl-vep:release_105.0
- vep
- --buffer_size
- "50000"
- --cache
- --dir
- /opt/vep/.vep
- --dir_cache
- /opt/vep/.vep
- --port
- $(inputs.port)
- --fork
- "4"
- --force_overwrite
- --merged
- --json
- --input_file
- /data/$(inputs.file_vcf.basename)
- --output_file
- /data/$(inputs.case_name).vep.json
- --plugin
- ExACpLI,/opt/vep/.vep/Plugins/ExACpLI_values.txt
- --plugin
- MaxEntScan,/opt/vep/.vep/Plugins/fordownload
- --plugin
- LoFtool,/opt/vep/.vep/Plugins/LoFtool_scores.txt
- --plugin
- SpliceRegion
- --everything

inputs:
  file_vcf:
    type: File
  case_name:
    type: string
  case_assembly:
    type: int
  directory:
    type: Directory
  port:
    type: int

outputs:
  out:
    type: stdout
