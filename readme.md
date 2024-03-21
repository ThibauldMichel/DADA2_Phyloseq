# DADA2 and Phyloseq pipelines

## Description
This pipeline has been written from the DADA2 script developped by Francois Keck (https://github.com/fkeck/DADA2_diatoms_pipeline) and the 
It uses the reference database manager for R (https://github.com/fkeck/refdb). Elements of the pipeline can be found in the official DADA2 documentation and official tutorial (https://benjjneb.github.io/dada2/index.html). 

## Directories
The Dada2 and Phyloseq scripts are located in the "scripts" directory, and paths are set up to run them from this location.
The pipeline will create a "results" and a "plots" directories to store the output of the pipeline.

## Dependancies
The scripts will install R dependancies needed by the pipeline. However, a recent version of **cutadapt** is needed. Check the cutadapt website for installation instructions (https://cutadapt.readthedocs.io/en/stable/installation.html). 

## Primers removal
The Dada2 script incorporate a primer removal step from the official DADA2 ITS Pipeline Workflow (https://benjjneb.github.io/dada2/ITS_workflow.html). 
The base set of primers used in the script are 