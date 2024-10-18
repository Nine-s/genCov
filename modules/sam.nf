process SORT_AND_GET_STAT {
    container 'staphb/samtools:1.21'
    publishDir params.outdir, pattern: "*.txt"

    input:
    tuple val(sample_id), path(reads)
    
    output:
    tuple val(sample_id), path("${sample_id}_filtered.bam"), emit:bam
    path("${sample_id}_mapping_stats.txt")

    script:
    """
    samtools flagstat ${sample_id}.sam > ${sample_id}_mapping_stats.txt
    samtools sort -o ${sample_id}_filtered.bam ${sample_id}.sam
    """
}
