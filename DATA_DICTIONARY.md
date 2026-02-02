# Data Dictionary



## Source

Dataset provided by the client for ST422 Week 4 Activity 2.

**Important caveat.** The staff member who originally prepared the extract has left the company and no handover notes were provided. Some definitions reflect the client's best understanding and should be treated as provisional until confirmed against source systems and business rules.



## Record structure

Each record represents a single customer (n = 238). Two groups are provided for comparison.

| Group     | n   |
|-----------|-----|
| Control   | 120 |
| Treatment | 118 |

The groups represent whether the customer was included in a marketing intervention (Treatment) or not (Control). The intervention definition, dates, and eligibility rules have not been confirmed.



## Field definitions

| Field | Meaning | Type | Values / Range | Notes |
|---|---|---|---|---|
| group | Group membership for comparison | Categorical | "Control", "Treatment" | The individual who prepared the data had worked in the medical field and used this terminology |
| customer_age | Customer age at the time of the extract | Integer (years) | Expected 18 to 90 | Observed range in this file is 18 to 72 |
| customer_type | Customer status based on prior relationship | Categorical | "New", "Existing" | Please confirm the classification rule (e.g. any prior purchase ever, or within a lookback window) |
| avg_order_value_gbp | Average order value over a stated historical window | Numeric (GBP) | Expected approx. 8 to 350 | Please confirm the window (e.g. last 12 months) and whether refunds/cancellations are included |
| orders_last_90d | Number of orders placed in the last 90 days | Integer (count) | 0 and above | |
| web_sessions_last_30d | Number of website sessions in the last 30 days | Integer (count) | 0 and above | Please confirm session definition (e.g. analytics tool, timeout rules, bot filtering) |
| discount_eligible | Whether the customer is eligible for a discount under the intervention rules | Categorical (binary) | "No", "Yes" | Please confirm whether this represents eligibility or actual discount use |
| area_affluence_score | Area-level affluence score for the customer's location (higher = more affluent) | Integer (index) | Expected 1 to 60 | Observed range in this file is 12 to 60. Please confirm source, scale, and direction |
| made_purchase_30d | Whether the customer made at least one purchase in the 30 days after the intervention reference point | Categorical (binary) | "No", "Yes" | Please confirm the anchor date and whether purchases are defined by order placed vs fulfilled |



## Known limitations and required confirmations

The client does not have full documentation of the following items.

- The intervention definition and assignment rules (Treatment vs Control)
- The outcome window definition for made_purchase_30d
- How missing values are encoded and handled
- Whether any exclusions or deduplication steps were applied during extraction



## Data quality observations

- **No missing values** were found in the dataset (0 incomplete records out of 238).
- **area_affluence_score** ranges from 12 to 60 in this extract, whereas the documented range is 1 to 60. The lower end of the scale is not represented, which may reflect the geographic coverage of this customer sample.
- All other fields fall within their documented expected ranges.



## File locations

| File | Path | Description |
|---|---|---|
| Raw data | `data/raw/week4_dataset.csv` | Original client-provided dataset (do not modify) |
| Processed data | `data/processed/week4_dataset_processed.csv` | Dataset with factor levels applied |
