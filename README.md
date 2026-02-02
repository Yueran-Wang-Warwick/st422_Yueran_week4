# ST422 Week 4 Activity 2 — Client Report



## Project summary

This project produces a client-facing report that assesses whether a marketing intervention dataset supports a clear, defensible message for a general audience. The report compares a Control group and a Treatment group on 30-day purchase rates, checks baseline balance across customer characteristics, and provides an evidence-led recommendation with limitations.

**Author:** 2201370  

**Date:** 2026-02-02  

**Module:** ST422 Statistical Consulting, Week 4



## Data description

The raw data file is `data/raw/week4_dataset.csv`. Each row represents one customer (n = 238). The key fields are:

- **group** — "Control" (n = 120) or "Treatment" (n = 118), indicating whether the customer was included in a marketing intervention.
- **made_purchase_30d** — "Yes" or "No", the outcome variable recording whether the customer made at least one purchase within 30 days of the intervention reference point.
- Seven baseline covariates: customer_age, customer_type, avg_order_value_gbp, orders_last_90d, web_sessions_last_30d, discount_eligible, area_affluence_score.

Full field definitions, expected ranges, and data quality notes are documented in `DATA_DICTIONARY.md`.



## How to run

All commands should be run from the project root directory.

1. Open `st422-week4.Rproj` in RStudio (this sets the working directory to the project root).
2. Restore package dependencies:
   ```r
   renv::restore()
   ```
3. Knit the report:
   ```r
   rmarkdown::render("Week_4_Activity_Yueran.Rmd")
   ```
   This single command will read the raw data, source the three scripts in `src/`, generate all outputs, and produce the final HTML report.

Alternatively, the three scripts in `src/` can be run independently from the project root (after the data and packages are loaded):

```r
source("src/01_table1.R")
source("src/02_viz1_purchase_rate.R")
source("src/03_viz2_customer_type.R")
```



## Dependencies

R packages required (managed via `renv`; run `renv::restore()` to install):

- tidyverse (includes ggplot2, dplyr, readr, scales)
- knitr
- kableExtra
- rmarkdown

R version used: 4.x. The `renv.lock` file records exact package versions for full reproducibility.



## Expected outputs

After knitting the report, the following files and folders will be created automatically:

```
outputs/
  tables/
    table1_baseline_summary.jpg    # Baseline summary table (Table 1)
  figures/
    viz1_purchase_rate_by_group.jpg           # Bar chart: purchase rate by group
    viz2_purchase_rate_by_customer_type.jpg   # Grouped bar chart: purchase rate by customer type and group
data/
  processed/
    week4_dataset_processed.csv    # Dataset with factor levels applied
```

The knitted HTML report will appear in the project root as `Week_4_Activity_Yueran.html`.



## Repository structure

```
st422-week4-2201370/
  README.md                          # This file
  .gitignore
  st422-week4.Rproj
  renv.lock
  DATA_DICTIONARY.md                 # Field definitions, ranges, and data quality notes
  Week_4_Activity_Yueran.Rmd         # Main report (knit to produce HTML)
  data/
    raw/
      week4_dataset.csv              # Original client-provided data (do not modify)
    processed/
      week4_dataset_processed.csv    # Auto-generated on knit
  src/
    01_table1.R                      # Builds Table 1 and exports JPG
    02_viz1_purchase_rate.R          # Builds Visualisation 1 and exports JPG
    03_viz2_customer_type.R          # Builds Visualisation 2 and exports JPG
  outputs/
    tables/
      table1_baseline_summary.jpg    # Auto-generated on knit
    figures/
      viz1_purchase_rate_by_group.jpg           # Auto-generated on knit
      viz2_purchase_rate_by_customer_type.jpg   # Auto-generated on knit
  reports/
```



## Assumptions and limitations

- The intervention assignment rules (how customers were allocated to Control vs Treatment) are not documented by the client. Without this information, the comparison should be treated as observational, not causal.
- Several variable definitions are provisional because the staff member who prepared the data extract has left the company without handover notes. In particular, the outcome window anchor date, the New/Existing classification rule, and the meaning of discount_eligible have not been confirmed.
- The area_affluence_score ranges from 12 to 60 in this extract, whereas the documented range is 1 to 60. The lower end is not represented.
- The sample size (n = 238) is modest. The observed difference in purchase rates (approximately 4 percentage points) could plausibly arise from chance.
- All paths in the report and scripts are relative to the project root. No hard-coded absolute paths are used.

