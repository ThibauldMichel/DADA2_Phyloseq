# Phyloseq post-dada analysis

## Phyloseq tutorial:
# https://anf-metabiodiv.github.io/course-material/practicals/preprocessing_phyloseq.html

# Libraries installation if required:
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("phyloseq")

if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}

# Loading libraries:
library('phyloseq')
library('ggplot2')



# We import the ASV table, the taxonomic assignment results and the sequences from the text files we exported in the dada2 practical.
# Define where the previous practical outputs are located:
input_dir <- file.path("..", "results")

# Same thing for context file:
data_dir <- file.path("..", "data")

# Create directory for plots:
path_plots <- file.path("..", "plots")
if(!dir.exists(path_plots)) dir.create(path_plots)


#Import the ASV table:
asv_table <- read.table(file = file.path(input_dir, "asv_table.tsv"),
                        header = TRUE,
                        sep = "\t",
                        row.names = 1)

# the results of the taxonomic assignment:
taxonomy <- read.table(file = file.path(input_dir, "taxonomy.tsv"),
                        header = TRUE,
                        sep = "\t",
                        row.names = 1)


# and the ASV sequences:
asv_seq <- Biostrings::readDNAStringSet(
  filepath = file.path(input_dir, "asv.fasta"),
  format = "fasta"
)



# 2 context files to input:

# We will also need some information about the samples, the file is located is another folder.
# First one:
#context <- read.csv(file.path(data_dir, "Seq_Tables_from_dada2_TM_13.3.2024.csv"))  
#rownames(context) <- context$ID
# With this, 13 samples

# Second one:
context <- read.csv(file.path(data_dir, "ACA17_samples_sites.csv"))  
rownames(context) <- context$ACA_ID
# 96 sAMPLES



## Get a phyloseq object

### Check sample file
# Make sure sample names in the ASV table…
colnames(asv_table) |> sort()


# match sample table ids.
row.names(context) |> sort()


# You can do it in a more formal way using the function setdiff(). This function returns the elements of x not present in y.
setdiff(x = colnames(asv_table),
        y = row.names(context))

character(0)

# Perfect! The ASV table sample names match with the contextual data table.
## Assemble ASV table, taxonomy and contextual data

# Use the phyloseq::phyloseq() function to create a phyloseq object. 
# A phyloseq object is usualy composed by an ASV table, a taxonomy table and a table describing the samples. 
# You can also add ASV sequences and a phylogenetic tree

physeq <- phyloseq::phyloseq(
  phyloseq::otu_table(asv_table, taxa_are_rows = TRUE),
  phyloseq::tax_table(as.matrix(taxonomy)),
  phyloseq::sample_data(context),
  phyloseq::refseq(asv_seq)
)



### Replace the ID of the samples by their description
# Get the sample data
#sample_data <- phyloseq::sample_data(physeq)

# Get the OTU table
#otu_table <- phyloseq::otu_table(physeq)

# Extract the "Description" column from sample data
#descriptions <- sample_data$Description

# Rename the column names of the OTU table
#colnames(otu_table) <- descriptions

# Assign the modified OTU table back to the phyloseq object
#physeq@otu_table <- otu_table


### Make the barplot
barplot(physeq@otu_table)

heatmap(physeq@otu_table, 
        col = terrain.colors(100),  # Specify the color palette
        scale = "row",  # Scale the rows
        Rowv = NA,  # Disable row clustering
        Colv = NA,  # Disable column clustering
        main = "Heatmap of OTU Counts")  # Add a title


# Make plot on the taxonomic distribution of the top 20 samples.
theme_set(theme_bw())
ps <- physeq
OTU <- otu_table

# General top 20 ASVs abundance across sample batch:
top20 <- names(sort(taxa_sums(ps), decreasing=TRUE))[1:20]
ps.top20 <- transform_sample_counts(ps, function(OTU) OTU/sum(OTU))
ps.top20 <- prune_taxa(top20, ps.top20)
phyloseq::plot_bar(ps.top20, x="ACA_ID", fill="Genus", title="Top 20 ASVs abundance") +
  theme(axis.title.x=element_blank())
ggsave(path = path_plots, filename="plot_abundance_top20.png")

# Top 20 ASVs abundance for each sampling location:
# Column “MS-CD” = ACA site code (numerical)
phyloseq::plot_bar(ps.top20, x="MS_CD", fill="Genus", title="Top 20 ASVs abundance per location") +
  theme(axis.title.x=element_blank())
ggsave(path = path_plots, filename="plot_abundance_top20_per_location.png")


# General abundance for all ASVs
phyloseq::plot_bar(physeq, x="ACA_ID", fill="Genus", title="All ASVs Genus abundance ") +
  theme(axis.title.x=element_blank())
ggsave(path = path_plots, filename="plot_abundance.png")


