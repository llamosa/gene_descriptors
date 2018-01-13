library(ontologyIndex)
library(RJSONIO)
library(ontologySimilarity)
library(RCurl)

data(go)
data(gene_GO_terms)
data(GO_IC)

#json_data <- RJSONIO::fromJSON(file=getURL('https://github.com/TBomberman/Optimizer/blob/master/L1000/landmark_genes.json'))
gene_json_data <- jsonlite::fromJSON('data/landmark_genes.json')

#gene_list = c("LRBA", "LYST", "NBEA", "NBEAL1", "NBEAL2", "NSMAF", "WDFY3", "WDFY4", "WDR81")
gene_list <- gene_json_data["gene_symbol"][[1]]

beach <- gene_GO_terms[gene_list]

go_terms <- c()
for (i in (1:length(gene_list) )){
  print(c(i,gene_list[[i]],beach[[i]]))
  go_terms <- c(go_terms,beach[[i]])
}

go_terms_unique <- sort(unique(go_terms))

gene_go_fingerprint <- matrix(0,length(gene_list),length(go_terms_unique))
for (i in (1:length(go_terms_unique))){
  for (j in (1:length(gene_list))){
    if (length(which(beach[[j]] == go_terms_unique[[i]])) == 1){
      gene_go_fingerprint[j,i] <- 1
      
    }
  }
}

rownames(gene_go_fingerprint) <- gene_list
colnames(gene_go_fingerprint) <- go_terms_unique
write.csv(gene_go_fingerprint,file="data/gene_go_fingerprint.csv", quote=FALSE)