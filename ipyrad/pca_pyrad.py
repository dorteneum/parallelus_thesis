##Do this before running the script
#activate conda environment with installed packages
conda activate thesis_setup


##here starts the actual script. commands above must be removed to be able run the python script/
#to run script: python3.7 script.py
#import packages
import ipyrad.analysis as ipa
import pandas as pd
import toyplot

#import data via file path
data = "/data/home/wolfproj/wolfproj-19/thesis/seq-data/088_outfiles/088.snps.hdf5"

#create an imap file (like a dictionary)
#group individuals into populations
imap = {
    "Aisone": ["RP669", "RP670", "RP671", "RP673"],
    "Pianche": ["RP533"],
    "Sambuco": ["RP544", "RP546", "RP547", "RP550", "RP551", "RP552"],
    "Col de Larche": ["RP573"],
    "Certamussat": ["RP590", "RP591", "RP593", "RP594", "RP595", "RP597"],
    "Condamine": ["RP627", "RP634"],
    "Barcelonnette": ["RP615"], ["RP616"], ["RP618"], ["RP620"],

}

#remove RP597 and RP544
#imap = {
#    "pianche": ["RP533"],
#    "sambuco": ["RP546", "RP547", "RP550", "RP551", "RP552"],
#    "larche": ["RP573"],
#    "certam": ["RP590", "RP591", "RP593", "RP594", "RP595"],
#    "condam": ["RP627", "RP634"],
#    "aisone": ["RP669", "RP670", "RP671", "RP673"],
#}


#creat a minmap dictionary that 50% of samples have data in each group
minmap = {i: 0.5 for i in imap}

#Enter data file and parameters for pca
# init pca object with input data and (optional) parameter options
pca = ipa.pca(
    data=data,
    imap=imap,
    minmap=minmap,
    mincov=0.75,
    impute_method="sample",
)

#run PCA analysis
pca.run ()

# store the PC axes as a dataframe
df = pd.DataFrame(pca.pcaxes[0], index=pca.names)

# write the PC axes to a CSV file
df.to_csv("pca_analysis.csv")

# show the first ten samples and the first 10 PC axes
df.iloc[:10, :10].round(2)

# plot PC axes as specified
pca.draw(0, 1);


#save image
import toyplot.pdf

# save returned plot objects as variables (pcaN, pcaM)
canvas, axes = pca.draw(0, 1)

# pass the canvas object to toyplot render function
toyplot.pdf.render(canvas, "drop_pca.pdf")
