setwd('~/Documents/LMU-EES/Thesis/Bioinformatics/ipyrad/all_samples/')

library(ggplot2)
library(tidyr)
library(dplyr)
library(RColorBrewer)
library(scales)
library(ggpubr)

cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")


#this script plots the number of reads retained by sequenced library, location 

##samples still need to be ordered according to the population they come from, and in direction of transect. 

#load read tables 
l2d <- read.csv('l2d_demul_n_raw.csv', header = T, sep="")
l3d <- read.csv('l3d_all_demul.csv', header = T, sep="")
l4d <- read.csv('final_stats_test_L4D.csv', header = T, sep="")
#load population and pool info table
meta <- read.csv('by_pop.csv', header = T, sep ="")

#join read tables and select only columns of interest
tb <- bind_rows(l2d, l3d, l4d) %>%
  select(sample_name, reads_raw, reads_passed_filter)

#subsample columns, then substract the columns, then bind them together into tbb table
subs <- c(tb$reads_raw - tb$reads_passed_filter)
tbb <- cbind(tb, subs)

#join read data with pop and pool data into a single table
pre <- left_join(tbb, meta, by = 'sample_name')
pre$library <- as.factor(pre$library)
pre$pop <- sort(pre$pop)

#write table with all info attached, then order in text editor in transect order
write.table(pre, "pre_ordered.txt", sep="\t") 

#read table ordered by transect 
ordered <- read.table('pop_ordered.txt', header = T, sep = '\t')  
df <- as.data.frame(ordered)

# lock in factor level order for sample_name
df$sample_name <- factor(df$sample_name, levels = df$sample_name)

#plot by location
#for this plot, remove color by location, and instead indicate manually each population
loc <- ggplot(data=df, aes(x=sample_name, y=reads_passed_filter, fill=pop)) + 
  geom_col() +
  #scale_fill_manual(values=c("darkred", "azure3"), name = "",labels = c("Removed", "Retained" )) +
  scale_y_continuous(labels = comma) +
  scale_fill_brewer(palette="Paired") +
  labs(x = "", y = "Number of retained reads") +
  theme(axis.text.x = element_text(angle = 90)) 
  #theme_classic()
loc
#plot by library
cp <- as.data.frame(ordered)
cp <- cp[order(cp$library),]

cp$library <- as.factor(cp$library)

cp$sample_name <- factor(cp$sample_name, levels = cp$sample_name)

lib <- ggplot(data=cp, aes(x=sample_name, y=reads_passed_filter, fill=library)) + 
  geom_bar( stat = "identity") +
  scale_y_continuous(labels = comma) +
  scale_fill_brewer(palette="Paired") +
  labs(x = "", y = "Number of retained reads") +
  theme(axis.text.x = element_text(angle = 90)) 
#theme_classic()
lib

#plot removed and retained reads stacked
#make data into long format
long <- tidyr::gather(df, read_type, read_count, subs, reads_passed_filter, factor_key = TRUE)
long

#plot stacked bar graph of retained and removed reads -- does it make sense to make it in percentage instead?
retained <- ggplot(data=long, aes(x=sample_name, y=read_count, fill=read_type)) + 
  geom_bar(stat="identity") +
  scale_fill_manual(values=c("darkred", "azure3"), name = "",labels = c("Removed", "Retained" )) +
  scale_y_continuous(labels = comma) +
  labs(x = "", y = "Number of clusters") +
  theme(axis.text.x = element_text(angle = 90)) 
retained



#save plot
ggsave("reads-retained-location.jpeg", last_plot(), width=15, height=7.5)
ggsave("reads-retained-library.jpeg", last_plot(), width=15, height=7.5)
ggsave("reads-retained-stacked.pdf", last_plot(), width=15, height=7.5)
#ggexport(lib, filename = "reads-retained-libr.pdf")
#ggexport(loc, filename = "reads-retained-location.pdf")
ggexport(retained, filename = "reads-retained-stacked.pdf")


#calculate percentage of reads passed filter and plot 
(reads_passed_filter/reads_raw)*100
pre %>% 
  mutate(perc = (reads_passed_filter/reads_raw)*100) -> pre

#summary and the standard deviation
summary(pre$perc)
summary(pre$reads_passed_filter)

sd(pre$perc)
sd(pre$reads_passed_filter)

#ggplot(pre, aes(x = sample_name, y = perc, fill=library)) + 
#  geom_bar(stat = "identity")

