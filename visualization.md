# Data Visualization Documentation

## Manhattan Plot Generation and Analysis

### Overview
The Manhattan plot serves as a crucial visualization tool in our GWAS analysis, displaying the statistical significance of genetic variants across all chromosomes. Each point represents a single nucleotide polymorphism (SNP), with its position plotted against its association significance.

### Implementation Details

The visualization pipeline processes GWAS results through several stages:

1. Data Preparation
   - Extracts chromosome numbers, positions, and p-values from association results
   - Applies -log10 transformation to p-values for better visualization
   - Organizes data by chromosomal position

2. Plot Generation
   - Creates alternating colors for adjacent chromosomes
   - Implements significance thresholds:
     - Genome-wide significance line (p < 5 × 10^-8)
     - Suggestive significance line (p < 1 × 10^-5)
   - Highlights significant SNPs above thresholds
   - Annotates key variants of interest

3. Visual Enhancements
   - Adjusts point size based on significance
   - Implements chromosome-based x-axis labels
   - Adds gridlines for better readability
   - Includes legend and significance threshold markers

### Code Implementation

```python
#!/usr/bin/env python3

"""
Manhattan Plot Generation for Mouse GWAS
Author: Gloria Wang
Description: Creates publication-quality Manhattan plots from GWAS results
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator

class ManhattanPlot:
    def __init__(self, results_file):
        """Initialize with GWAS results file"""
        self.results = pd.read_csv(results_file, sep='\t')
        self.colors = ['#2E5A87', '#4B8AC2']  # Alternating chromosome colors
        
    def prepare_data(self):
        """Prepare data for plotting"""
        # Calculate -log10(p-values)
        self.results['logp'] = -np.log10(self.results['PValue'])
        
        # Calculate cumulative position for x-axis
        self.results['pos_cum'] = self.results.groupby('Chr')['ChrPos'].transform(
            lambda x: x - x.min()
        )
        
        # Calculate chromosome midpoints for x-axis labels
        self.chr_df = self.results.groupby('Chr')['pos_cum'].agg(['max']).reset_index()
        self.chr_df['mid'] = self.chr_df['max'] / 2
        
    def create_plot(self, output_file, height=8, width=12):
        """Generate Manhattan plot"""
        plt.figure(figsize=(width, height))
        
        # Plot points for each chromosome
        for idx, chr_num in enumerate(self.results['Chr'].unique()):
            chr_data = self.results[self.results['Chr'] == chr_num]
            plt.scatter(
                chr_data['pos_cum'],
                chr_data['logp'],
                c=self.colors[idx % 2],
                s=1,
                alpha=0.7
            )
            
        # Add threshold lines
        plt.axhline(y=-np.log10(5e-8), color='red', linestyle='--', 
                   label='Genome-wide significance')
        plt.axhline(y=-np.log10(1e-5), color='blue', linestyle='--', 
                   label='Suggestive significance')
        
        # Customize plot
        plt.xlabel('Chromosome')
        plt.ylabel('-log10(p-value)')
        plt.title('Manhattan Plot: Mouse Strain GWAS Results', pad=20)
        
        # Set x-axis ticks to chromosome numbers
        plt.xticks(self.chr_df['mid'], self.chr_df['Chr'])
        
        # Add legend
        plt.legend()
        
        # Adjust layout and save
        plt.tight_layout()
        plt.savefig(output_file, dpi=300, bbox_inches='tight')
        plt.close()
        
    def highlight_significant(self, p_threshold=5e-8):
        """Highlight and annotate significant SNPs"""
        significant = self.results[self.results['PValue'] < p_threshold]
        if not significant.empty:
            plt.scatter(
                significant['pos_cum'],
                -np.log10(significant['PValue']),
                c='red',
                s=30,
                zorder=5
            )

def main():
    """Main execution function"""
    plotter = ManhattanPlot('results/association_results.txt')
    plotter.prepare_data()
    plotter.create_plot('results/plots/manhattan_plot.pdf')

if __name__ == "__main__":
    main()
```

### Interpretation Guidelines

The Manhattan plot reveals several key features:

1. Significance Patterns
   - Peaks indicate genomic regions with strong associations
   - Higher peaks suggest stronger statistical significance
   - Clustered significant SNPs may indicate important loci

2. Chromosomal Distribution
   - Variations in signal strength across chromosomes
   - Identification of chromosomal hotspots
   - Potential regulatory regions of interest

3. Quality Control
   - Overall distribution of p-values
   - Identification of potential systematic biases
   - Validation of statistical thresholds

### Visualization Best Practices

To ensure optimal visualization:

1. Resolution and Size
   - Generate high-resolution plots (minimum 300 DPI)
   - Use appropriate figure dimensions for publication
   - Maintain readability of text and data points

2. Color Scheme
   - Use colorblind-friendly palettes
   - Implement consistent chromosome coloring
   - Highlight significant findings effectively

3. Annotations
   - Label significant SNPs clearly
   - Include appropriate axis labels
   - Add comprehensive figure legends

This visualization approach provides a clear and comprehensive view of the GWAS results, enabling effective interpretation of genetic associations across the genome.
