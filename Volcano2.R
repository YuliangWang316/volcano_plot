setwd("C:/Users/xjmik/Documents/WeChat Files/wxid_4dpiiug8wl8421/FileStorage/File/2022-11/RNA 测序-江苏省人民医院人源Total RNA转录组测序（刘瀚远）/")
diff_gene <- read.csv("All_results_padj_noNA.csv", header=TRUE, row.names=1)
diff_gene=as.data.frame(diff_gene)
gene_list=diff_gene[,c("log2FoldChange","padj")]
colnames(gene_list)=c("logFC","padj")
gene_list$threshold = as.factor(abs(gene_list$logFC) > 0.5 & gene_list$padj < 0.01)
colored_point<-gene_list[gene_list$threshold == "TRUE",]
Spgenes<-colored_point[rownames(colored_point) == "HIF1A" | rownames(colored_point) == "NFKB1" | rownames(colored_point) == "PDK4" ,]
gene_list$threshold<-as.character(gene_list$threshold)
gene_list$threshold[rownames(gene_list) == "HIF1A"]<-"LABEL"
gene_list$threshold[rownames(gene_list) == "NFKB1"]<-"LABEL"
gene_list$threshold[rownames(gene_list) == "PDK4"]<-"LABEL"

gene_list$threshold[which(gene_list$threshold == "TRUE" & gene_list$logFC >0.5)] <- "UP"
Mycolors<-c("Blue","Black","Green","Red")
library("ggplot2")
pdf("vocano1.pdf")

g = ggplot(data=gene_list, aes(x=logFC, y=-log10(padj),color=threshold)) + geom_point(alpha=0.6, size=0.1)  + xlim(c(-7, 7)) + ylim(c(0, 50)) +xlab("log2 fold change") + ylab("-log10 p-value") + theme_set(theme_bw()) + theme(panel.grid.major=element_line(colour=NA)) + scale_color_manual(values = Mycolors)
print(g)
dev.off()

