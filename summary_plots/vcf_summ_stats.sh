!/bin/bash
##script to get raw data info taken from O'Leary.

module load vcftools

# 20 percent missing data
# depth indv/locus
vcftools --vcf all_outfiles/all.vcf --out results_all --depth
vcftools --vcf all_outfiles/all.vcf --out results_all --site-mean-depth
vcftools --vcf all_outfiles/all.vcf --out results_all --geno-depth

# missing data indv/locus
vcftools --vcf all_outfiles/all.vcf --out results_all --missing-indv
vcftools --vcf all_outfiles/all.vcf --out results_all --missing-site

# allele freq/indv freq buden
vcftools --vcf all_outfiles/all.vcf --out results_all --indv-freq-burden
vcftools --vcf all_outfiles/all.vcf --out results_all --freq2
vcftools --vcf all_outfiles/all.vcf --out results_all --singletons
vcftools --vcf all_outfiles/all.vcf --out results_all --012

# heterozygosity per individual
vcftools --vcf all_outfiles/all.vcf --out results_all --het

# SNP call quality
vcftools --vcf all_outfiles/all.vcf --out results_all --site-quality


## 0 percent missing data
# depth indv/locus
vcftools --vcf 0missing.recode.vcf --out results_0/0 --depth
vcftools --vcf 0missing.recode.vcf --out results_0/0 --site-mean-depth
vcftools --vcf 0missing.recode.vcf --out results_0/0 --geno-depth

# missing data indv/locus
vcftools --vcf 0missing.recode.vcf --out results_0/0 --missing-indv
vcftools --vcf 0missing.recode.vcf --out results_0/0 --missing-site

# allele freq/indv freq buden
vcftools --vcf 0missing.recode.vcf --out results_0/0 --indv-freq-burden
vcftools --vcf 0missing.recode.vcf --out results_0/0 --freq2
vcftools --vcf 0missing.recode.vcf --out results_0/0 --singletons
vcftools --vcf 0missing.recode.vcf --out results_0/ --012

# heterozygosity per individual
vcftools --vcf 0missing.recode.vcf --out results_0/0 --het

# SNP call quality
vcftools --vcf 0missing.recode.vcf --out results_0/0 --site-quality


module unload vcftools
