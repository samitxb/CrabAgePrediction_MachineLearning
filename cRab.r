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

library(tidyverse)
library(e1071)       # Für SVM/SVR
library(tree)       # Für Entscheidungsbaum
library(caret)

# Funktion zum Löschen der Konsole je nach Umgebung
clear_console <- function() {
  if (Sys.getenv("RSTUDIO") == "1") {
    cat("\014")  # Lösche Konsole in RStudio
  } else if (.Platform$OS.type == "windows") {
    shell("cls")  # Lösche Konsole in Windows (VS Code)
  } else {
    cat("\014")  # Versuche das Formfeed-Zeichen für andere Umgebungen
  }
}


clear_console()

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

clear_console()

# Splitte die Daten in Trainings- und Testdatensätze
set.seed(123)
training_indices <- sample(1:nrow(Daten), 0.7 * nrow(Daten))
trainingdaten <- Daten[training_indices, ]
testdaten <- Daten[-training_indices, ]

# Lineare Regression
linear_model <- lm(Age ~ ShellWeight, data = trainingdaten)
linear_predictions <- predict(linear_model, testdaten)
linear_mse <- mean((linear_predictions - testdaten$Age)^2)
linear_mae <- mean(abs(linear_predictions - testdaten$Age))
print(paste("MSE of Linear Regression:", linear_mse))
print(paste("MAE of Linear Regression:", linear_mae))


# Plot für Lineare Regression
linear_plot <- ggplot(testdaten, aes(x = ShellWeight, y = Age)) +
  geom_point(color = "blue", alpha = 0.5) +
  geom_line(aes(y = linear_predictions), color = "red") +
  labs(
    title = "Lineare Regression: Vorhersagen vs. Tatsächliche Werte",
    x = "ShellWeight",
    y = "Age"
  ) +
  theme_minimal()
ggsave(filename = "linear_regression_plot.png", plot = linear_plot, bg = "white", width = 10, height = 7)


# Entscheidungsbaum
tree_model <- tree(Age ~ ShellWeight, data = trainingdaten)
tree_predictions <- predict(tree_model, testdaten)
tree_mse <- mean((tree_predictions - testdaten$Age)^2)
tree_mae <- mean(abs(tree_predictions - testdaten$Age))
print(paste("MSE of Decision Tree:", tree_mse))
print(paste("MAE of Decision Tree (tree):", tree_mae))


# Plot für Entscheidungsbaum
tree_plot <- ggplot(testdaten, aes(x = ShellWeight, y = Age)) +
  geom_point(color = "blue", alpha = 0.5) +
  geom_line(aes(y = tree_predictions), color = "red") +
  labs(
    title = "Entscheidungsbaum: Vorhersagen vs. Tatsächliche Werte",
    x = "ShellWeight",
    y = "Age"
  ) +
  theme_minimal()
ggsave(filename = "decision_tree_plot.png", plot = tree_plot, bg = "white", width = 10, height = 7)




# Support Vector Regression (SVR)
svr_model <- svm(Age ~ ShellWeight, data = trainingdaten)
svr_predictions <- predict(svr_model, testdaten)
svr_mse <- mean((svr_predictions - testdaten$Age)^2)
svr_mae <- mean(abs(svr_predictions - testdaten$Age))
print(paste("MSE of SVM:", svm_mse))
print(paste("MAE of SVM:", svr_mae))


# Plot für SVM
svr_plot <- ggplot(testdaten, aes(x = ShellWeight, y = Age)) +
  geom_point(color = "blue", alpha = 0.5) +
  geom_line(aes(y = svr_predictions), color = "red") +
  labs(
    title = "Support Vector Regression: Vorhersagen vs. Tatsächliche Werte",
    x = "ShellWeight",
    y = "Age"
  ) +
  theme_minimal()
ggsave(filename = "svr_plot.png", plot = svr_plot, bg = "white", width = 10, height = 7)

# Support Vector Regression (SVR) mit Hyperparameter-Tuning
cc <- seq(-5, 10, 1)    # für mögliche Werte von "Cost" (Tuningparameter)
cg <- seq(-4, 1, 0.5)   # für mögliche Werte von "gamma" (Tuningparameter)

tuning <- tune.svm(Age ~ ShellWeight, data = trainingdaten, scale = TRUE, type = "eps-regression", kernel = "radial",
                   gamma = 10^cg, cost = 2^cc, epsilon = 0.1, tunecontrol = tune.control(sampling = "cross", cross = 5))

print(tuning)
best_svr_model <- tuning$best.model  # Das Modell mit den optimalen Tuningparametern

# Vorhersagen mit dem besten Modell
svr_predictions <- predict(best_svr_model, testdaten)
svr_mse <- mean((svr_predictions - testdaten$Age)^2)
svr_mae <- mean(abs(svr_predictions - testdaten$Age))
print(paste("MSE of Tuned SVM:", svr_mse))
print(paste("MAE of Tuned SVM:", svr_mae))

# Plot für SVM mit den besten Parametern
svr_plot <- ggplot(testdaten, aes(x = ShellWeight, y = Age)) +
  geom_point(color = "blue", alpha = 0.5) +
  geom_line(aes(y = svr_predictions), color = "red") +
  labs(
    title = "Tuned Support Vector Regression: Vorhersagen vs. Tatsächliche Werte",
    x = "ShellWeight",
    y = "Age"
  ) +
  theme_minimal()
ggsave(filename = "tuned_svr_plot.png", plot = svr_plot, bg = "white", width = 10, height = 7)