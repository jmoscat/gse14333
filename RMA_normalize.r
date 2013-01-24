#Perform RMA normalization and output expression level for selected probe.


library(affy)

files <- list.celfiles(path="/Users/jmoscat/Desktop/Jorgete/GSE14333_RAW",full.names=TRUE)
results <- matrix(ncol=2,byrow=TRUE)


for (i in 1:290){
	print(i)
	results <- rbind(results,c("a","b"))
	batch <- ReadAffy(filenames = files[i],compress=TRUE,cdfname = "hgu133plus2hsentrezgcdf")
	ei <- rma(batch)
	#just collect expression level for corresponding probe (lookup table)
	eit <- t(exprs(ei["5590_at",]))
	results[i,1] <- substr(files[i],50,58)
	results[i,2] <- eit[1,1]
	

}
write.csv(results, file = "out.csv")	


