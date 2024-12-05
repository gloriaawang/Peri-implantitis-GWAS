# Pyrpose: Merges VCF files from multiple mouse strains

VCF_DIR=${1:-"data/raw/vcf"}
OUTPUT_DIR=${2:-"data/processed"}
OUTPUT_FILE="merged.vcf.gz"
mkdir -p "$OUTPUT_DIR"


for file in "$VCF_DIR"/*.vcf.gz; do
    bcftools index "$file"
done

bcftools merge \
    -o "$OUTPUT_DIR/$OUTPUT_FILE" \
    -O z \
    "$VCF_DIR"/*.vcf.gz

bcftools index "$OUTPUT_DIR/$OUTPUT_FILE"
