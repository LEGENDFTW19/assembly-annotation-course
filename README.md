# Genome and Transcriptome Assembly – Arabidopsis thaliana

## 1. Project Overview

In this project, we worked with sequencing data from an Arabidopsis thaliana accession, Qar-8a.

The main goal was to generate and compare genome assemblies and to assemble RNA-seq reads into transcripts that could later be used for genome annotation.

## 2. Data

- Organism: Arabidopsis thaliana
- Accession: Qar-8a
- PacBio HiFi reads: ERR11437336.fastq.gz
- Illumina RNA-seq reads:
  - ERR754081_1.fastq.gz
  - ERR754081_2.fastq.gz

## 3. Workflow

1. Raw data quality control
   - FastQC
   - MultiQC
   - fastp

2. Genome size estimation
   - Jellyfish
   - GenomeScope

3. Genome assembly
   - Flye
   - hifiasm
   - LJA

4. Assembly evaluation
   - QUAST
   - BUSCO
   - Merqury
   - MUMmer

5. Transcriptome assembly
   - Trinity

## 4. Read Quality Control

- PacBio reads:
  - 299,795 reads
  - 4.80 Gb total bases
  - Q20: 98.87%
  - Q30: 97.41%

- RNA-seq reads:
  - 22.62 million reads per file
  - Read length: 101 bp
  - GC content: approximately 46%

- After fastp:
  - 45.24 million reads before filtering
  - 40.70 million reads after filtering

## 5. Genome Size Estimation

- K-mer size: 21
- Estimated genome size: approximately 153 Mb
- Estimated unique sequence: approximately 105 Mb
- Estimated repetitive sequence: approximately 48 Mb
- Estimated heterozygosity: approximately 0.107%

## 6. Genome Assembly

Three genome assemblies were generated from the PacBio HiFi reads.

- Flye
  - Assembly size: 134.81 Mb
  - N50: 6.98 Mb
  - Largest contig: 11.68 Mb

- hifiasm
  - Assembly size: 152.42 Mb
  - N50: 9.63 Mb
  - Largest contig: 22.60 Mb

- LJA
  - Assembly size: 142.82 Mb
  - N50: 12.40 Mb
  - Largest contig: 22.60 Mb

## 7. Assembly Evaluation

### 7.1 QUAST

QUAST was used to compare the basic assembly statistics and contiguity of the three assemblies.

LJA produced the highest N50, while hifiasm produced the largest total assembly size.

### 7.2 BUSCO

BUSCO was used to check the completeness of conserved genes.

- Flye: 99.9% complete
- hifiasm: 98.1% complete
- LJA: 99.9% complete

LJA and Flye showed the highest BUSCO completeness.

### 7.3 Merqury

Merqury was used to evaluate the assemblies using k-mers from the sequencing reads.

### 7.4 MUMmer

MUMmer was used to compare the assemblies and inspect their sequence-level similarities using dotplots.

## 8. Transcriptome Assembly

The Illumina RNA-seq reads were assembled using Trinity.

The Trinity assembly contained:

- 44,098 transcripts
- 59.02 Mb total assembled sequence
- N50: 1,885 bp
- Longest transcript: 11,087 bp

The assembled transcripts can be used as transcript evidence for downstream genome annotation.

## 9. Software

- FastQC
- MultiQC
- fastp
- Jellyfish
- GenomeScope
- Flye
- hifiasm
- LJA
- QUAST
- BUSCO
- Merqury
- MUMmer
- Trinity

The analyses were performed on the University of Bern IBU cluster using SLURM and Apptainer where required.

## 10. Conclusion

The three assemblers produced assemblies with high gene completeness.

LJA gave the highest N50 while maintaining very high BUSCO completeness. Flye also showed very high BUSCO completeness, while hifiasm produced the largest assembly.

The Trinity assembly provided transcript sequences that can be used together with the genome assembly for downstream annotation.
