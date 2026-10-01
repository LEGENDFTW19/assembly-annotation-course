#!/bin/bash

#SBATCH --job-name=mummer_Qar8a
#SBATCH --output=mummer_Qar8a_%j.out
#SBATCH --error=mummer_Qar8a_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8

WORKDIR=/data/users/tsingh/assembly_annotation_course
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

mkdir -p $WORKDIR/assemblies/mummer

apptainer exec \
    --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    nucmer \
    --prefix $WORKDIR/assemblies/mummer/flye_vs_ref \
    --breaklen 1000 \
    --mincluster 1000 \
    $REF \
    $WORKDIR/assemblies/flye/assembly.fasta

apptainer exec \
    --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    nucmer \
    --prefix $WORKDIR/assemblies/mummer/hifiasm_vs_ref \
    --breaklen 1000 \
    --mincluster 1000 \
    $REF \
    $WORKDIR/assemblies/hifiasm/Qar8a.bp.p_ctg.fa

apptainer exec \
    --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    nucmer \
    --prefix $WORKDIR/assemblies/mummer/lja_vs_ref \
    --breaklen 1000 \
    --mincluster 1000 \
    $REF \
    $WORKDIR/assemblies/lja/assembly.fasta

apptainer exec \
    --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    nucmer \
    --prefix $WORKDIR/assemblies/mummer/flye_vs_hifiasm \
    --breaklen 1000 \
    --mincluster 1000 \
    $WORKDIR/assemblies/flye/assembly.fasta \
    $WORKDIR/assemblies/hifiasm/Qar8a.bp.p_ctg.fa

apptainer exec \
    --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    nucmer \
    --prefix $WORKDIR/assemblies/mummer/flye_vs_lja \
    --breaklen 1000 \
    --mincluster 1000 \
    $WORKDIR/assemblies/flye/assembly.fasta \
    $WORKDIR/assemblies/lja/assembly.fasta

apptainer exec \
    --bind /data:/data \
    /containers/apptainer/mummer4_gnuplot.sif \
    nucmer \
    --prefix $WORKDIR/assemblies/mummer/hifiasm_vs_lja \
    --breaklen 1000 \
    --mincluster 1000 \
    $WORKDIR/assemblies/hifiasm/Qar8a.bp.p_ctg.fa \
    $WORKDIR/assemblies/lja/assembly.fasta
