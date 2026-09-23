#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=tushar.singh@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/tsingh/output_fastqc_%j.o
#SBATCH --error=/data/users/tsingh/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/tsingh/assembly_annotation_course

module load FastQC/0.11.9-Java-11

fastqc \
    $WORKDIR/Qar-8a/ERR11437336.fastq.gz \
    $WORKDIR/RNAseq_Sha/ERR754081_1.fastq.gz \
    $WORKDIR/RNAseq_Sha/ERR754081_2.fastq.gz \
    --outdir $WORKDIR/read_QC/fastqc
