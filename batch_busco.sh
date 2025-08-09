#!/bin/bash

# Output directory for BUSCO results
output_dir="busco_output"
# BUSCO dataset
busco_dataset="bacteria_odb10"

# Create the output directory if it doesn't exist
mkdir -p ${output_dir}

# Loop through each contig file and run BUSCO
for contig_file in *_contigs.fa; do
    sample_name=$(basename ${contig_file} .fa)
    busco -i ${contig_file} -o ${output_dir}/${sample_name} -l ${busco_dataset} -m genome
done
