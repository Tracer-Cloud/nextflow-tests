#!/bin/bash -ue
# Extract sequences from the FASTQ file (every 2nd line of each 4-line record)
awk 'NR % 4 == 2' sample1.fastq > sample1_sequences.txt

# Count occurrences of DNA letters: A, C, G, T
count_A=$(grep -o 'A' sample1_sequences.txt | wc -l)
count_C=$(grep -o 'C' sample1_sequences.txt | wc -l)
count_G=$(grep -o 'G' sample1_sequences.txt | wc -l)
count_T=$(grep -o 'T' sample1_sequences.txt | wc -l)

# Write the results to the output file
echo "File analysis: sample1" > sample1_dna_counts.txt
echo "Count of A: $count_A" >> sample1_dna_counts.txt
echo "Count of C: $count_C" >> sample1_dna_counts.txt
echo "Count of G: $count_G" >> sample1_dna_counts.txt
echo "Count of T: $count_T" >> sample1_dna_counts.txt

# Remove the temporary file with extracted sequences
rm sample1_sequences.txt
