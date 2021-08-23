## Post-assembly filtering with VCFtools


#### Filters:

_Note: the vcf file produced by ipyrad is already filtered for monomorphic data_

**Max & minimum alleles** (keep only biallelic)

`--min-alleles 2
--max-alleles 2`

**Remove indels**  _ipyrad_ already provides a vcf file without indels. This is here just for reference.

`--remove-indels`


**Remove paralogs** Loci that have high mean depth are indicative of either paralogs or multicopy loci. Thus, after plotting the raw data or the data based on a missing proportion, we can identify the threshold of mean depth coverage and filter based on that (see _raw_data_summary.R_ script). plot data and assess visually the most obvious outliers. In our case, we remove anything above 1000x because there was a big gap between from ~500x to >1000x.

` --max-meanDP <integer>`


**Exclude singletons**. First, create a file .singletons file. This file details the location of singletons and the individuals they occur in. But use this only for popstructure.

`--singletons`

Then, use the `--exclude-positions <file.singletons>` flag to remove SNPs based on the .singletons file previously created. (see also _vcftools_filtering.sh_).

**Percentage of missing data**; 1 = no missing data, 0 = allow all missing data. 0,20, + assembly %.

`--max-missing <integer>`
