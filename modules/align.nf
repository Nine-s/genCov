process READ_MAPPING {
    container 'pegi3s/bwa:0.7.17'

    input:
    tuple val(sample_id), path(reads) 
    path(reference_genome)    

    output:
    tuple val(sample_id), path("${sample_id}.sam"), emit:sam

    script:
    """
    bwa index ${reference_genome}
    bwa mem ${reference_genome} ${reads} > ${sample_id}.sam
    """
}
