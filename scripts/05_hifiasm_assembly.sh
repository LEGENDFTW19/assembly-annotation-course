#!/bin/bash

#SBATCH --job-name=hifiasm_Qar8a
#SBATCH --output=hifiasm_Qar8a_%j.out
#SBATCH --error=hifiasm_Qar8a_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16

WORKDIR=/data/users/tsingh/assembly_annotation_course

mkdir -p $WORKDIR/assemblies/hifiasm

apptainer exec \
    --bind /data:/data \
    /containers/apptainer/hifiasm_0.25.0.sif \
    hifiasm \
    -o $WORKDIR/assemblies/hifiasm/Qar8a \
    -t 16 \
    $WORKDIR/Qar-8a/ERR11437336.fastq.gz

awk '/^S/{print ">"$2;print $3}' \
    $WORKDIR/assemblies/hifiasm/Qar8a.bp.p_ctg.gfa \
    > $WORKDIR/assemblies/hifiasm/Qar8a.bp.p_ctg.fa
