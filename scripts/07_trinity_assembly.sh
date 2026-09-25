#!/bin/bash

#SBATCH --job-name=trinity_Qar8a
#SBATCH --output=trinity_Qar8a_%j.out
#SBATCH --error=trinity_Qar8a_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16

WORKDIR=/data/users/tsingh/assembly_annotation_course

mkdir -p $WORKDIR/assemblies/trinity

module load Trinity/2.15.1-foss-2021b

Trinity \
    --seqType fq \
    --left $WORKDIR/RNAseq_Sha/ERR754081_1.fastq.gz \
    --right $WORKDIR/RNAseq_Sha/ERR754081_2.fastq.gz \
    --CPU 16 \
    --max_memory 64G \
    --output $WORKDIR/assemblies/trinity
