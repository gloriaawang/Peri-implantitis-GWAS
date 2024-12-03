# Peri-implantitis Genome-Wide Association Study
NSF-funded REU @ UCLA Pirih Lab, Summer '24

A computational pipeline for conducting GWAS on mouse strain genetic variants, specifically to peri-implantitis susceptibility analysis.

## Project Overview
This pipeline systematically analyzes genetic variants across multiple mouse strains to identify genomic regions associated with peri-implantitis susceptibility. The analysis integrates variant calling, quality control, and association testing to generate robust statistical insights into genetic factors influencing disease susceptibility.

## Requirements

### Software Dependencies
- bcftools (v1.20 or later)
- vcftools (v0.1.16 or later)
- PLINK (v1.90b or later)
- Python 3.7+
  - numpy
  - pandas
  - fastlmm
  - matplotlib
  - scipy

### Input Data Requirements
The pipeline expects input data in the following formats:
- VCF files containing SNP data for each strain (*.mgp.v5.snps.dbSNP142.vcf.gz format)
- Phenotype data formatted according to PLINK specifications
- Sample metadata including strain identifiers and relevant phenotypic information

### System Requirements
- Memory: Minimum 16GB RAM recommended
- Storage: Sufficient space for raw VCF files and intermediate processing files
- Operating System: Linux or macOS
