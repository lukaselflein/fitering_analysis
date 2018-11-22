#setwd("C:/Users/alice/Documents/Postdoc Freiburg/syllogism64/analysis")

MMT_time <- read.csv("Data_PagesL_MMT_time.csv", sep = ";", header = FALSE)
MMT <- read.csv("Data_PagesL_MMT_ACC.csv", sep = ";", header = FALSE)

matching_time <- read.csv("Data_PagesL_matching_time.csv", sep = ";", header = FALSE)
matching <- read.csv("Data_PagesL_matching_ACC.csv", sep = ";", header = FALSE)

PHM_time <- read.csv("Data_PagesL_PHM_time.csv", sep = ";", header = FALSE)
PHM <- read.csv("Data_PagesL_PHM_ACC.csv", sep = ";", header = FALSE)

page.trend.test(MMT)
page.trend.test(MMT_time)
page.trend.test(PHM)
page.trend.test(PHM_time)
page.trend.test(matching)
page.trend.test(matching_time)