#STAC [Sparse Tag Allele Caller]
#Version 1.02
#Created by Scott Carle
#Purpose: to combine data across multiple tags/markers where there are high degrees of missing data
##in order to ascertain the state of a certain allele within a biparental population

#constraints: Genome draft must be available, population must be biparental, recombination shouldn't occur within locus, 
##must know position of allele of interest

#tools provided: Quality control graphs and statistics to show what data has been acquired and what it says
##also, and upon approval of that data, an analysis and output function to provide the allele data in question.



#set working directory
#setwd("D:/Tech Demo")
setwd("D:/GLU_B1_project/")
#set file names within working directory, they should be .csv files, but don't include the file extension in the name
##for formatting instructions and examples, see the user manual
PopulationData<-"STAC Integration filtering process spurious removal v4"
#####input of key variables
#Locus Chromosome should be the name of the chromsome that each tag BLASTed to
#start and end position are the physical positions that you want to be the min and max for 
##grabbing markers/tags within the region of your locus, these should be numbers
LocusChromosome<-"1B"
StartPosition<-545000000
EndPosition<-565000000
MinimumConsensusCalls<-1   #this variable is the minumum number of calls of the most prevalent parental allele for the script to attempt to classify a genotype
CutoffThreshold<-.66       #this variable is the portion of calls that must be the most prevalent parental allele, genotypes that fall short of this will be classified as NA

########end of key input variables
#optional variables, can be changed from defaults
AnalysisName<-"Redo2 Edits STAC v1.02"

########Reading In Files

Population<-read.csv(paste(PopulationData,".csv",sep=""),header=TRUE)

#########Sub-sampling section for what will be used
IncludedPopulation<-Population[Population$CHR==LocusChromosome,]
IncludedPopulation<-IncludedPopulation[IncludedPopulation$position>StartPosition,]
IncludedPopulation<-IncludedPopulation[IncludedPopulation$position<EndPosition,]

###########Testing Calculations Formal

numberofmarkers<-nrow(IncludedPopulation)
numberofgenotypes<-(ncol(IncludedPopulation)-4) ####see if you can't secure this to make it less vulnerable to improper formatting

workingtest<-IncludedPopulation[,5:ncol(IncludedPopulation)]
markerlist<-IncludedPopulation$marker
genotypes<-colnames(workingtest)

#####to get the counts of each haplotype, for bargraph
####for twos
workingtest1<-workingtest
workingtest1[is.na(workingtest1)]=0
workingtest1[workingtest1==0]=0
workingtest1[workingtest1==1]=0
workingtest1[workingtest1==2]=1
twosvector<-rowSums(workingtest1)
#zeroes
workingtest1<-workingtest
workingtest1[workingtest1==0]=3
workingtest1[is.na(workingtest1)]=0
workingtest1[workingtest1==1]=0
workingtest1[workingtest1==2]=0
workingtest1[workingtest1==3]=1
zeroesvector<-rowSums(workingtest1)
#ones
workingtest1<-workingtest
workingtest1[is.na(workingtest1)]=0
workingtest1[workingtest1==2]=0
onesvector<-rowSums(workingtest1)
#na's
workingtest1<-workingtest
workingtest1[workingtest1==1]=0
workingtest1[workingtest1==2]=0
workingtest1[is.na(workingtest1)]=1
nasvector<-rowSums(workingtest1)
#####puttingtogether
counttable<-rbind(markerlist,zeroesvector,twosvector,onesvector,nasvector)

##### txt file formatting code
starttable1<-c("Locus Chromosome =","Locus Interval in Basepairs =","number of genotypes =","number of selected markers =")
starttable2<-c(LocusChromosome,paste(StartPosition," to ",EndPosition),numberofgenotypes,numberofmarkers)
starttable<-cbind(starttable1,starttable2)
#########
##making the quality graph list for readable formatting
numberofplots<-ceiling(numberofgenotypes/15)
currentplot<-1
plotlist<-list()
genolist<-list()
for(currentplot in c(1:numberofplots)){
  if(currentplot==numberofplots){plotmax<-numberofgenotypes}
  if(currentplot<numberofplots){plotmax<-currentplot*15}
  plotmin<-1+((currentplot-1)*15)
  qualitybin<-as.matrix(workingtest[1:nrow(workingtest),plotmin:plotmax])
  plotlist[[currentplot]]<-qualitybin
  #experimental genotype listing
  genolist[[currentplot]]<-colnames(workingtest[,plotmin:plotmax])
}
####setting color list for plotting
colorlist<-list()
u<-1
for(u in c(1:numberofplots))
{
  coloring<-plotlist[[u]]
  coloring[coloring==0]="red"
  coloring[coloring==1]="purple"
  coloring[coloring==2]="darkblue"
  colorlist[[u]]<-coloring
}
###updated calculations for offsetting Quality Control Plot list
t<-1
for(t in c(1:numberofplots)){
  offsetvector<-c(1:ncol(plotlist[[t]])) 
  offsetvector<-((offsetvector*5)-5)
  offsetmatrix<-offsetvector
  j<-1
  for(j in c(2:nrow(plotlist[[t]])))
  {
    offsetmatrix<-rbind(offsetmatrix,offsetvector)
  }
  plotlist[[t]]<-offsetmatrix+plotlist[[t]]
}

#######plotting and saving the quality control information

pdf(file=paste(AnalysisName,"_QualityControlAssessment.pdf",sep=""),title=paste("Quality Control Assessment Sheet",AnalysisName))
barplot(counttable[2:5,],main="States of Each Sampled Marker", col=c("red","darkblue","purple","grey"),las=2,names.arg = markerlist,cex.names=0.6)
legend("top",c("0's","2's","1's","NA's"),fill=c("red","darkblue","purple","grey"),cex=.6,horiz=TRUE,bg="transparent")

####

k<-1
for(k in c(1:numberofplots))
{
  plotQ<-plotlist[[k]]
  colorQ<-colorlist[[k]]
  ###the offsetvector commands that follow are for proper alignment
  offsetvector<-c(1:ncol(plotQ))
  offsetvector<-((offsetvector*5)-5)
  i<-1
  for(i in c(1:ncol(plotQ)))
  {
    vector1<-as.numeric(plotQ[,i])
    vector2<-c(1:numberofmarkers)
    colorvector<-colorQ[,i]
    #plot(c(1:numberofmarkers),vector1,type="o",xlim=c(0,numberofmarkers+1),ylim=c(-1,(ncol(plotQ)*5)),main=paste("Quality Control Plot",j),xlab="markers",ylab="genotypes",col=colorQ[,i])
    plot(vector2[!is.na(vector1)],vector1[!is.na(vector1)],type="o",xlim=c(0,numberofmarkers+1),ylim=c(-1,(ncol(plotQ)*5)),col=colorvector[!is.na(vector1)],main=paste("Quality Control Plot",k,"of",numberofplots),xlab="",ylab="Genotypes",xaxt="n",yaxt="n",pch=16,lwd=2)
    mtext("Markers",side=1,adj=1)
    abline(h=(offsetvector[i]-.2),col="red")
    abline(h=(offsetvector[i]+2.2),col="darkblue")
    abline(h=(offsetvector[i]+1),col="purple")
    abline(v=c(1:numberofmarkers),col="black")
    ##axis(2,at=(offsetvector+1),labels=genotypes)
    par(new=T)
  }
  axis(2,at=(offsetvector+1),labels=genolist[[k]],las=2,cex.axis=.6)
  axis(1,at=c(1:numberofmarkers),labels=markerlist,cex.axis=.6,las=2)
  par(new=F)
}
dev.off()
#####


write.table(starttable, file=paste(AnalysisName," Analysis information.txt",sep=""),row.names=FALSE,col.names=FALSE,quote=FALSE)


#####counting algorithms adapted from previous section, but now for actual calculations for calls
####for twos
workingtest2<-workingtest
workingtest2[is.na(workingtest2)]=0
workingtest2[workingtest2==0]=0
workingtest2[workingtest2==1]=0
workingtest2[workingtest2==2]=1
twosdecisions<-colSums(workingtest2)
#zeroes
workingtest2<-workingtest
workingtest2[workingtest2==0]=3
workingtest2[is.na(workingtest2)]=0
workingtest2[workingtest2==1]=0
workingtest2[workingtest2==2]=0
workingtest2[workingtest2==3]=1
zeroesdecisions<-colSums(workingtest2)
#ones
workingtest2<-workingtest
workingtest2[is.na(workingtest2)]=0
workingtest2[workingtest2==2]=0
onesdecisions<-colSums(workingtest2)
#na's
workingtest2<-workingtest
workingtest2[workingtest2==1]=0
workingtest2[workingtest2==2]=0
workingtest2[is.na(workingtest2)]=1
nasdecisions<-colSums(workingtest2)
#####puttingtogether
decisionstable<-as.data.frame(cbind(twosdecisions,zeroesdecisions,onesdecisions,nasdecisions))
PresentCalls<-rowSums(decisionstable[,1:3])
decisionstable<-cbind(decisionstable,PresentCalls)

###Max Calls
Maxcalls<-apply(decisionstable[,1:3], 1, max)
decisionstable<-cbind(decisionstable,Maxcalls)

FilterInsufficientCalls<-decisionstable[,6]/decisionstable[,5]
ValidCalls<-FilterInsufficientCalls>=CutoffThreshold
SufficientCalls<-decisionstable[,6]>=MinimumConsensusCalls

##getting categorization to work
string1<-ifelse(decisionstable[,1]==decisionstable[,6],2,NA)
string2<-ifelse(decisionstable[,2]==decisionstable[,6],0,NA)
string3<-ifelse(decisionstable[,3]==decisionstable[,6],3,NA)
data.frame<-cbind(string1,string2,string3)
matchingvector<-rowSums(data.frame, na.rm=TRUE)
decisionstable<-cbind(decisionstable,matchingvector,ValidCalls,SufficientCalls)

FinalCall<-decisionstable[,7]
FinalCall[decisionstable[,8]==FALSE]=NA
FinalCall[decisionstable[,9]==FALSE]=NA
FinalCall[decisionstable[,7]==3]=NA
FinalCall[decisionstable[,7]==5]=NA
decisionstable<-cbind(genotypes,decisionstable,FinalCall)

#DeterminationCall<-cbind(call,ValidCalls)
write.csv(decisionstable,file=paste(AnalysisName,"Calls.csv",sep=""),row.names=FALSE,quote=FALSE)
#####

