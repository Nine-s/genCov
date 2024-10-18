# small DAW for genomic coverage exploration

## Description

It consists of four steps:
- PREPROCESSING (fastp)
- READ_MAPPING (bwa)
- SORT_AND_GET_STAT (samtools)
- GETCOV (bedtools + bigwig)

### Input Data

This DAW comes with test input data, located in the `data` folder.

### Output Files

You can find the output files of each step in the `work/` folder.
You can find the important output files of the DAW in the `results` folder.

## Execution

1) unzip the files in `data/reads/`

2) Modify the paths in `nextflow.config`.

3) run `nextflow run main.nf -c nextflow.config`

## Requirements 

- Nextflow
- Docker
