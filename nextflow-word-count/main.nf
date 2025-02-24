#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Pipeline parameters: specify the input FASTQ files and output directory
params.input = "$baseDir/data/*.fastq"
params.output = "$baseDir/results"

// Log pipeline parameters
log.info """\
         DNA LETTER COUNT PIPELINE
         =========================
         input : ${params.input}
         output: ${params.output}
         """

// Process to count DNA letters in FASTQ files
process countDNALetters {
    tag "counting ${file.baseName}"
    publishDir params.output, mode: 'copy'

    input:
    path file

    output:
    path "${file.baseName}_dna_counts.txt"

    script:
    """
    # Extract sequences from the FASTQ file (every 2nd line of each 4-line record)
    awk 'NR % 4 == 2' ${file} > ${file.baseName}_sequences.txt

    # Count occurrences of DNA letters: A, C, G, T
    count_A=\$(grep -o 'A' ${file.baseName}_sequences.txt | wc -l)
    count_C=\$(grep -o 'C' ${file.baseName}_sequences.txt | wc -l)
    count_G=\$(grep -o 'G' ${file.baseName}_sequences.txt | wc -l)
    count_T=\$(grep -o 'T' ${file.baseName}_sequences.txt | wc -l)

    # Write the results to the output file
    echo "File analysis: ${file.baseName}" > ${file.baseName}_dna_counts.txt
    echo "Count of A: \$count_A" >> ${file.baseName}_dna_counts.txt
    echo "Count of C: \$count_C" >> ${file.baseName}_dna_counts.txt
    echo "Count of G: \$count_G" >> ${file.baseName}_dna_counts.txt
    echo "Count of T: \$count_T" >> ${file.baseName}_dna_counts.txt

    # Remove the temporary file with extracted sequences
    rm ${file.baseName}_sequences.txt

    # Sleep for one minute to ensure the pipeline runs for at least 1 minute
    sleep 60
    """
}

// Main workflow
workflow {
    // Define the input channel for FASTQ files
    fastq_files = Channel.fromPath(params.input)
    
    // Execute the process for counting DNA letters on the FASTQ files
    countDNALetters(fastq_files)
}

// Completion handler
workflow.onComplete {
    log.info "Pipeline completed at: $workflow.complete"
    log.info "Execution status: ${ workflow.success ? 'SUCCESS' : 'FAILED' }"
}
