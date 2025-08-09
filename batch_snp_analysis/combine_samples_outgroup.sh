#!/bin/bash

# Define the output file
output_file="snippy_samples.txt"
> "$output_file"  # Create or clear the output file

# List of directories to process
directories=("UKSR_clean.fastq.gz" "v1_clean.fastq.gz" "v2_clean.fastq.gz" "v3_clean.fastq.gz")

# Loop through each directory
for dir in "${directories[@]}"; do
    # Find the paired-end read files in the directory
    for r1 in "$dir"/*_R1_clean.fastq.gz; do
        r2="${r1/_R1_clean.fastq.gz/_R2_clean.fastq.gz}"
        if [[ -f $r1 && -f $r2 ]]; then
            # Write the sample name and file paths to the output file
            sample_name=$(basename "$r1" | sed 's/_R1_clean.fastq.gz//')
            echo -e "$sample_name\t$r1\t$r2" >> "$output_file"
        fi
    done
done

# Add the assembled S. Heidelberg genome as a sample (2-column format)
heidelberg_fasta="v3_clean.fastq.gz/s_heidelberg.fasta"
if [[ -f $heidelberg_fasta ]]; then
    echo -e "s_heidelberg\t$heidelberg_fasta" >> "$output_file"
fi
