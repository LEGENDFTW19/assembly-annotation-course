#!/bin/bash

#SBATCH --job-name=lja_Qar8a
#SBATCH --output=lja_Qar8a_%j.out
#SBATCH --error=lja_Qar8a_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16

WORKDIR=/data/users/tsingh/assembly_annotation_course

mkdir -p $WORKDIR/assemblies/lja

apptainer exec \
    --bind /data:/data \
    /containers/apptainer/lja-0.2.sif \
    lja \
    --reads $WORKDIR/Qar-8a/ERR11437336.fastq.gz \
    --output-dir $WORKDIR/assemblies/lja \
    --threads 16
