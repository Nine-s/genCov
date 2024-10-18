nextflow.enable.dsl=2

include { PREPROCESSING } from './modules/preprocessing'
include { READ_MAPPING } from './modules/align'
include { SORT_AND_GET_STAT } from './modules/sam'
include { GETCOV } from './modules/cov'

workflow{

    reads_ch = Channel.fromFilePairs("${params.reads_dir}/*_{1,2}.fastq") 
    
    PREPROCESSING( reads_ch )
    READ_MAPPING( PREPROCESSING.out.sample_preprocessed, params.reference_genome )
    SORT_AND_GET_STAT( READ_MAPPING.out.sam )
    GETCOV( SORT_AND_GET_STAT.out.bam, params.indexed_fasta )
    
}