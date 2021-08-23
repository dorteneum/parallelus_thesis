
## Converting alleles file into finerad information

To use fineRADstructure, one can use the script from Edgardo Ortiz, found here:
https://github.com/edgardomortiz/fineRADstructure-tools

Indicate the input file, the minimum number of samples a loci must be present to be included(i.e. % missing data but expressed with number of individuals), and origin of your data (it would also run without it).

`$ python finerad_input.py --input no-out.alleles --minsample 46 --type ipyrad`
