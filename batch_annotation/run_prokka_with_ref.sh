#!/bin/bash

annot_dir="annotate"
fastadir="ForProkka"
extension=".fa"
cpus=16

mkdir ${annot_dir}

allfasta=("${fastadir}"/*"${extension}")

for file in ${allfasta[@]}
do
bname=$(basename $file ${extension})

prokka --cpus $cpus --kingdom Bacteria --locustag $bname \
--addgenes --proteins ref_genome4512i_CP117033.1.gb --outdir ${annot_dir}/${bname} --prefix ${bname} $file
done
