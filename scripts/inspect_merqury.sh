#!/bin/bash
#SBATCH --job-name=inspect_merqury
#SBATCH --output=inspect_merqury_%j.out
#SBATCH --error=inspect_merqury_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=00:05:00
#SBATCH --mem=2G

apptainer exec /containers/apptainer/merqury_1.3.sif \
  sed -n '1,100p' /usr/local/share/merqury/merqury.sh
