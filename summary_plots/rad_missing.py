#This script extracts for every RAD type the positions with the highest, lowest mean depth

import pandas as pd

file_name = '/Users/dorteneum/Documents/LMU-EES/Thesis/Bioinformatics/ipyrad/all_samples/results_all_vcf/results_all.lmiss'

df = pd.read_csv(file_name, delimiter = "\t")

mean_depth_max = df.loc[df.groupby('CHR')['F_MISS'].idxmax()]
mean_depth_min = df.loc[df.groupby('CHR')['F_MISS'].idxmin()]

mean_depth_max.to_csv('results_all_vcf_lmiss_single.txt', index=False)
