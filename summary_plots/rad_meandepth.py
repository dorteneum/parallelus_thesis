#This script extracts for every RAD type the positions with the highest, lowest mean depth

import pandas as pd

file_name = '/Users/dorteneum/Documents/LMU-EES/Thesis/Bioinformatics/ipyrad/all_samples/results_all_vcf/results_all.ldepth.mean'

df = pd.read_csv(file_name, delimiter = "\t")

mean_depth_max = df.loc[df.groupby('CHROM')['MEAN_DEPTH'].idxmax()]
mean_depth_min = df.loc[df.groupby('CHROM')['MEAN_DEPTH'].idxmin()]

mean_depth_max.to_csv('results_all_ldepth_max.txt', index=False)
mean_depth_min.to_csv('results_all_ldepth_min.txt', index=False)
