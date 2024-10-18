process GETCOV {
    container 'ninedm/bedtools-bigwig-py:latest'
    publishDir params.outdir, pattern: "*.bw"
    publishDir params.outdir, pattern: "*.html"

    input:
    tuple val(sample_id), path(bam_file)
    path(index_fasta)

    output:
    path("${sample_id}.bw")
    path("*.html")

    shell:
    '''
    bedtools genomecov -ibam !{bam_file} -bg | \
        awk '{print $1"\t"$2"\t"$3"\t"$4}' > !{sample_id}_coverage.bed
    bedtools sort -i !{sample_id}_coverage.bed > sorted_!{sample_id}_coverage.bed
    python3 !{params.baseDir}bin/display_regions.py
    bedGraphToBigWig sorted_!{sample_id}_coverage.bed !{index_fasta} !{sample_id}.bw
    '''
}
