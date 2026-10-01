#!/bin/bash

#SBATCH --job-name=busco_genomes
#SBATCH --output=busco_genomes_%j.out
#SBATCH --error=busco_genomes_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=16

WORKDIR=/data/users/tsingh/assembly_annotation_course

mkdir -p $WORKDIR/assemblies/busco

for ASM in flye hifiasm lja
do
    if [ "$ASM" = "flye" ]; then
        FASTA=$WORKDIR/assemblies/flye/assembly.fasta
    elif [ "$ASM" = "hifiasm" ]; then
        FASTA=$WORKDIR/assemblies/hifiasm/Qar8a.bp.p_ctg.fa
    elif [ "$ASM" = "lja" ]; then
        FASTA=$WORKDIR/assemblies/lja/assembly.fasta
    fi

    apptainer exec \
        --bind /data:/data \
        /containers/apptainer/busco_5.7.1.sif \
        busco \
        -i $FASTA \
        -o ${ASM}_busco \
        -l brassicales_odb10 \
        -m genome \
        -c 16 \
        --out_path $WORKDIR/assemblies/busco
done
