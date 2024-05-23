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
library(GGally)

# Daten einlesen
#setwd("C:/Users/administrator.ICD/Desktop/R ML")
setwd("C:/Users/Sami/Desktop/CrabAgePrediction_ML_DataAnalysis")

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

ggsave(filename = "groesse_alter_nach_geschlecht.png", plot = gang_plot, bg = "white", width = 10, height = 7)


#PLOT: Histogram Alter
hist_plot <- ggplot(Daten, aes(x = Age)) +
geom_histogram(binwidth = 0.5, fill = "blue", color = "black", alpha = 0.7) + #alpha macht balken etwas trasparent
labs(
  title = "Histogram Alter",
  x = "Alter",
  y = "Haeufigkeit"
) +
theme_minimal()
ggsave(filename = "histogram_alter.png", plot = hist_plot, bg = "white", width = 10, height = 7)

#PLOT: Violin Alter Geschlecht
violin_plot <- ggplot(Daten, aes(x = Age, y = Sex, fill = Sex)) +
geom_violin() +
labs(
  title = "Violin Plot Alter und Geschlecht",
  x = "Alter",
  y = "Geschlecht"
) +
theme_minimal()
ggsave(filename = "violin_alter_geschlecht.png", plot = violin_plot, bg = "white", width = 10, height = 7)

#PLOT: Box Alter Geschlecht
box_plot <- ggplot(Daten, aes(x = Age, y = Sex, fill = Sex)) +
geom_boxplot()
labs(
  title = "Boxplot Alter Geschlecht",
  x = "Alter",
  y = "Geschlecht"
) +
theme_minimal()
ggsave(filename = "boxplot_alter_geschlecht.png", plot = box_plot, bg = "white", width = 10, height = 7)

#PLOT: Pairs Plot
pairs_plot <- ggpairs(
  Daten, 
  axisLabels = "none",
  lower = list(continuous = wrap("points", alpha = 0.3, size = 0.5), mapping = aes(color = Sex)),
  diag = list(continuous = wrap("barDiag", alpha = 0.3, bins = 30)),
  upper = list(continuous = wrap("blank"))
  )
ggsave(filename = "pairs_plot.png", plot = pairs_plot, bg = "white", width = 10, height = 7)

#Korrelationsmatrix
korrelationsmatrix <- cor(Daten[, 2 : 9])
koordinaten_heatmap <- expand.grid(row = colnames(korrelationsmatrix), col = colnames(korrelationsmatrix))
heatmap_daten <- cbind(koordinaten_heatmap, value = as.vector(korrelationsmatrix))
#PLOT: Korrelationsmatrix
korr_mat_plot <- ggplot(data = heatmap_daten, aes(x = col, y = row, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) +
  geom_text(aes(label = round(value, 2)), color = "black", size = 3) +
  theme_minimal() +
  labs(
    title = "Heatmap der Korrelationsmatrix",
    x = "",
    y = ""
  )
  ggsave(filename = "korrelationsmatrix_heatmap.png", plot = korr_mat_plot, bg = "white", width = 10, height = 7)

