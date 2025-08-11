#!/bin/bash

# Script to detect plasmid replicons using ABRicate with PlasmidFinder database

# Usage check
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file.gb>"
    exit 1
fi

INPUT="$1"
BASENAME=$(basename "$INPUT" .gb)
OUTDIR="plasmidfinder_results"

# Create output directory
mkdir -p "$OUTDIR"

# Run ABRicate with PlasmidFinder
echo "Running ABRicate with PlasmidFinder on: $INPUT"
abricate --db plasmidfinder "$INPUT" > "${OUTDIR}/${BASENAME}_plasmidfinder.tsv"

# Create summary
abricate --summary "${OUTDIR}/${BASENAME}_plasmidfinder.tsv" > "${OUTDIR}/${BASENAME}_plasmidfinder_summary.tsv"

echo "Done."
echo "Results saved in: $OUTDIR/"
echo "Files ready for Excel:"
echo "  - ${OUTDIR}/${BASENAME}_plasmidfinder.tsv"
echo "  - ${OUTDIR}/${BASENAME}_plasmidfinder_summary.tsv"

