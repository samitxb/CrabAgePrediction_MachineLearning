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
- tidyverse
- e1071
- tree
- caret

# Datensatz und Zweck der Analyse
Der Datensatz wird verwendet, um das Alter der Krabbe auf der Grundlage der physischen Attribute zu schätzen. Es ist ein hervorragender Ausgangspunkt für die klassische Regressionsanalyse und das Feature-Engineering sowie für das Verständnis der Auswirkungen des Feature-Engineering im Bereich Data Science. (Deutsche Übersetzung von Kaggle)
## Was beinhaltet der Datensatz an Features?
|   Sex   |     Length      |    Diameter     |     Height      |     Weight      |
|---------|-----------------|-----------------|-----------------|-----------------|
| Gender of the Crab - Male, Female and Indeterminate. | Length of the Crab (in Feet; 1 foot = 30.48 cms)  | Diameter of the Crab (in Feet; 1 foot = 30.48 cms)  | Height of the Crab (in Feet; 1 foot = 30.48 cms)  | Weight of the Crab (in ounces; 1 Pound = 16 ounces) |

|  Shucked.Weight   |  Viscera.Weight   |   Shell.Weight    |       Age      |
|-------------------|-------------------|-------------------|----------------|
| Weight without the shell (in ounces; 1 Pound = 16 ounces)  | is weight that wraps around your abdominal organs deep inside body (in ounces; 1 Pound = 16 ounces)  | Weight of the Shell (in ounces; 1 Pound = 16 ounces)  | Age of the Crab (in months) |

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
Um sich zunächst einen Überblick des Datensatzes zu verschaffen, wird im folgenden eine deskriptive Analyse durchgeführt. Dies beinhaltet folgende Grafiken, die hier noch genauer behandelt werden:
+ Histogramm (Alter)
+ Scatter-Plot (Länge, Alter)
+ Box-Plot (Alter, Geschlecht)
+ Violin-Plot (Alter, Geschlecht)
+ Pairs-Plot
+ Heatmap der Korrelationsmatrix

## Univariate Analyse
Die univariate Analyse untersucht einzelne Variablen unabhängig voneinander. Ziel ist es, grundlegende Eigenschaften der Daten zu verstehen. Expliziet hier wird sich die Variable Alter im Histogramm näher angesehen, um sich einen Überblick der Verteilung zu verschaffen. 
### Histogramm Alter
![histogramm](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/histogram_alter.png)
Das Histogramm ist ziemlich gut Normalenverteilt und auf der Grafik scheint das Durchschnittsalter in etwa 10 Monate zu sein. Dies kommt auch sehr genau an den Wert aus der Summary heran (9.955). Dieses Histogramm stellt die Werte aus der Summary anschaulich graphisch dar.

## Bivariate Analysen
Die bivariate Analyse untersucht die Beziehung zwischen zwei Variablen. Dies hilft, Zusammenhänge und Abhängigkeiten zu identifizieren. Hier werden Zusammenhänge dargestellt, welche aus dem Bauch heraus zusammenhängend erscheinen. Alleine die graphische Darstellung dieser, lässt die Annahme weder bestätigen, noch wiederlegen. Dennoch geben diese einen guten Einblick und ist der initiale Schritt um tendenzen im Datenset zu erkennen.
### Laenge und Alter nach Geschlecht
![scatter](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/groesse_alter_nach_geschlecht.png)
Mit Hilfe eines Streudiagramms, wurde die Beziehung zwischen der Länge und dem Alter untersucht. Obwohl es Korrelation zu geben scheint, kann die Kausalität nicht allein aus dem Streudiagramm abgeleitet werden.
### Boxplot Alter Geschlecht
![boxplot](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/boxplot_alter_geschlecht.png)
Der Boxplot dient dazu, die Altersverteilung zwischen männlichen und weiblichen Krabben sowie Indeterminate Krabben zu vergleichen. Die Boxplots zeigen, dass der Median, die Quartile und die Ausreißer für männliche und weibliche Krabben im Vergleich zu den mittleren Krabben fast identisch sind.
### Violin Alter Geschlecht
![violin](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/violin_alter_geschlecht.png)
Mithilfe eines Violin-Diagramms wird die Altersverteilung in Abhängigkeit vom Geschlecht untersucht. Das Diagramm zeigt eine Ausbuchtung in der Mitte, was darauf hindeutet, dass der Medianwert häufiger vorkommt als andere Werte. Dies wiederum deutet darauf hin, dass die Verteilung möglicherweise auf den Median ausgerichtet ist oder mehr Beobachtungen um ihn herum vorliegen.

## Multivariate Analysen
### Pairs Plot
![pairsplot](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/pairs_plot.png)
### Korrelationsmatrix (Heatmap)
![heatmap](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/korrelationsmatrix_heatmap.png)

# Ergebnisse und Analyse der verwendeten Lernverfahren
## Lineare Regression
![linearRegressionPlot](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/linear_regression_plot.png)

## Linear Regression Summary

**Call:**
lm(formula = Age ~ ShellWeight, data = trainingdaten)

**Residuals:**

|    Min    |   1Q     | Median  |    3Q     |   Max    |
|-----------|----------|---------|-----------|----------|
|  -6.0037  |  -1.6368 | -0.6061 |   0.9455  |  15.6072 |

**Coefficients:**

|             | Estimate | Std. Error | t value | Pr(>|t|)  |
|-------------|----------|------------|---------|-----------|
|(Intercept)  | 6.50290  | 0.09718    | 66.92   | < 2e-16 *** |
|ShellWeight  | 0.51165  | 0.01241    | 41.23   | < 2e-16 *** |

**Signif. codes:**  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

---

**Residual standard error:** 2.548 on 2723 degrees of freedom  
**Multiple R-squared:** 0.3844  
**Adjusted R-squared:** 0.3841  
**F-statistic:** 1700 on 1 and 2723 DF,  p-value: < 2.2e-16



## Entscheidungsbaum
![treePlot](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/decision_tree_plot.png)
## Support Vector Regression
![SVRPlot](https://github.com/samitxb/CrabAgePrediction_ML_DataAnalysis/blob/main/svr_plot.png)

## MAE und MSE
|  Model   |  MSE   |   MAE    |
|-------------------|-------------------|-------------------|
|Lineare Regression|5.92057528339447|1.79432299332576|
|Entscheidungsbaum|5.9146355290272|1.7920618342224|
|Support Vector Regression|6.05917555289603|1.65517447947933|

