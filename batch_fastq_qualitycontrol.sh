#!/bin/bash

# List of sample IDs
sample_ids=("P001" "P002" "P003" "P004" "P005" "P006" "P007" "P008" "P009" "P010" "P011" "P012" "P013" "P014" "P015" "P016" "P017" "P018" "P019" "P020" "P021" "P022" "P023" "P024" "P025" "P026" "P027" "P028" "P029" "P030" "P031" "P032" "P033" "P034" "P035" "P036" "P037" "P038" "P039" "P040" "P041" "P042" "P043" "P044" "P045" "P046" "P047" "P048" "P049" "P050" "P051" "P052" "P053" "P054" "P055" "P056" "P057" "P058" "P059" "P060" "P061" "P062" "P063" "P064" "P065" "P066" "P067" "P068" "P069" "P070" "P071" "P072" "P073" "P074" "P075" "P076" "P077" "P078" "P079" "P080" "P081" "P082" "P083" "P084" "P085" "P086" "P087" "P088" "P089" "P090" "P091" "P092" "P093" "P094" "P095" "P096")

# Loop through each sample ID
for sample_id in "${sample_ids[@]}"; do
    R1="${sample_id}_R1.fastq.gz"
    R2="${sample_id}_R2.fastq.gz"
    output_R1="${sample_id}_R1_clean.fastq.gz"
    output_R2="${sample_id}_R2_clean.fastq.gz"
    

 # Run fastp for each sample with additional options
    fastp \
        -i ${R1} -I ${R2} \
        -o ${output_R1} -O ${output_R2} \
        -h ${sample_id}_fastp.html -j ${sample_id}_fastp.json \
        --cut_front 20 --cut_by_quality3 20 \
        --detect_adapter_for_pe \
        --dedup \
        --dup_calc_accuracy 6 \
        --overrepresentation_analysis \
        --qualified_quality_phred 30 \
        --length_required 50 \
        --low_complexity_filter \
        --overrepresentation_sampling 20
    
    echo "Processed ${sample_id}"
done
