#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=02:00:00
#SBATCH --job-name=fastp
#SBATCH --mail-user=tushar.singh@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/tsingh/output_fastp_%j.o
#SBATCH --error=/data/users/tsingh/error_fastp_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/tsingh/assembly_annotation_course

module load fastp/0.23.4-GCC-10.3.0

# -----------------------------
# Illumina RNA-seq: filtering
# -----------------------------

fastp \
    -i $WORKDIR/RNAseq_Sha/ERR754081_1.fastq.gz \
    -I $WORKDIR/RNAseq_Sha/ERR754081_2.fastq.gz \
    -o $WORKDIR/read_QC/fastp/ERR754081_1.trimmed.fastq.gz \
    -O $WORKDIR/read_QC/fastp/ERR754081_2.trimmed.fastq.gz \
    -h $WORKDIR/read_QC/fastp/RNAseq_Sha_fastp.html \
    -j $WORKDIR/read_QC/fastp/RNAseq_Sha_fastp.json

# -----------------------------
# PacBio HiFi: statistics only
# -----------------------------

fastp \
    -i $WORKDIR/Qar-8a/ERR11437336.fastq.gz \
    -o $WORKDIR/read_QC/fastp/ERR11437336.fastq.gz \
    --disable_adapter_trimming \
    --disable_quality_filtering \
    --disable_length_filtering \
    -h $WORKDIR/read_QC/fastp/Qar-8a_fastp.html \
    -j $WORKDIR/read_QC/fastp/Qar-8a_fastp.json
