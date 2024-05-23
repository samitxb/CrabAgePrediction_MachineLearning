################################################################################
#
#   PStA Maschinelles Lernen SS2024
#   Datensatz:  Crab Age Prediction
#       Kaggle: https://www.kaggle.com/datasets/sidhus/crab-age-prediction
#
#   Vorgelegt von:  Sami Taieb (00803933) AI-M
#
################################################################################
library(ggplot2)

# Daten einlesen
setwd("C:/Users/administrator.ICD/Desktop/R ML")

Daten <- read.csv("CrabAgePrediction.csv",header=TRUE,sep=",", fill=TRUE, stringsAsFactors=TRUE)


# Datenkorrektur
Daten[, "Sex"] <- as.factor(Daten[, "Sex"])

# Datensatz in Geschlaechter aufteilen
Daten_M <- Daten[which(Daten$Sex == "M"), ]
Daten_F <- Daten[which(Daten$Sex == "F"), ]
Daten_I <- Daten[which(Daten$Sex == "I"), ]

# PLOT: Laenge und Alter nach Geschlecht
gang_plot <- ggplot(Daten, aes(x = Length, y = Age, color = Sex)) +
geom_point(size = 3) +
labs(
  title = "Laenge und Alter nach Geschlecht",
  x = "Laenge",
  y = "Alter",
  color = "Geschlecht"
) +
theme_minimal()

ggsave(filename = "groesse_alter_nach_geschlecht.png", plot = gang_plot, bg = "white")


#PLOT: Histogram Alter
hist_plot <- ggplot(Daten, aes(x = Age)) +
geom_histogram(binwidth = 0.5, fill = "blue", color = "black", alpha = 0.7) + #alpha macht balken etwas trasparent
labs(
  title = "Histogram Alter",
  x = "Alter",
  y = "Haeufigkeit"
) +
theme_minimal()

ggsave(filename = "histogram_alter.png", plot = hist_plot, bg = "white")
