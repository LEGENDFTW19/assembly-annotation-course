#!/bin/bash

#SBATCH --job-name=merqury_Qar8a
#SBATCH --output=merqury_Qar8a_%j.out
#SBATCH --error=merqury_Qar8a_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16

WORKDIR=/data/users/tsingh/assembly_annotation_course

mkdir -p $WORKDIR/assemblies/merqury

# Create the read k-mer database
apptainer exec \
    --bind /data:/data \
    /containers/apptainer/merqury_1.3.sif \
    meryl count k=21 \
    output $WORKDIR/assemblies/merqury/Qar8a_reads.meryl \
    $WORKDIR/Qar-8a/ERR11437336.fastq.gz

# Run Merqury for each assembly
for ASM in flye hifiasm lja
do
    if [ "$ASM" = "flye" ]; then
        FASTA=$WORKDIR/assemblies/flye/assembly.fasta
    elif [ "$ASM" = "hifiasm" ]; then
        FASTA=$WORKDIR/assemblies/hifiasm/Qar8a.bp.p_ctg.fa
    elif [ "$ASM" = "lja" ]; then
        FASTA=$WORKDIR/assemblies/lja/assembly.fasta
    fi

    apptainer exec \
        --bind /data:/data \
        /containers/apptainer/merqury_1.3.sif \
        bash /usr/local/share/merqury/merqury.sh \
        $WORKDIR/assemblies/merqury/Qar8a_reads.meryl \
        $FASTA \
        $WORKDIR/assemblies/merqury/${ASM}
done
