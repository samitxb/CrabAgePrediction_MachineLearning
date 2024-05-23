# CrabAgePrediction Maschinelles Lernen - Datenanalyse
PStA im Modul "Maschinelles Lernen SS2024" bei Herrn Prof. Dr. Robert Hable (Abgabe am 26. Juni 2024)

# Entwicklungsumgebeung
Bevor dieses Repo auf dem eigenen Rechner zu 100% reproduziert werden kann, sind einige initiale Schritte noetig.
## Installation von R
https://cran.r-project.org/bin/windows/base/ (Windows Installation)
## Aufsetzen von VSCode
### Installation von VSCode
Der Download von VSCode ist unter folgendem Link moeglich. 
https://code.visualstudio.com/download (Windows Installation)
### Verwendete Extension in VSCode
Extensions sind in VSCode auf der linken Seite mit dem Symbol von 4 Bloecken zu erreichen. Hier wurden aus dem VSCode Extension Marketplace folgende installiert:

- R - REditorSupport
+ Rainbow CSV - mechatroner (nicht unbedingt noetig, macht aber den Datensatz uebersichtlicher)

### Git Bash
Git Bash im Zielordner ausführen und folgenden Befehl ausführen:
git clone https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis.git

### Anpassungen in VSCode
Im Explorer von VSCode den Projektordner öffnen. Danach den Pfad der csv-Datei anpassen.

## Installation benoetigter Pakete
- ggplot2 - hierbei "install.packages("ggplot2")" im Terminal von R ausfuehren und wähle einen CRAN Mirror aus (bspw. Germany - Erlangen).
- GGally - ... install.packages("GGally") ...

# Datensatz und Zweck der Analyse
Der Datensatz wird verwendet, um das Alter der Krabbe auf der Grundlage der physischen Attribute zu schätzen. Es ist ein hervorragender Ausgangspunkt für die klassische Regressionsanalyse und das Feature-Engineering sowie für das Verständnis der Auswirkungen des Feature-Engineering im Bereich Data Science. (Deutsche Übersetzung von Kaggle Beschreibung des Datensatzes)
## Wo finde ich den Datensatz?
https://www.kaggle.com/datasets/sidhus/crab-age-prediction
## Summary

|   Sex   |     Length      |    Diameter     |     Height      |     Weight      |
|---------|-----------------|-----------------|-----------------|-----------------|
| F:1225  | Min.   :0.1875  | Min.   :0.1375  | Min.   :0.0000  | Min.   : 0.0567 |
| I:1233  | 1st Qu.:1.1250  | 1st Qu.:0.8750  | 1st Qu.:0.2875  | 1st Qu.:12.6722 |
| M:1435  | Median :1.3625  | Median :1.0625  | Median :0.3625  | Median :22.7930 |
|         | Mean   :1.3113  | Mean   :1.0209  | Mean   :0.3494  | Mean   :23.5673 |
|         | 3rd Qu.:1.5375  | 3rd Qu.:1.2000  | 3rd Qu.:0.4125  | 3rd Qu.:32.7862 |
|         | Max.   :2.0375  | Max.   :1.6250  | Max.   :2.8250  | Max.   :80.1015 |


|  Shucked.Weight   |  Viscera.Weight   |   Shell.Weight    |       Age      |
|-------------------|-------------------|-------------------|----------------|
| Min.   : 0.02835  | Min.   : 0.01418  | Min.   : 0.04252  | Min.   : 1.000 |
| 1st Qu.: 5.34388  | 1st Qu.: 2.66485  | 1st Qu.: 3.71378  | 1st Qu.: 8.000 |
| Median : 9.53961  | Median : 4.86194  | Median : 6.66213  | Median :10.000 |
| Mean   :10.20734  | Mean   : 5.13655  | Mean   : 6.79584  | Mean   : 9.955 |
| 3rd Qu.:14.27397  | 3rd Qu.: 7.20077  | 3rd Qu.: 9.35534  | 3rd Qu.:11.000 |
| Max.   :42.18406  | Max.   :21.54562  | Max.   :28.49125  | Max.   :29.000 |

# Deskriptive Analyse
## Univariate Analyse
### Histogramm Alter
![histogramm](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/histogram_alter.png)

## Bivariate Analysen
### Laenge und Alter nach Geschlecht
![scatter](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/groesse_alter_nach_geschlecht.png)
### Boxplot Alter Geschlecht
![boxplot](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/boxplot_alter_geschlecht.png)
### Violin Alter Geschlecht
![violin](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/violin_alter_geschlecht.png)

## Multivariate Analysen
### Pairs Plot
![pairsplot](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/pairs_plot.png)
### Korrelationsmatrix (Heatmap)
![heatmap](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/korrelationsmatrix_heatmap.png)

# Ergebnisse und Analyse der verwendeten Lernverfahren
