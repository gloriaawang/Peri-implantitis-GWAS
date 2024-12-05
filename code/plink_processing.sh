# Purpose: Processes merged VCF data through PLINK

INPUT_VCF=${1:-"data/processed/merged.vcf.gz"}
OUTPUT_PREFIX=${2:-"data/processed/plink/filtered_snps"}
GENO_THRESHOLD=0.1
mkdir -p "$(dirname "$OUTPUT_PREFIX")"

plink --vcf "$INPUT_VCF" \
      --make-bed \
      --out "${OUTPUT_PREFIX}_initial"


plink --bfile "${OUTPUT_PREFIX}_initial" \
      --geno "$GENO_THRESHOLD" \
      --make-bed \
      --out "$OUTPUT_PREFIX"

rm "${OUTPUT_PREFIX}_initial"*
