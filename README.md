# leadingEdge
extract leading edge genes from broad GSEA 

Use output from various GSEA pipelines from the broad (http://genepattern.broadinstitute.org/gp/pages/index.jsf)
to extract the leading edge genes. The script is structured so that GSEA output directories are in the same parent 
directory as well as an RNA-seq master table. For each day, the script extracts the leading edge genes from those genes
that are signficantly enriched UP and DN and then pulls the expression values for those genes across all days. 
