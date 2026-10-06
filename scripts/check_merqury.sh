#!/bin/bash
#SBATCH --job-name=check_merqury
#SBATCH --output=check_merqury_%j.out
#SBATCH --error=check_merqury_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=00:05:00
#SBATCH --mem=2G

apptainer exec /containers/apptainer/merqury_1.3.sif \
  head -25 /usr/local/share/merqury/merqury.sh

apptainer exec /containers/apptainer/merqury_1.3.sif \
  ls -lah /usr/local/share/merqury/
