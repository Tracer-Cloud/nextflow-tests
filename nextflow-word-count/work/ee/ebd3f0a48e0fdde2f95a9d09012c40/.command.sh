#!/bin/bash -ue
echo "File analysis: file1" > file1_counts.txt
echo "Total lines: $(wc -l < file1.txt)" >> file1_counts.txt
echo "Total words: $(wc -w < file1.txt)" >> file1_counts.txt
echo "Unique words: $(tr '[:space:]' '\n' < file1.txt | sort | uniq | wc -l)" >> file1_counts.txt
