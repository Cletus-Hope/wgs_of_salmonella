#!/bin/bash

# Define the output file
output_file="abricate_all_dbs.txt"

# Clear the output file if it exists
> "$output_file"

# List of databases
databases=("vfdb")

# Find all contigs.fa files in subdirectories and run abricate on each
find . -type f -name "UKSF*_contigs.fa" | while read -r file; do
    for db in "${databases[@]}"; do
        echo "Running ABRicate on $file with database: $db"
        abricate --db "$db" "$file" >> "$output_file"
    done
done

echo "ABRicate processing complete. Results saved to $output_file."

