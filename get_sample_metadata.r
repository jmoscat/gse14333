source("http://www.bioconductor.org/biocLite.R")
source("http://bioconductor.org/biocLite.R")
biocLite("GEOquery")
library(Biobase)
library(GEOquery)

gds <- getGEO("gse14333", GSEMatrix=FALSE)

results <- matrix(ncol=4,byrow=TRUE)
colnames(results) <- c("geo_accession","DFS_Time","DFS_Cens", "Duke")

for (i in 1:290){
	#adding bogus column
	results <- rbind(results,c("a","b","c","d"))
	#getting DFS
	descrip <- Meta(GSMList(gds)[[i]])$description
	descr_par <- strsplit(descrip, ";")
	DFS <- strsplit(descr_par[[1]][4], " ")
	final_DFS <- DFS[[1]][3]
	
	duke <- strsplit(descr_par[[1]][2], " ")
	final_duke <- duke[[1]][3]
	
	cens <- strsplit(descr_par[[1]][6], " ")
	final_cens <- cens[[1]][3]
	
	results[i,1]= Meta(GSMList(gds)[[i]])$geo_accession
	results[i,2]= final_DFS
	results[i,3]= final_cens
	results[i,4] = final_duke
	
	#Get expression levels for selected probes (uncomment if neccessary)
#	rows = dim(Table(GSMList(gds)[[i]]))[1]
#	for (j in 1:rows){
#		if (Table(GSMList(gds)[[i]])[j,1] =="220846_s_at" )	{
#			results[i,3] = Table(GSMList(gds)[[i]])[j,2]
		
#		}
#		if (Table(GSMList(gds)[[i]])[j,1] =="202178_at" )	{
#			results[i,4] = Table(GSMList(gds)[[i]])[j,2]
#		}
		
#	}
	
}
write.table(results, file = "results.csv", sep = ";", col.names = NA, qmethod = "double")