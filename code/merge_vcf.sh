#!/bin/bash

# VCF Merging Script for Mouse Strain GWAS
# Author: Gloria Wang
# Description: Merges VCF files from multiple mouse strains

# Set default parameters
VCF_DIR=${1:-"data/raw/vcf"}
OUTPUT_DIR=${2:-"data/processed"}
OUTPUT_FILE="merged.vcf.gz"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Index all VCF files
echo "Indexing VCF files..."
for file in "$VCF_DIR"/*.vcf.gz; do
    bcftools index "$file"
done

# Merge VCF files
echo "Merging VCF files..."
bcftools merge \
    -o "$OUTPUT_DIR/$OUTPUT_FILE" \
    -O z \
    "$VCF_DIR"/*.vcf.gz

# Index merged file
echo "Indexing merged VCF file..."
bcftools index "$OUTPUT_DIR/$OUTPUT_FILE"

echo "VCF merging complete. Output file: $OUTPUT_DIR/$OUTPUT_FILE"
