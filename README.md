# Final_STAT107
## Which quarterback statistics separate the NFL MVP from the other quarterbacks in the same season?

## Function files:
- 00_requirements.R: installs and loads all packages used in the project.
- 01_funct_DataCleaning.R: functions for loading and checking the data, creating per-game variables, and ranking quarterbacks within each season.
## Analysis files:
- 11_DataCleaning.Rmd: loads the data, checks for missing values, duplicates, and MVP counts, creates new variables, and saves the result to 12_DataSaving.RData.
- 31_DataVisualization.Rmd: Summaries and plots comparing MVPs with other quarterbacks, with interpretation of the findings.
- 12_DataSaving.RData: cleaned data created by 11_DataCleaning.Rmd.
- data from https://www.pro-football-reference.com: MVP-winners_21-25.csv, candidates_21-25.csv
## Report file:
- FinalReport.Rmd & PDF: Describes in full detail our question, the methodology deployed to answer it, and the conclusions we aim to reach.

## Reproduce
1. Open the project in RStudio.
2. Run 00_requirements.R.
3. Knit 11_DataCleaning.Rmd, then 31_DataVisualization.Rmd, then FinalReport.Rmd.
