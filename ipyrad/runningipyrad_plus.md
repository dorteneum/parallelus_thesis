## _Running ipyrad_

For in-depth information on running _ipyrad_: https://ipyrad.readthedocs.io/en/master/
Create a new params file for ipyRAD
>`/opt/miniconda3/bin/ipyrad -n params_file_name`

Make sure you have your barcodes file with each individual and its barcode specified before you run ipyRAD. Here is an example, the first column is the individual ID and the second its corresponding barcode. The program does not expect header columns.

>RP670	AACCA
RP671	CGATC
RP593	TCGAT
RP594	TGCAT

To run ipyRAD using the command line in cruncher (not recommended):
`/opt/miniconda3/bin/ipyrad -p params-test.txt -s 1234567 -t 1 -c 20 -f`

You can always run ipyrad on the cruncher using the following path: /opt/miniconda3/bin/ipyrad .
You can also run it with a bash script as specified by the IT team with the following headers:

` #!/bin/bash -l
#SBATCH --job-name=ipyrad_drop
#SBATCH --output=ipyrad_output_%j
#SBATCH --error=ipyrad_err_%j
#SBATCH --time=100:00:00
#SBATCH --partition=fat
#SBATCH --clusters=cruncher
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=20

export PATH=/opt/miniconda3/bin/:$PATH

ipyrad -p params-test.txt -s 34567 -t 1 -c 20 -f`


Other helpful commands:

Check summary stats for all steps, specify the params file and the "-r" flag:

`$ /opt/miniconda3/bin/ipyrad -p params-l3d_all.txt -r`

#### Branching
Create new params file by keeping or removing certain individuals. First, specify the params-file from which you want to create the branch "-p params-file.txt" followed by the "-b" flag and the list of individuals you want to keep/exclude. To remove, use "-" in front of the first individual ID list.
`$ /opt/miniconda3/bin/ipyrad -p params-all.txt -b new_params_name Ind1 Ind2 Ind3`

#### Merging
Merge multiple libraries for one assembly, use the "-m" flag followed by the name of the new parameters fie to be created, and the parameter files of the demultiplexed params you want merged. This will create a new parameters file. Use that file for the rest of the assembly.
`$ /opt/miniconda3/bin/ipyrad -m all params-l3d_all.txt params-l2d_all.txt params-088.txt`


## Accessing Jupyter notebooks from the server
_ipyrad_ has many useful toolkits that run nicely on Jupyter notebooks. Here is a quick guide to get you started on running Jypter notebooks on cruncher.

Log-in to your cruncher account using your regular ssh command.

#### Setting up jupyter notebooks

If trying to run jupyter notebooks for the first time, start here; if not, jump to the next part.
Setup a password for jupyter notebook:

` $ jupyter notebook password`

Note: if you cannot call jupyter notebook, it may be that it's not available in the server, so you may have to install it in a conda environment using miniconda.

#### Start the jupyter notebook server with command line

We run the notebook server and specify --no-browser, which tells jupyter to run in the background and wait for connections.

 `$ jupyter notebook --no-browser`

#### Running jupyter on your browser

In a new terminal window, ssh into cruncher using the following specifications:

`$ ssh -N -L 5555:localhost:9000 wolfproj-19@10.153.164.249`

This forwards your previously specified port (9000) to a local port (5555).

Go to the internet browser in your computer and type on the search bar: http://localhost:5555/. You will be prompted to enter your password for jupyter notebook and then you're set!

If you have not made a setup of a port to which jupyter notebooks will connect via ssh, it will write it out in your screen. Use that port number instead when running `$ ssh -N -L 5555:localhost:PORT# wolfproj-19@10.153.164.249`

> `$ jupyter notebook --no-browser`
[I 20:03:57.115 NotebookApp] Loading IPython parallel extension
[I 20:03:57.116 NotebookApp] Serving notebooks from local directory: /data/home/wolfproj/wolfproj-19
[I 20:03:57.116 NotebookApp] Jupyter Notebook 6.2.0 is running at:
[I 20:03:57.117 NotebookApp] http://localhost:9000/
[I 20:03:57.117 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[I 20:04:55.562 NotebookApp] 302 GET / (127.0.0.1) 1.070000ms

For information on the toolkits, I recommend you visit the _ipyrad_ website directly.
