#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=02:00:00
#SBATCH --job-name=kmer_count
#SBATCH --mail-user=tushar.singh@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/tsingh/output_kmer_%j.o
#SBATCH --error=/data/users/tsingh/error_kmer_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/tsingh/assembly_annotation_course

module load Jellyfish/2.3.0-GCC-10.3.0

# Count canonical 21-mers
jellyfish count \
    -C \
    -m 21 \
    -s 5G \
    -t 4 \
    -o $WORKDIR/read_QC/kmer_counting/Qar8a_k21.jf \
    <(zcat $WORKDIR/Qar-8a/ERR11437336.fastq.gz)

# Generate k-mer histogram
jellyfish histo \
    $WORKDIR/read_QC/kmer_counting/Qar8a_k21.jf \
    > $WORKDIR/read_QC/kmer_counting/Qar8a_k21.histo
