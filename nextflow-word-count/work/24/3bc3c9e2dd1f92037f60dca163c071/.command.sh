#!/bin/bash -ue
# Extract sequences from the FASTQ file (every 2nd line of each 4-line record)
awk 'NR % 4 == 2' sample2.fastq > sample2_sequences.txt

# Count occurrences of DNA letters: A, C, G, T
count_A=$(grep -o 'A' sample2_sequences.txt | wc -l)
count_C=$(grep -o 'C' sample2_sequences.txt | wc -l)
count_G=$(grep -o 'G' sample2_sequences.txt | wc -l)
count_T=$(grep -o 'T' sample2_sequences.txt | wc -l)

# Write the results to the output file
echo "File analysis: sample2" > sample2_dna_counts.txt
echo "Count of A: $count_A" >> sample2_dna_counts.txt
echo "Count of C: $count_C" >> sample2_dna_counts.txt
echo "Count of G: $count_G" >> sample2_dna_counts.txt
echo "Count of T: $count_T" >> sample2_dna_counts.txt

# Remove the temporary file with extracted sequences
rm sample2_sequences.txt

# Sleep for one minute to ensure the pipeline runs for at least 1 minute
sleep 60
