cell_lines <-  read.csv("data/cell_lines.csv",header=FALSE)
cell_lines <- cell_lines[order(cell_lines)]
cell_lines <- as.matrix(cell_lines)[order(cell_lines)]
binary_cell_lines <- c()
for (i in (1:length(cell_lines))){
  binary_cell_lines <- rbind(binary_cell_lines, as.integer(intToBits(i))[1:7])
  
}
rownames(binary_cell_lines) <- cell_lines
#colnames(binary_cell_lines) <- go_terms_unique
write.csv(binary_cell_lines,file="data/cell_line_fingerprint.csv", quote=FALSE)