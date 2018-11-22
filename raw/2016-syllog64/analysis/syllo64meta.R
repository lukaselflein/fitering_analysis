library(RCurl)
library(bitops)
library(metafor)
library(Formula)

setwd("C:/Users/alice/Documents/Postdoc Freiburg/benchmark/analysis")
sylmeta <- read.csv("dataMeta8Stud.csv", sep = ";", header = TRUE)
sylHit <-subset(sylmeta, PointEst == "Hit")
sylCR <-subset(sylmeta, PointEst == "CorrectReject")
sylDet <-subset(sylmeta, PointEst == "Detect")

#meta-analysis
#yi and vi are the effect size and variance of 139 data; yj vj are those of 204 data

##139 data plus meta2012 plus J-L&Bara84(no.6a):
## resHit <- rma(sylHit$yi, sylHit$vi, data = sylHit, method = "HE", slab = paste(Theory))
resHit <- rma(sylHit$yi, sylHit$vi, data = sylHit, method = "REML")
summary(resHit)
#funnel(resHit, main = "Mixed-Effects Model")
forest(resHit, alim = c(0, 1))
confint(resHit)
leave1out(resHit)
regtest(resHit)

#test
sylmeta <- read.csv("test2.csv", sep = ";",  header = TRUE)
sylHit <-subset(sylmeta, PointEst == "Hit")
resHit <- rma(sylHit$yi, sylHit$vi, data = sylHit, method = "HE", slab = paste(Theory))
forest(resHit, alim = c(0, 1))
leave1out(resHit)
residuals(resHit)




resCR <- rma(sylCR$yi, sylCR$vi, data = sylCR, slab = paste(Theory))
summary(resCR)
#funnel(resCR, main = "Mixed-Effects Model")
forest(resCR)
confint(resCR)
leave1out(resCR)
regtest(resCR)

resDet <- rma(sylDet$yi, sylDet$vi, data = sylDet, slab = paste(Theory))
#funnel(resDet, main = "Mixed-Effects Model")
summary(resDet)
forest(resDet)
confint(resDet)
leave1out(resDet)
regtest(resDet)

##meta2012:
sylmeta6 <- read.csv("dataMeta6Stud.csv", sep = ";", header = TRUE)
sylHit6 <-subset(sylmeta6, PointEst == "Hit")
sylCR6 <-subset(sylmeta6, PointEst == "CorrectReject")
sylDet6 <-subset(sylmeta6, PointEst == "Detect")

resHit6 <- rma(sylHit6$yi, sylHit6$vi, data = sylHit6, method = "HE", slab = paste(Theory))
summary(resHit6)
#funnel(resHit6, main = "Mixed-Effects Model")
forest(resHit6)
confint(resHit6)

resCR6 <- rma(sylCR6$yi, sylCR6$vi, data = sylCR6, method = "FE", slab = paste(Theory))
summary(resCR6)
#funnel(resCR6, main = "Mixed-Effects Model")
forest(resCR6)
confint(resCR6)

resDet6 <- rma(sylDet6$yi, sylDet6$vi, data = sylDet6, slab = paste(Theory))
#funnel(resDet6, main = "Mixed-Effects Model")
forest(resDet6)
confint(resDet6)

sylmeta6 <- read.csv("test.csv", sep = ";", header = TRUE)
sylCR6 <-subset(sylmeta6, PointEst == "CorrectReject")
resCR6 <- rma(sylCR6$yi, sylCR6$vi, data = sylCR6, slab = paste(Theory))
summary(resCR6)
#funnel(resCR6, main = "Mixed-Effects Model")
forest(resCR6)
confint(resCR6)


##5-concl 9 studies
sylmeta9 <- read.csv("dataMeta9Stud.csv", sep = ";", header = TRUE)
sylHit9 <-subset(sylmeta9, PointEst == "Hit")
sylCR9 <-subset(sylmeta9, PointEst == "CorrectReject")
sylDet9 <-subset(sylmeta9, PointEst == "Detect")

resHit9 <- rma(sylHit9$yi, sylHit9$vi, data = sylHit9, slab = paste(Theory))
summary(resHit9)
#funnel(resHit9, main = "Mixed-Effects Model")
forest(resHit9)
confint(resHit9)
leave1out(resHit9)

resCR9 <- rma(sylCR9$yi, sylCR9$vi, data = sylCR9, slab = paste(Theory))
summary(resCR9)
#funnel(resCR9, main = "Mixed-Effects Model")
forest(resCR9)
confint(resCR9)
leave1out(resCR9)

resDet9 <- rma(sylDet9$yi, sylDet9$vi, data = sylDet9, slab = paste(Theory))
#funnel(resDet9, main = "Mixed-Effects Model")
forest(resDet9)
confint(resDet9)
leave1out(resDet9)

##5-concl 9 studies, hattori
sylmeta9Hat <- read.csv("dataMeta9StudHat.csv", sep = ";", header = TRUE)
sylHit9Hat <-subset(sylmeta9Hat, PointEst == "Hit")
sylCR9Hat <-subset(sylmeta9Hat, PointEst == "CorrectReject")
sylDet9Hat <-subset(sylmeta9Hat, PointEst == "Detect")

resHit9Hat <- rma(sylHit9Hat$yi, sylHit9Hat$vi, data = sylHit9Hat, slab = paste(Theory))
summary(resHit9Hat)
#funnel(resHit9Hat, main = "Mixed-Effects Model")
forest(resHit9Hat)
confint(resHit9Hat)
leave1out(resHit9Hat)

resCR9Hat <- rma(sylCR9Hat$yi, sylCR9Hat$vi, data = sylCR9Hat, slab = paste(Theory))
summary(resCR9Hat)
#funnel(resCR9Hat, main = "Mixed-Effects Model")
forest(resCR9Hat)
confint(resCR9Hat)
leave1out(resCR9Hat)

resDet9Hat <- rma(sylDet9Hat$yi, sylDet9Hat$vi, data = sylDet9Hat, slab = paste(Theory))
#funnel(resDet9Hat, main = "Mixed-Effects Model")
forest(resDet9Hat)
confint(resDet9Hat)
leave1out(resDet9Hat)



##204data
resHit <- rma(sylHit$yj, sylHit$vj, data = sylHit, slab = paste(Theory))
## for 204 data: no need change method to "HE", error msg for 139 data: 
## resHit <- rma(sylHit$yj, sylHit$vj, data = sylHit, method = "HE", slab = paste(Theory))
summary(resHit)
funnel(resHit, main = "Mixed-Effects Model")
forest(resHit)

resCR <- rma(sylCR$yj, sylCR$vj, data = sylCR, slab = paste(Theory))
summary(resCR)
funnel(resCR, main = "Mixed-Effects Model")
forest(resCR)
confint(resCR)

resDet <- rma(sylDet$yj, sylDet$vj, data = sylDet, slab = paste(Theory))
funnel(resDet, main = "Mixed-Effects Model")
forest(resDet)
confint(resDet)

###__________________________________________________________________________________________________
### Rasch model
require(eRm)
sylRasch <- read.csv("syllo64_Rasch.csv")
syl.rasch <- RM(sylRasch)
psyl.rasch <- person.parameter(syl.rasch)
lrsyl.rasch <- LRtest(syl.rasch, splitcr = "mean")
lrsyl.rasch
model.matrix(syl.rasch)
plotPImap(syl.rasch)
plot(psyl.rasch)
plotGOF(lrsyl.rasch, ctrline = list(gamma=0.95, col="red", lty="dashed"))
plotICC(syl.rasch, item.subset = 1:64, ask = F, empICC = list("raw"), empCI = list (lty = "solid") )

###____________________________________________________________________________________________________
#cluster analysis
require(golubEsets)
setwd("C:/Users/Alice/Documents/Postdoc Freiburg/syllogism64/analysis")
CluS139 <- read.csv("syllo64_SylXSs139.csv")

# calculate variance and rearrange columns by variance decreasingly
CluS139.rearrange <- CluS139[, order(apply(CluS139, 2, var), decreasing = T)]
# K-Means Cluster Analysis
fit <- kmeans(x = CluS139, 2)
fit$cluster  # get cluster assignment
fit$centers  # get cluster center
# get cluster means
aggregate(CluS139, by = list(fit$cluster), FUN = mean)

require(cluster)
fit2 <- pam(x = CluS139, k = 2)
fit2$silinfo$avg.width
fit3 <- pam(x = CluS139, k = 3)
fit3$silinfo$avg.width
fit4 <- pam(x = CluS139, k = 4)
fit4$silinfo$avg.width
fit5 <- pam(x = CluS139, k = 5)
fit5$silinfo$avg.width
fit6 <- pam(x = CluS139, k = 6)
fit6$silinfo$avg.width
fit7 <- pam(x = CluS139, k = 7)
fit7$silinfo$avg.width

require(fpc)
cluster139.best <- pamk(CluS139)
cat("number of clusters estimated by optimum average silhouette width:", cluster139.best$nc, "\n")
plot(pam(CluS139, cluster139.best$nc))

fit2$clustering  # get cluster assignment
fit2$medoids  # get coordinates of each medoid
# summary method
summary(fit2)

# Ward Hierarchical Clustering
d <- dist(CluS139, method = "euclidean")  # distance matrix
fit <- hclust(d, method = "ward.D")
plot(fit)
groups <- cutree(fit, k = 3)  
# draw dendogram with red borders around the 2 clusters
rect.hclust(fit, k = 3, border = "red")
require(corrplot)
corrplot(cor(CluS139.rearrange[, 1:20]))


CluS139S <- read.csv("syllo64_SsXSyl139.csv")
require(fpc)
cluster139S.best <- pamk(CluS139S)
cat("number of clusters estimated by optimum average silhouette width:", cluster139S.best$nc, "\n")
plot(pam(CluS139S, cluster139S.best$nc))

summary(cluster139S.best)
summary(cluster139.best)
cluster139.best
cluster139S.best

#____________________
set.seed(20)
Kmean139 <- kmeans(CluS139S, 2, nstart=20)


#Clustering for syllogisms_______________________________

CluS139Syl <- read.csv("syllo64_SylloXSs139.csv", sep = ";")
require(cluster)
fit2 <- pam(x = CluS139Syl, k = 2)
fit2$silinfo$avg.width
fit3 <- pam(x = CluS139Syl, k = 3)
fit3$silinfo$avg.width
fit4 <- pam(x = CluS139Syl, k = 4)
fit4$silinfo$avg.width
fit5 <- pam(x = CluS139Syl, k = 5)
fit5$silinfo$avg.width
fit6 <- pam(x = CluS139Syl, k = 6)
fit6$silinfo$avg.width
fit7 <- pam(x = CluS139Syl, k = 7)
fit7$silinfo$avg.width

require(fpc)
cluster139Syl.best <- pamk(CluS139Syl)
cat("number of clusters estimated by optimum average silhouette width:", cluster139Syl.best$nc, "\n")

fit2$clustering  # get cluster assignment
fit2$medoids  # get coordinates of each medoid
# summary method
summary(fit2)

# Ward Hierarchical Clustering
d <- dist(CluS139, method = "euclidean")  # distance matrix
fit <- hclust(d, method = "ward.D")
plot(fit)
groups <- cutree(fit, k = 3)  
# draw dendogram with red borders around the 2 clusters
rect.hclust(fit, k = 3, border = "red")
require(corrplot)
corrplot(cor(CluS139.rearrange[, 1:20]))
