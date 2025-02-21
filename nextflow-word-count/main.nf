#!/usr/bin/env nextflow

// Pipeline parameters
params.input = "$baseDir/data/*.txt"
params.output = "$baseDir/results"

// Log pipeline parameters
log.info """\
         WORD COUNT PIPELINE
         ==================
         input : ${params.input}
         output: ${params.output}
         """

// Define the input channel
Channel
    .fromPath(params.input)
    .set { text_files }

// Process to count words
process countWords {
    tag "counting ${file.baseName}"
    publishDir params.output, mode: 'copy'

    input:
    path file from text_files

    output:
    path "${file.baseName}_counts.txt"

    script:
    """
    echo "File analysis: ${file.baseName}" > ${file.baseName}_counts.txt
    echo "Total lines: \$(wc -l < ${file})" >> ${file.baseName}_counts.txt
    echo "Total words: \$(wc -w < ${file})" >> ${file.baseName}_counts.txt
    echo "Unique words: \$(tr '[:space:]' '\\n' < ${file} | sort | uniq | wc -l)" >> ${file.baseName}_counts.txt
    """
}

workflow.onComplete {
    log.info "Pipeline completed at: $workflow.complete"
    log.info "Execution status: ${ workflow.success ? 'SUCCESS' : 'FAILED' }"
}
