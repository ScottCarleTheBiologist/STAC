Hello, if you've come to this page to try to use STAC and STAC Integrate, you're in the right place. I'm the author, and I hope these tools are useful in your research. 
These scripts are referenced and explained in further detail in the publication 'STAC: a tool to leverage genetic marker data for crop research and breeding' that is currently in final production and should be released by the time you're seeing this. However, I'll explain what's going on briefly here. 
These are designed to help analyze genetic marker data in biparental populations. 
They specialize in being able to adapt to situations where there is a lot of missing data, but the more data there is, the more accurate they can be. 
To use these you need:
1) A biparental population.
2) Genetic markers (GBS, KASP, SSR, SNP-Chip, etc.) with data across your population
3) Approximate physical (basepair) positions of those markers along the genome of the organism you're working with

Notes on the biparental population: These are things that wheat breeders take for granted, but which I think I should state for those working in other organisms. Ideally the parents will each internally have limited heterozygosity, in plants, something that has gone through several generations of self-polination, Double Haploids, things like this, and ideally the parents are polymorphic from each other across many detected markers. It's designed for cases where there are 2 possible alleles parental alleles (1 from each parent), and the progeny will (in the F1, inherit 1 set from each parent, though the useful applications of this are going to be on successive generations). There may be useful applications for this in organisms that I have not considered, but it's not set up for something like Bovine breeding. If you have a case where you want to adapt this to a more complex situation, and it's important, then talk to me. I may be able to help you.

What are you getting in STAC_Integrate? 
This is a tool designed to help integrate different sets of marker data. 
There are 2 files you load in, 1 is the file of anchor-markers [something you have pretty high confidence in], and the other is your file of lower confidence markers that you're trying to integrate into it. 
I designed this to filter a bunch of putative-presence/absence markers from GBS data, and extract from the set those that appear to be real. 
There are a few statistical quality control parameters that can be adjusted. 
The default settings were decent for my testing in wheat, but fine tuning can produce optimal results for you if you understand what is going on. Please reference the paper for a more detailed explanation.
What is the main feature? It takes your low confidence markers and filters out markers that do not appear to fit into your map based on their calls and their present location, or markers that are too far away from any anchor markers to confidently assess whether their data fits or not. It then combines your filtered set of 'verified' markers (that we previously low-confidence markers), with your anchor markers, and outputs them into one .csv file that is compatible with STAC as an input file.
The outputs are: graphs that explain what happened in the process and that help you visualize the state of your markers across your organism's genome, and a .csv spreadsheet that compiled your two sets of markers into one based on the user defined quality parameters at the start of the script.

What are you getting in STAC?
This is a tool for visualizing and automaticaly calling alleles based on the marker data present across a biparental population at a given locus.
As of version 1.02, the release version of STAC requrires a single input file, and requires user defined inputs for looking at the locus of interest. Those inputs are: The Chromosome, and the Start and Stop physical positions (in basepairs) for the region of the chromosome under examination.
Additionally, the user can specify quality parameters required for automatic calling at that locus.
The outputs are a set of graphs designed to help identify the accuracy and consistency of the markers you're basing your decisions on, 
Do not try to use automated calling if the quality control plots reveal that you have notable degrees of recombination within your physical interval, or if the quality control plots reveal that some of the markers you're trying to make decisions from are erroneous or contradictory, then either narrow the interval width you're looking at until you're not observing recombintation, or prune these erroneous markers out of your dataset, and run the script again.
Errors in data happen, translocations happen, and it's important to understand the data you're making decisions based on. The purpose of this script is not to have a 1-size-fits-all single run analysis for all loci and all circumstances. In our experience imputation algorithms that do such things can lead to results where it's difficult to parse how confident one can be in the outputs. This approach engages and empowers the user to make sound decisions that the user can understand. We shouldn't be making breeding or experimental decisions without understanding why we're making them or what the data says. This tool is primarily about helping you understand your data, and then making the conclusion process easy once you are confident in the results.


These scripts work for all populations I have tested them on, but my bug testing has not been exhaustive across a huge number of datasets. 
If you encounter a bug while trying to use these scripts, please let me know.
For the sake of stability, please follow the spreadsheet formatting in the example files, and use .csv files. 
Please send any questions or helpful comments to scott.carle@wsu.edu.
If you want to use these scripts for your own purposes (academic, commercial, recreational, etc.) you are welcome to, provided that you cite the paper 'STAC: a tool to leverage genetic marker data for crop research and breeding' in all communications derived from this analysis.
Likewise, if you want to edit these scripts and use them for any purpose, you are welcome to, provided that you cite the paper.
Please don't redistribute these scripts or modified versions without making clear their source or the citation-related obligations that come with them.
These are merely tools, and neither I nor my team are responsible for what you do with them. In short, we assume no liability for any uses to which you employ them.

If you are new to R, and are struggling to get these scripts working, I have produced some tutorials for basic R skills.
I can direct you to those resources upon inquiry.
If there is interest, I can produce a video tutorial walking people through working with these scripts step by step.
Thanks for your time, and I hope these are helpful to your project.
Best regards,
Scott
