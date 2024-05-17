setwd("C:/Users/administrator.ICD/Desktop/R ML")

Daten <- read.csv("CrabAgePrediction.csv",header=TRUE,sep=",", fill=TRUE, stringsAsFactors=TRUE)

Daten[1:15,]

summary(Daten)