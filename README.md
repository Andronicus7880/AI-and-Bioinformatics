# AI and Bioinformatics: Microarray Data Analysis in R

Coursework scripts from **Module II: Introduction to Genomics Data Analysis** of the *AI and Omics Research Internship (2025)*. The project takes a public Affymetrix microarray dataset from raw CEL files through quality control, normalisation, filtering, probe-to-gene annotation, differential expression and visualisation.

**Dataset:** [GSE79973](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE79973), gastric adenocarcinoma vs normal gastric mucosa (Affymetrix Human Genome U133 Plus 2.0 array)

---

## Workflow

```
GEO (GSE79973)
   │
   ├─ Series matrix ──► expression, feature and phenotype data
   └─ Raw CEL files
         │
         ▼
 1. QC (raw)  ──►  RMA normalisation  ──►  QC (normalised)  ──►  low-intensity filtering
         │
         ▼
 2. Probe → gene symbol mapping  ──►  collapse duplicate probes (avereps)
         │
         ▼
 3. limma differential expression (cancer vs normal)  ──►  DEG tables (CSV)
         │
         ▼
 4. Volcano plot + heatmap (PNG)
```

## Scripts

| Script | Description |
| --- | --- |
| `01_preprocessing.R` | Downloads GEO data, runs QC with `arrayQualityMetrics`, performs RMA normalisation, filters low-intensity probes and defines sample groups |
| `02_differential_expression.R` | Maps probe IDs to gene symbols, averages duplicate probes, runs `limma`, classifies DEGs and produces plots |

> Rename the files above to match your actual script names.

### 1. Preprocessing

- Retrieves the series matrix with `GEOquery` (expression values, probe annotation, sample metadata)
- Reads raw CEL files into an `AffyBatch` object with `affy`
- Generates QC reports **before** and **after** normalisation to flag outlier arrays
- Applies **RMA** (background correction, quantile normalisation, median-polish summarisation)
- Filters probes with a median intensity below a dataset-specific threshold (3.5 in this script, chosen from the median-intensity histogram)
- Labels samples as `normal` (gastric mucosa) or `cancer` (gastric adenocarcinoma)

### 2. Differential expression and visualisation

- Maps probe IDs to gene symbols with `AnnotationDbi` and `hgu133plus2.db`
- Counts probes per gene and collapses duplicates by averaging with `limma::avereps()`
- Fits a linear model (`lmFit`) with a no-intercept design and the contrast `cancer - normal`, then applies `eBayes`
- Extracts all genes with `topTable` using Benjamini-Hochberg correction
- Classifies genes as:
  - **Upregulated:** adjusted p < 0.05 and log2FC > 1
  - **Downregulated:** adjusted p < 0.05 and log2FC < -1
  - **Not significant:** everything else
- Produces a volcano plot and a heatmap of the top DEGs

## Outputs

```
Results/
├── QC_Raw_Data/            # arrayQualityMetrics report (index.html)
├── QC_Normalized_Data/     # arrayQualityMetrics report (index.html)
├── DEGs_Results.csv        # All genes
├── Upregulated_DEGs.csv
├── Downregulated_DEGs.csv
├── Updown_DEGs.csv         # Up- and downregulated combined
├── Plot/
│   └── volcano_plot.png
└── heatmap_top_DEGs.png
```

## Requirements

- R (4.x recommended)
- **Bioconductor:** `GEOquery`, `affy`, `arrayQualityMetrics`, `limma`, `AnnotationDbi`, `hgu133plus2.db`
- **CRAN:** `dplyr`, `tibble`, `ggplot2`, `pheatmap`

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install(c("GEOquery", "affy", "arrayQualityMetrics",
                       "limma", "AnnotationDbi", "hgu133plus2.db"))
install.packages(c("dplyr", "tibble", "ggplot2", "pheatmap"))
```

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/AI-and-Bioinformatics.git
   cd AI-and-Bioinformatics
   ```
2. Download the raw CEL files for GSE79973 from NCBI GEO into `Raw_Data/` (large downloads can fail inside R, so downloading directly is more reliable).
3. Create the output folders: `Results/` and `Results/Plot/`.
4. Run the scripts in order:
   ```r
   source("01_preprocessing.R")
   source("02_differential_expression.R")
   ```

The second script expects the normalised data and phenotype data from the first. Keep them in the same R session, or save and reload them with `save()` and `load()`.

## Adapting to Your Own Dataset

- Change the GEO accession and the group labels in the phenotype step
- Install the annotation package that matches your platform (check `annotation(raw_data)`)
- Set the intensity filtering threshold from your own median-intensity histogram
- Adjust the logFC and adjusted p-value cut-offs to suit your study

## Results Summary

*Add your findings here after running the analysis, for example:*

- Arrays flagged as outliers before / after normalisation: `__ / __`
- Probes remaining after filtering: `__`
- Probes mapping to duplicate genes: `__`
- Comparison performed: cancer vs normal
- Upregulated genes: `__` · Downregulated genes: `__`

## Tools and Methods

`GEOquery` · `affy` · `arrayQualityMetrics` · `limma` · `AnnotationDbi` · `ggplot2` · `pheatmap`


## Acknowledgements

AI and Omics Research Internship (2025), Module II. Data from NCBI GEO (GSE79973).


