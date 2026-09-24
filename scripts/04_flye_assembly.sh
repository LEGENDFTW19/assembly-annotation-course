#!/bin/bash

#SBATCH --job-name=flye_Qar8a
#SBATCH --output=flye_Qar8a_%j.out
#SBATCH --error=flye_Qar8a_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16

WORKDIR=/data/users/tsingh/assembly_annotation_course

apptainer exec \
    --bind /data:/data \
    /containers/apptainer/flye_2.9.5.sif \
    flye \
    --pacbio-hifi $WORKDIR/Qar-8a/ERR11437336.fastq.gz \
    --out-dir $WORKDIR/assemblies/flye \
    --genome-size 135m \
    --threads 16
