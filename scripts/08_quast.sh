#!/bin/bash

#SBATCH --job-name=quast_Qar8a
#SBATCH --output=quast_Qar8a_%j.out
#SBATCH --error=quast_Qar8a_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16

WORKDIR=/data/users/tsingh/assembly_annotation_course
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
GFF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.57.gff3

mkdir -p $WORKDIR/assemblies/quast/no_reference
mkdir -p $WORKDIR/assemblies/quast/with_reference

apptainer exec \
    --bind /data:/data \
    /containers/apptainer/quast_5.2.0.sif \
    quast.py \
    --eukaryote \
    --large \
    --est-ref-size 135000000 \
    --threads 16 \
    --labels flye,hifiasm,lja \
    -o $WORKDIR/assemblies/quast/no_reference \
    $WORKDIR/assemblies/flye/assembly.fasta \
    $WORKDIR/assemblies/hifiasm/Qar8a.bp.p_ctg.fa \
    $WORKDIR/assemblies/lja/assembly.fasta

apptainer exec \
    --bind /data:/data \
    /containers/apptainer/quast_5.2.0.sif \
    quast.py \
    --eukaryote \
    --large \
    --threads 16 \
    --labels flye,hifiasm,lja \
    -r $REF \
    --features $GFF \
    -o $WORKDIR/assemblies/quast/with_reference \
    $WORKDIR/assemblies/flye/assembly.fasta \
    $WORKDIR/assemblies/hifiasm/Qar8a.bp.p_ctg.fa \
    $WORKDIR/assemblies/lja/assembly.fasta
