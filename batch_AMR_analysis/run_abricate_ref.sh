#!/bin/bash

# Script to run ABRicate (ResFinder) and export Excel-friendly results

# Check input
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file.gbk>"
    exit 1
fi

INPUT="$1"
BASENAME=$(basename "$INPUT" .gbk)
OUTDIR="resfinder_results"

# Create output directory
mkdir -p "$OUTDIR"

# Run ABRicate with ResFinder and save .tsv output
echo "Running ABRicate with ResFinder on: $INPUT"
abricate --db resfinder "$INPUT" > "${OUTDIR}/${BASENAME}_resfinder.tsv"

# Generate Excel-friendly summary (tab-delimited)
abricate --summary "${OUTDIR}/${BASENAME}_resfinder.tsv" > "${OUTDIR}/${BASENAME}_resfinder_summary.tsv"

echo "Done."
echo "Open these files in Excel:"
echo "  → ${OUTDIR}/${BASENAME}_resfinder.tsv"
echo "  → ${OUTDIR}/${BASENAME}_resfinder_summary.tsv"

