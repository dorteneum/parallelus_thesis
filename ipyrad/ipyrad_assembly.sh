#!/bin/bash -l
#SBATCH --job-name=ipyrad_s1234567
#SBATCH --output=ipyrad_output_it_test
#SBATCH --error=ipyrad_err_it_test
#SBATCH --time=100:00:00
#SBATCH --partition=fat
#SBATCH --clusters=cruncher
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --exclusive
#SBATCH --mail-user=d.neumeister@campus.lmu.de
#SBATCH --mail-type=END


export PATH=/opt/miniconda3/bin/:$PATH

#change directory
cd /data/home/wolfproj/wolfproj-19/thesis/seq-data

#run pyrad command
ipyrad -p params-test.txt -s 1234567 -t 1 -c 20 -f
