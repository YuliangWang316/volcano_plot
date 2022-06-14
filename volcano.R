setwd("D:/yyy/Merge_HUADA_YK_HUADA2/")
diff_gene <- read.table("mycounts_YKHUADA_Diff_3vs31262021264051011.02870399361803_noNA.txt", sep="\t", header=TRUE, row.names=1)
diff_gene=as.data.frame(diff_gene)
gene_list=diff_gene[,c("log2FoldChange","padj")]
colnames(gene_list)=c("logFC","padj")
gene_list$threshold = as.factor(abs(gene_list$logFC) > 0.58 & gene_list$padj < 0.05)
colored_point<-gene_list[gene_list$threshold == "TRUE",]
Spgenes<-colored_point[rownames(colored_point) == "Prdm1",]
gene_list$threshold<-as.character(gene_list$threshold)
gene_list$threshold[which(rownames(gene_list) == "Prdm1" )]<-"LABEL"
Mycolors<-c("Gray","Red","Black")
library("ggplot2")
pdf("vocano.pdf")

g = ggplot(data=gene_list, aes(x=logFC, y=-log10(padj),color=threshold)) + geom_point(alpha=0.4, size=1.75)  + xlim(c(-3, 3)) + ylim(c(0, 12.5)) +xlab("log2 fold change") + ylab("-log10 p-value") + theme_set(theme_bw()) + theme(panel.grid.major=element_line(colour=NA)) + scale_color_manual(values = Mycolors)
print(g)
dev.off()
