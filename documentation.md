# Code Documentation

## Pipeline Overview
The GWAS analysis pipeline consists of three main stages:

### 1. Variant Data Preparation
- Indexes and merges VCF files from multiple strains
- Performs initial quality control on merged variants
- Creates standardized output for downstream analysis

### 2. PLINK Processing
- Converts merged VCF data to PLINK binary format
- Applies quality control filters for variant missingness
- Prepares final dataset for association testing

### 3. Association Analysis
- Conducts GWAS using FastLMM
- Generates statistical visualizations
- Identifies significant variant associations

## Script Documentation

### merge_vcf.sh
- Purpose: Merges variant data from multiple strain VCF files
- Input: Individual strain VCF files
- Output: Single merged VCF file
- Key Parameters:
  - Input VCF directory path
  - Output file path
  - Compression level

### plink_processing.sh
- Purpose: Processes merged VCF data through PLINK
- Input: Merged VCF file
- Output: Filtered PLINK binary files
- Key Parameters:
  - Input VCF file
  - Missingness threshold
  - Output prefix

### gwas_analysis.py
- Purpose: Performs association testing and visualization
- Input: PLINK binary files and phenotype data
- Output: Association results and plots
- Key Parameters:
  - Input PLINK files
  - Phenotype file path
  - Output directory

## Output Files
- Merged variant data (VCF format)
- Quality-controlled PLINK files (.bed, .bim, .fam)
- Association results (tab-delimited)
- Statistical visualizations (PDF format)
