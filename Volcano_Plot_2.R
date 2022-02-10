setwd("C:/Users/CAI/Documents/WeChat Files/wxid_xkl419gp3la622/FileStorage/File/2021-11")
diff_gene <- read.table("All_results_Morethan_equalto5.txt", sep="\t", header=TRUE, row.names=1)
diff_gene=as.data.frame(diff_gene)
gene_list=diff_gene[,c("log2FoldChange","padj")]
colnames(gene_list)=c("logFC","padj")
gene_list$threshold = as.factor(abs(gene_list$logFC) > 0.5 & gene_list$padj < 0.00001)
colored_point<-gene_list[gene_list$threshold == "TRUE",]
Spgenes<-colored_point[rownames(colored_point) == "Rap1b" | rownames(colored_point) == "Arid3a",]
gene_list$threshold<-as.character(gene_list$threshold)
gene_list$threshold[which(rownames(gene_list) == "Rap1b" | rownames(gene_list) == "Arid3a")]<-"LABEL"
Mycolors<-c("Black","#DC143C","#ADD8E6")
library("ggplot2")
pdf("vocano.pdf")

g = ggplot(data=gene_list, aes(x=logFC, y=-log10(padj),color=threshold)) + geom_point(alpha=0.4, size=1.75)  + xlim(c(-5, 5)) + ylim(c(0, 200)) +xlab("log2 fold change") + ylab("-log10 p-value") + theme_set(theme_bw()) + theme(panel.grid.major=element_line(colour=NA)) + scale_color_manual(values = Mycolors)
print(g)
dev.off()
