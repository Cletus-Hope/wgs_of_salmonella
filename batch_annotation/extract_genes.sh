#!/bin/bash

# Loop over all .gff files in the current directory (or modify the path)
for gff in *.gff; do
    # Get the base name without extension (e.g., "sample1.gff" → "sample1")
    sample=$(basename "$gff" .gff)

    # Extract gene names from CDS or gene features and write to output file
    grep -v '^#' "$gff" | awk -F'\t' '
        $3=="gene" || $3=="CDS" || $3=="tRNA" || $3=="rRNA" || $3=="tmRNA" {
            split($9, fields, ";");
            for (i in fields) {
                if (fields[i] ~ /^gene=/) {
                    split(fields[i], kv, "=");
                    print kv[2];
                }
            }
        }
    ' > "${sample}_genes.txt"
done