######################################################## 
# The output directories from gsea as well as a master
# expression table all need to be in the wd you start
# from
########################################################

dirs <- c("yourdirectory_1", "yourdirectory_2", "yourdirectory_3")

for (i in 1:length(dirs)){
  dir <- dirs[i]
  setwd(paste("./",dir,"/",sep=""))
  files <- list.files(path=".",pattern="gsea")[grep("*xls",list.files(path=".",pattern="gsea"))]
  for (k in 1:length(files)){  
    xls <- read.table(files[k], sep="\t", stringsAsFactors = F, header = T)
    genesets <- c()
    genesets <- xls$NAME[1]
    set <- paste(dir,"_",substr(genesets,regexpr("_[^_]*$", genesets)[1]+1,nchar(genesets)), sep="")
    genes <- c()


    xls <- read.table(paste(genesets,".xls",sep=""),sep="\t", stringsAsFactors = F, header = T)
    genes <- c(genes,xls$PROBE[grep("Yes", xls$CORE.ENRICHMENT)])
    #len <- length(genes)
    len <- length(genes)
    path <- "path to your expression file"
    dat <- read.table(path, sep ="\t", stringsAsFactors = F, header = TRUE)
      
    #list of row names and col names respectively
    rc <- list(genes,names(dat))
    #rc <- list(genes,c("GeneSet",names(expression)))
    out <- matrix(nrow=len,ncol=dim(dat)[2],dimnames=rc)

    for (j in 1:len){
      ind <- grep(paste(genes[j],"$",sep=""), dat$Description) #or whatever the column name identifier for your gene names are
      out[j,] <- as.matrix(dat[ind,])
    }

    Signature <- as.matrix(rep(set,len))
    out <- cbind(out, Signature)
    colnames(out)[length(colnames(out))] <- "Signature"

    write.table(out,paste(set,"_",'data.txt',sep=""),sep="\t",row.names=F,quote = F)

  }

  setwd("../")

}
