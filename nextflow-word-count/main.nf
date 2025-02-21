#!/usr/bin/env nextflow

nextflow.enable.dsl=2

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

// Process to count words
process countWords {
    tag "counting ${file.baseName}"
    publishDir params.output, mode: 'copy'

    input:
    path file

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

// Main workflow
workflow {
    // Define the input channel
    text_files = Channel.fromPath(params.input)
    
    // Execute the process
    countWords(text_files)
}

// Completion handler
workflow.onComplete {
    log.info "Pipeline completed at: $workflow.complete"
    log.info "Execution status: ${ workflow.success ? 'SUCCESS' : 'FAILED' }"
}