setwd("C:/Users/xjmik/Desktop/")
diff_gene <- read.table("pbmc.markers.txt", sep="\t", header=TRUE, row.names=1)
diff_gene=as.data.frame(diff_gene)
gene_list=diff_gene[,c("avg_log2FC","p_val_adj")]
colnames(gene_list)=c("logFC","padj")
gene_list$threshold = as.factor(abs(gene_list$logFC) > 0.25 & gene_list$padj < 0.00001)
colored_point<-gene_list[gene_list$threshold == "TRUE",]
Spgenes<-colored_point[rownames(colored_point) == "Pdcd1" | rownames(colored_point) == "Nrp1",]
gene_list$threshold<-as.character(gene_list$threshold)
gene_list$threshold[which(rownames(gene_list) == "Pdcd1" | rownames(gene_list) == "Nrp1")]<-"LABEL"
Mycolors<-c("Gray","#660303","#031d66")
library("ggplot2")
pdf("vocano.pdf")

g = ggplot(data=gene_list, aes(x=logFC, y=-log10(padj),color=threshold)) + geom_point(alpha=0.5,size=1.75)  + xlim(c(-1.5, 2)) + ylim(c(0, 350)) +xlab("log2 fold change") + ylab("-log10 p-value") + theme_set(theme_bw()) + theme(panel.grid.major=element_line(colour=NA)) + scale_color_manual(values = Mycolors)
print(g)
dev.off()
