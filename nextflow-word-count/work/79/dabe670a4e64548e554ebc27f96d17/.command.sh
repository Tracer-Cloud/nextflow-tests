#!/bin/bash -ue
echo "File analysis: file2" > file2_counts.txt
echo "Total lines: $(wc -l < file2.txt)" >> file2_counts.txt
echo "Total words: $(wc -w < file2.txt)" >> file2_counts.txt
echo "Unique words: $(tr '[:space:]' '\n' < file2.txt | sort | uniq | wc -l)" >> file2_counts.txt
