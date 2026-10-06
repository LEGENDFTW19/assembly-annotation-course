#!/bin/bash
#SBATCH --job-name=check_merqury_util
#SBATCH --output=check_merqury_util_%j.out
#SBATCH --error=check_merqury_util_%j.err
#SBATCH --partition=pibu_el8
#SBATCH --time=00:05:00
#SBATCH --mem=2G

apptainer exec /containers/apptainer/merqury_1.3.sif \
  ls -l /usr/local/share/merqury/util/util.sh
