#!/bin/bash

#SBATCH --job-name=mummerplot_Qar8a
#SBATCH --output=mummerplot_Qar8a_%j.out
#SBATCH --error=mummerplot_Qar8a_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4

WORKDIR=/data/users/tsingh/assembly_annotation_course
OUTDIR=$WORKDIR/assemblies/mummer

for COMP in flye_vs_ref hifiasm_vs_ref lja_vs_ref flye_vs_hifiasm flye_vs_lja hifiasm_vs_lja
do
    apptainer exec \
        --bind /data:/data \
        /containers/apptainer/mummer4_gnuplot.sif \
        mummerplot \
        --filter \
        -t png \
        --large \
        --layout \
        --fat \
        -p $OUTDIR/$COMP \
        $OUTDIR/$COMP.delta
done
