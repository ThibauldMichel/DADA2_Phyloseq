# DADA2 and Phyloseq pipelines

## Description
This pipeline has been written from the DADA2 script developped by [Francois Keck](https://github.com/fkeck/DADA2_diatoms_pipeline) and the files conversion for Phyloseq of the [ANF MetaBioDiv workshop](https://anf-metabiodiv.github.io/course-material/practicals/preprocessing_phyloseq.html).

It uses the [reference database manager for R](https://github.com/fkeck/refdb) to access the rbcL 312 database for DADA2, so no local database is needed. 

Other elements have been written from the official DADA2 documentation and [official tutorial](https://benjjneb.github.io/dada2/index.html). 

## Directories
The Dada2 and Phyloseq scripts are located in the ```scripts``` directory, and paths are set up to run them from this location. The raw sequencing reads should be stored in the ```data``` directory which should be imported with the ```scripts``` directories.
The pipeline will create a ```results``` and a ```plots``` directories to store the outputs.

## How to run the pipeline?

### 1. Download the scripts
The directories of the pipeline can be downloaded at the location of your choice using the **<> Code** button above, or on BASH using the command:

```git clone git@github.com:ThibauldMichel/DADA2_Phyloseq.git```

### 2. Install dependancies
The scripts will install R dependancies needed by the pipeline. However, a recent version of **cutadapt** is needed. Check the cutadapt website for [installation instructions](https://cutadapt.readthedocs.io/en/stable/installation.html). 

In a Windows operating system environment, the path to the cutadapt executable should be provided between double quotes line 55 of the ```scripts/DADA2.R``` file as follow:

```cutadapt <- "C:/path/to/cutadapt/executable" ```

In a UNIX-based environment (Mac OS or Linux) the path of cutadapt should be provided as well. 

```cutadapt <- "/path/to/cutadapt/executable" ```

Alternatively, you may choose to put Cutadapt in the $PATH. To do this, open the file ```



```export PATH=$PATH:/dir_containing_cutadapt```

Then the script should run without modifications with line 55 unchanged as follow:

```cutadapt <- "cutadapt"```


### 3. Set up primers removal
The Dada2 script incorporate a primer removal step from the [official DADA2 ITS Pipeline Workflow](https://benjjneb.github.io/dada2/ITS_workflow.html). 

The base set of primers used in the pipeline are designed to target a 312bp barcode located on a rbcL plastid gene described by from [Vasselon et al. 2017](https://www.sciencedirect.com/science/article/pii/S1470160X17303497?via%3Dihub).

If you are using another set of primers, replace the sequence forward (FWD) and reverse (REV) in the ```scripts/DADA2.R``` script lines 36 and 40.