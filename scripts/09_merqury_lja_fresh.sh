#!/bin/bash
#SBATCH --job-name=merqury_lja
#SBATCH --output=merqury_lja_%j.out
#SBATCH --error=merqury_lja_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16

WORKDIR=/data/users/tsingh/assembly_annotation_course
MERQURY=/usr/local/share/merqury
OUTDIR=$WORKDIR/assemblies/merqury_lja_fresh

cd "$OUTDIR" || exit 1

apptainer exec --bind /data:/data \
  /containers/apptainer/merqury_1.3.sif \
  meryl count k=21 output Qar8a_reads.meryl \
  "$WORKDIR/Qar-8a/ERR11437336.fastq.gz"

apptainer exec --bind /data:/data \
  --env MERQURY="$MERQURY" \
  /containers/apptainer/merqury_1.3.sif \
  bash "$MERQURY/merqury.sh" \
  Qar8a_reads.meryl "$WORKDIR/assemblies/lja/assembly.fasta" lja
