process PREPROCESSING {
    container 'staphb/fastp:0.23.4'
    publishDir params.outdir, pattern: "report_*"

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("${sample_id}*.trimmed.fastq"), emit: sample_preprocessed
    path "report_${sample_id}_fastp.json", emit: report_fastp_json
    path "report_${sample_id}_fastp.html", emit: report_fastp_html

    script:
    """
    fastp -i ${reads[0]} -I ${reads[1]} -o ${sample_id}.R1.trimmed.fastq -O ${sample_id}.R2.trimmed.fastq --detect_adapter_for_pe --json report_${sample_id}_fastp.json --html report_${sample_id}_fastp.html 
    """
}
