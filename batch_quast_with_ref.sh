#!/bin/bash

# Run QUAST on all contig files matching the pattern *contigs.fa
quast.py *contigs.fa -r Ref_CP117033.1_sequence.fasta -o quastwithref_output
