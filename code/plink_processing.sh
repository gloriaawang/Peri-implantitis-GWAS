#!/bin/bash

# PLINK Processing Script for Mouse Strain GWAS
# Author: Gloria Wang
# Description: Processes merged VCF data through PLINK

# Set default parameters
INPUT_VCF=${1:-"data/processed/merged.vcf.gz"}
OUTPUT_PREFIX=${2:-"data/processed/plink/filtered_snps"}
GENO_THRESHOLD=0.1

# Create output directory
mkdir -p "$(dirname "$OUTPUT_PREFIX")"

# Convert VCF to PLINK binary format
echo "Converting VCF to PLINK format..."
plink --vcf "$INPUT_VCF" \
      --make-bed \
      --out "${OUTPUT_PREFIX}_initial"

# Apply quality filters
echo "Applying quality filters..."
plink --bfile "${OUTPUT_PREFIX}_initial" \
      --geno "$GENO_THRESHOLD" \
      --make-bed \
      --out "$OUTPUT_PREFIX"

# Clean up intermediate files
rm "${OUTPUT_PREFIX}_initial"*

echo "PLINK processing complete. Output files: ${OUTPUT_PREFIX}.[bed/bim/fam]"
