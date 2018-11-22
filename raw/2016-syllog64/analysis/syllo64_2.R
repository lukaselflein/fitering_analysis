setwd("C:/Users/alice/Documents/Postdoc Freiburg/syllogism64/analysis")

data <- read.csv("C:/Users/alice/Documents/Postdoc Freiburg/syllogism64/analysis/syllo64_139.csv", sep = ";")

library(plyr)

result <- ddply(data, .variables=.(syllog), .fun = function(x) {

  all_med <- median(x$time)
  all_correct <- median(x[x$correctness == 1,]$time)
  all_no_outliers <- median(x[x$timeFil == 1,]$time)
  

  cluster_medians <- ddply(x, .variables=.(ClusterSs), .fun = function(y) {
    cluster_med <- median(y$time)
    cluster_correct <- median(y[y$correctness == 1,]$time)
    cluster_no_outliers <- median(y[y$timeFil == 1,]$time)
    return(data.frame(allRT=cluster_med, correctRT=cluster_correct, correctFilRT=cluster_no_outliers))
  })
  

  cluster1 <- cluster_medians[cluster_medians$ClusterSs == 1,][1,]
  cluster2 <- cluster_medians[cluster_medians$ClusterSs == 2,][1,]
  

  return(data.frame(
    All_allRT=all_med,
    All_correctRT=all_correct,
    All_correctFilRT=all_no_outliers,
    Cluster1_allRT=cluster1$allRT,
    Cluster1_correctRT=cluster1$correctRT,
    Cluster1_correctFilRT=cluster1$correctFilRT,
    Cluster2_allRT=cluster2$allRT,
    Cluster2_correctRT=cluster2$correctRT,
    Cluster2_correctFilRT=cluster2$correctFilRT))
})

write.table(result, "mediansSylo.csv", sep=";", row.names = F)

## for participants

result2 <- ddply(data, .variables=.(subj), .fun = function(x) {
  
  all_med <- median(x$time)
  all_correct <- median(x[x$correctness == 1,]$time)
  all_no_outliers <- median(x[x$timeFil == 1,]$time)
  
  return(data.frame(
    All_allRT=all_med,
    All_correctRT=all_correct,
    All_correctFilRT=all_no_outliers))
})

write.table(result2, "mediansSs.csv", sep=";", row.names = F)
