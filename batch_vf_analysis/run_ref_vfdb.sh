#!/bin/bash

# Script to run ABRicate using the VFDB database on a FASTA file
# Outputs Excel-compatible TSV files

# Usage check
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file.fna or .fasta>"
    exit 1
fi

INPUT="$1"
BASENAME=$(basename "$INPUT" .fna)
BASENAME=$(basename "$BASENAME" .fasta)
OUTDIR="vfdb_results"

# Create output directory
mkdir -p "$OUTDIR"

# Run ABRicate with VFDB
echo "Running ABRicate with VFDB on: $INPUT"
abricate --db vfdb "$INPUT" > "${OUTDIR}/${BASENAME}_vfdb.tsv"

# Generate summary (tab-delimited for Excel)
abricate --summary "${OUTDIR}/${BASENAME}_vfdb.tsv" > "${OUTDIR}/${BASENAME}_vfdb_summary.tsv"

echo "Done."
echo "Results saved to: $OUTDIR/"
echo "You can open the .tsv files in Excel:"
echo "  → ${OUTDIR}/${BASENAME}_vfdb.tsv"
echo "  → ${OUTDIR}/${BASENAME}_vfdb_summary.tsv"

