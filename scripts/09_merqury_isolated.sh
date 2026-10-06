#!/bin/bash
#SBATCH --job-name=merqury_Qar8a
#SBATCH --output=merqury_isolated_%j.out
#SBATCH --error=merqury_isolated_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16

WORKDIR=/data/users/tsingh/assembly_annotation_course
MERQURY=/usr/local/share/merqury
OUTDIR=$WORKDIR/assemblies/merqury_isolated
READS_MERYL=$OUTDIR/Qar8a_reads.meryl

mkdir -p "$OUTDIR"
cd "$OUTDIR" || exit 1

# Build the read k-mer database once
if [ ! -d "$READS_MERYL" ]; then
    apptainer exec --bind /data:/data \
      /containers/apptainer/merqury_1.3.sif \
      meryl count k=21 output "$READS_MERYL" \
      "$WORKDIR/Qar-8a/ERR11437336.fastq.gz" || exit 1
fi

# Run each assembly in its own directory
for ASM in flye hifiasm lja; do
    case "$ASM" in
        flye) FASTA=$WORKDIR/assemblies/flye/assembly.fasta ;;
        hifiasm) FASTA=$WORKDIR/assemblies/hifiasm/Qar8a.bp.p_ctg.fa ;;
        lja) FASTA=$WORKDIR/assemblies/lja/assembly.fasta ;;
    esac

    ASM_DIR=$OUTDIR/$ASM
    mkdir -p "$ASM_DIR"
    cd "$ASM_DIR" || exit 1

    apptainer exec --bind /data:/data \
      --env MERQURY="$MERQURY" \
      /containers/apptainer/merqury_1.3.sif \
      bash "$MERQURY/merqury.sh" \
      "$READS_MERYL" "$FASTA" "$ASM" || exit 1

    cd "$OUTDIR" || exit 1
done
