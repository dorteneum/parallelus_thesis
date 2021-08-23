##For the thesis, we only used heterozygosity and Fst values from this script. Tajima's D, pi and theta values in the thesis were calculated using DnaSP v.6 (Rozas et al., 2017).

#install.packages('dartR')
#gl.install.vanilla.dartR()
#install.packages("pegas")

setwd('~/Documents/LMU-EES/Thesis/Bioinformatics/nuc_diversity/')
#install.packages("PopGenome")
library(PopGenome)
library(dartR)
library(vcfR)
library(adegenet)
library(pegas)

##create genome.class object for PopGenome
#specify the folder where your vcf file is, not the vcf file itself
GENOME.class <- readData('nfilt_0', format="VCF", SNP.DATA = TRUE, FAST = F, include.unknown=TRUE)
GENOME.class
detail.stats(GENOME.class)


#Create DNAbin objects for pegas
data <- read.vcfR("nfilt_0/nfilt0_usnp.recode.vcf")
DNAbin <- vcfR2DNAbin(data)
genlight <- vcfR2genlight(data)


#francevcf <- read.vcfR("filt_france_0.recode.vcf")
#francebin <- vcfR2DNAbin(francevcf)

## Assign individuals to populations based on finRADstr clusters (i.e. sampling localities).
#THIS OR
barc <- as.character(read.table("pops/barce.txt")[[1]]) 
cond <- as.character(read.table("pops/conda.txt")[[1]]) 
certa <- as.character(read.table("pops/certa.txt")[[1]]) 
col <- as.character(read.table("pops/col.txt")[[1]]) 
pont <- as.character(read.table("pops/ponte.txt")[[1]]) 
samb <- as.character(read.table("pops/samb.txt")[[1]]) 
pian <- as.character(read.table("pops/pian.txt")[[1]]) 
aiso <- as.character(read.table("pops/aiso.txt")[[1]]) 

#also checked by assigning pops based onsides of transect
france <- as.character(read.table("pops/french_indv.txt")[[1]])
italy <- as.character(read.table("pops/italy_indv.txt")[[1]])

#set pops to sampled localities
GENOME.class<- set.populations(GENOME.class,list(barc, cond, certa, col, pont, samb, pian, aiso),diploid=TRUE) 
# CHECK
GENOME.class@populations

#you have to jump back and forth; so reassigning pops based on what you want to calculate
#set pops to two main sides of HZ.
GENOME.class<- set.populations(GENOME.class,list(france, italy),diploid=TRUE) 
# CHECK
GENOME.class@populations


## OR THAT
# Define populations with lists
#GENOME.class <- set.populations(GENOME.class,list(
#  c("CON","KAS-1","RUB-1","PER-1","RI-0","MR-0","TUL-0"),
#  c("MH-0","YO-0","ITA-0","CVI-0","COL-2","LA-0","NC-1") )) 
# Check whether grouping is set correctly 
#GENOME.class@region.data@populations
#GENOME.class@region.data@populations2 
#GENOME.class@region.data@outgroup


#CALCULATE STATS
# Neutrality statistics
GENOME.class <-neutrality.stats(GENOME.class, detail=TRUE) 
GENOME.class@Tajima.D 
# Each population 
get.neutrality(GENOME.class)[[1]] 
get.neutrality(GENOME.class)[[2]] 

GENOME.class@Fu.F_S
#get the different stats that were calculated
GENOME.class@Tajima.D 
GENOME.class@theta_Tajima
GENOME.class@theta_Watterson
GENOME.class@n.segregating.sites


# Diversity stats
GENOME.class <- diversity.stats(GENOME.class)
GENOME.class <- diversity.stats.between(GENOME.class)

#Fst stats
GENOME.class <- F_ST.stats(GENOME.class,mode="nucleotide")
get.F_ST(GENOME.class)[[1]]
GENOME.class@nucleotide.F_ST
pairwise.FST <- t(GENOME.class@nuc.F_ST.pairwise)
head(pairwise.FST)
GENOME.class@nuc.diversity.within 

#get diversity for each population
get.diversity(GENOME.class)[[1]] 
get.diversity(GENOME.class)[[2]] 


#get the different stats that were calculated
GENOME.class@nuc.diversity.within 
GENOME.class@nuc.diversity.between
GENOME.class@Pi

#calculate the number of fixed and share polymorphisms
GENOME.class <- calc.fixed.shared(GENOME.class)
#get the different stats that were calculated
GENOME.class@n.monomorphic.sites[[1]]
GENOME.class@n.shared.sites
GENOME.class@n.fixed.sites




#calculate expected (He) and observed (Ho) heterozygosity using dartR package
#specify ploidy = 2 for data in genlight
ploidy(genlight) <- 2

#read strata file and convert it to a data frame
strata <- read.table("nstrata.tsv", sep = "", header = TRUE)
strata <- as.data.frame(strata)
head(strata)

#assign populations to individuals
pop(genlight) <- strata$CLUSTER

#do some readjusments to genlight so it's ready to run with dartR (not all features on dartR will work because our data file was not created with dartR or has the same info)
gl <- gl.compliance.check(genlight)
gl <- gl.recalc.metrics(gl)


#check metric flags
gl@other$loc.metrics.flags

#calculate He & Ho at pop level
het <- gl.report.heterozygosity(gl, plot=F, verbose =3)


#check for monomorphs
#gl.filter.monomorphs(gl)

