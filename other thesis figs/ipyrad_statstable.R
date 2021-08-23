setwd('~/Documents/LMU-EES/Thesis/Bioinformatics/ipyrad/')


library(ggplot2)
library(tidyr)
library(dplyr)
library(RColorBrewer)
library(scales)
library(forcats)

#table with population IDs attached to individuals, to obtain the table, join two tables of 
#sample_name & individuals with loci per sample file. Then export table, open in excel
#and add an "order" column (or maybe not) and then import it again 

#export table 
#write.csv(data, "loci_n_pop.csv")


##data import
#import final table with populations arranged by France-Italy order
data <- read.csv("loci_n_pop.csv", header = T, sep = ",")
data <- as.data.frame(data)
# make sample_name an ordered factor so it plots it in the order given! (YAY!)
data$sample_name <- factor(data$sample_name, levels = data$sample_name)


#loci for N data
Ntaxa <- read.table("loci_N_data.txt", header = T, sep = "")

##Plotss
#color blind palette
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

### The number of loci recovered for each Sample.
p1 <- ggplot(data, aes(x=sample_name, y=sample_coverage, fill = pop)) + 
    geom_bar(stat="identity", width = 0.75) +
    scale_fill_manual(color = "black", values=cbPalette, name = "Population") + #c("Barcelonette", "Condamine", "Certamussat", "Col de Larche", "Sambuco", "Pianche", "Aisone")) +
    scale_y_continuous(labels = comma, limits = c(0,15000)) +
    labs(x = "Individual", y = "Number of loci") +
    theme_classic()


### The number of loci for which N taxa have data.
p2 <- ggplot(Ntaxa, aes(x= no_locus, y= locus_coverage)) +
  geom_bar(stat="identity", width = 0.75, color = "black", fill = "#E69F00") +
  labs(x= " Number of individuals", y = "Number of loci") +
  scale_y_continuous(breaks = seq(0, 9000, by=500)) +
  theme_classic()
p2

#arrange plots
figure <- ggarrange(p1, 
                    p2,
                    
                       nrows = 3,
                       labels = c("a", "b", "c", "d", "e"))
#export 
ggexport(p2, filename = "ipyrad_summ_loci.pdf")
ggexport(p1, filename = "ipyrad_Ntaxa.pdf")

# Reorder following the value of another column:
#data %>%
#  mutate(name = fct_reorder(sample_name, pop)) %>%
#  ggplot(aes(x=sample_name, y=sample_coverage, fill = pop)) + 
#  geom_bar(stat="identity", width = 0.75) +
#  scale_fill_manual(values=cbPalette, name = "Population", c("Barcelonette", "Condamine", "Certamussat", "Col de Larche", "Sambuco", "Pianche", "Aisone")) +
#  scale_y_continuous(labels = comma, limits = c(0,15000)) +
#  labs(x = "Individual", y = "Number of loci") +
#  theme_classic()


