################################################################################
#
#   PStA Maschinelles Lernen SS2024
#   Datensatz:  Crab Age Prediction
#       Kaggle: https://www.kaggle.com/datasets/sidhus/crab-age-prediction
#
#   Vorgelegt von:  Sami Taieb (00803933) AI-M
#
################################################################################


# Daten einlesen
setwd("C:/Users/administrator.ICD/Desktop/R ML")

Daten <- read.csv("CrabAgePrediction.csv",header=TRUE,sep=",", fill=TRUE, stringsAsFactors=TRUE)


# Datenkorrektur
Daten[, "Sex"] <- as.factor(Daten[, "Sex"])

# Datensatz in Geschlaechter aufteilen
Daten_M <- Daten[which(Daten$Sex == "M"), ]
Daten_F <- Daten[which(Daten$Sex == "F"), ]
Daten_I <- Daten[which(Daten$Sex == "I"), ]

##!! Abstand zueinander zu gering
plot(Daten_M[, "Length"], Daten_M[, "Age"], main="Gegenueberstellung von Laenge und Alter", xlab="Laenge", ylab="Alter", col="red", cex=1)
points(Daten_F[, "Length"], Daten_F[, "Age"], col="blue", cex=1)
points(Daten_I[, "Length"], Daten_I[, "Age"], col="green", cex=1)