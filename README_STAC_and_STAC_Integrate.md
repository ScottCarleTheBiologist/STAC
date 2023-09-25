Hello, if you've come to this page to try to use STAC and STAC Integrate, you're in the right place.
I'm the author, and I hope these tools are useful in your research.
These scripts are referenced and explained in further detail in the publication 'STAC: a tool to leverage genetic marker data for crop research and breeding' that is currently in final production and should be released by the time you're seeing this.
However, I'll explain what's going on briefly here.
These are designed to help analyze genetic marker data in biparental populations. They specialize in being able to adapt to situations where there is a lot of missing data, but the more data there is, the more accurate they can be.
To use these you need: 
1) A biparental population. 
2) Genetic markers (GBS, KASP, SSR, SNP-Chip, etc.) with data across your population
3) Approximate physical (basepair) positions of those markers along the genome of the organism you're working with

Notes on the biparental population: These are things that wheat breeders take for granted, but which I think I should state for those working in other organisms. Ideally the parents will each internally have limited heterozygosity, in plants, something that has gone through several generations of self-polination, Double Haploids, things like this, and ideally the parents are polymorphic from each other across many detected markers. It's designed for cases where there are 2 possible alleles parental alleles (1 from each parent), and the progeny will (in the F1, inherit 1 set from each parent, though the useful applications of this are going to be on successive generations). There may be useful applications for this in organisms that I have not considered, but it's not set up for something like Bovine breeding. If you have a case where you want to adapt this to a more complex situation, and it's important, then talk to me. I may be able to help you.

What are you getting in STAC_Integrate?
This is a tool designed to help integrate different sets of marker data.
There are 2 files you load in, 1 is the file of anchor-markers [something you have pretty high confidence in], and the other is your file of lower confidence markers that you're trying to integrate into it.
I designed this to filter a bunch of putative-presence/absence markers from GBS data, and extract from the set those that appear to be real. 
There are a few statistical quality control parameters that can be adjusted. The default settings were decent for my testing in wheat, but fine tuning can produce optimal results for you if you understand what is going on. I'll explain those parameters briefly here.


These scripts do work, but my bug testing has not been exhaustive across a huge number of datasets. If you 
For the sake of stability, please follow the example file formats.
Please send any questions and helpful comments to scott.carle@wsu.edu.

