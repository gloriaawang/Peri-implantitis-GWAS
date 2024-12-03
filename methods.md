# Methods Documentation

## Data Processing and Analysis Pipeline

### Variant Data Preparation
The pipeline begins with raw VCF files containing SNP data from multiple mouse strains. These files undergo several preprocessing steps:

1. VCF Indexing
   - Each strain's VCF file is indexed using bcftools
   - Enables efficient access and merging operations
   - Validates file integrity

2. Variant Merging
   - bcftools merge combines variants across all strains
   - Maintains variant quality scores and genotype information
   - Creates a unified set of variants for analysis

### Quality Control
Quality control measures are applied at multiple stages:

1. Initial VCF Processing
   - Variant position validation
   - Reference allele consistency checks
   - Basic quality filtering

2. PLINK-based Filtering
   - Missingness threshold of 10%
   - Removes low-quality variants
   - Ensures data completeness for association testing

### Association Analysis
The GWAS analysis employs FastLMM for association testing:

1. Data Preparation
   - Conversion to PLINK binary format
   - Phenotype data integration
   - Sample relationship matrix calculation

2. Statistical Testing
   - Single SNP association testing
   - Correction for population structure
   - Multiple testing adjustment

3. Results Visualization
   - Manhattan plots for genome-wide significance
   - Q-Q plots for test statistic distribution
   - Regional association plots for significant loci

### Statistical Considerations
- Linear mixed model implementation
- Genomic control for population stratification
- False discovery rate control
- Effect size estimation

## Data Sources
- UCLA Sanger Lab SNP data
- Phenotype data from experimental measurements
- Reference genome: GRCm38/mm10

## Quality Metrics
- Variant call quality scores
- Genotyping rate requirements
- Association test statistics
- Multiple testing thresholds
