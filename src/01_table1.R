# 01_table1.R
# Builds Table 1 (baseline summary), renders styled kable, exports JPG.
# Expects: df, n_control, n_treat already in the environment (loaded by Rmd).
# Run from project root via source("src/01_table1.R")

library(knitr)
library(kableExtra)

# --- Helper functions ---
mean_sd <- function(x) {
  sprintf("%.1f (%.1f)", mean(x, na.rm = TRUE), sd(x, na.rm = TRUE))
}

median_iqr <- function(x) {
  q <- quantile(x, probs = c(0.25, 0.75), na.rm = TRUE)
  sprintf("%.0f [%.0f, %.0f]", median(x, na.rm = TRUE), q[1], q[2])
}

n_pct <- function(x, level) {
  n <- sum(x == level, na.rm = TRUE)
  pct <- 100 * n / length(x)
  sprintf("%d (%.1f%%)", n, pct)
}

# --- Dynamic column labels ---
ctrl_label <- paste0("Control (n = ", n_control, ")")
trt_label  <- paste0("Treatment (n = ", n_treat, ")")

# --- Row builders ---
build_row_continuous <- function(data, var, label, fn = mean_sd) {
  ctrl <- data %>% filter(group == "Control") %>% pull(!!sym(var))
  trt  <- data %>% filter(group == "Treatment") %>% pull(!!sym(var))
  tibble(Measure = label, !!ctrl_label := fn(ctrl), !!trt_label := fn(trt))
}

build_row_categorical <- function(data, var, level, label) {
  ctrl <- data %>% filter(group == "Control") %>% pull(!!sym(var))
  trt  <- data %>% filter(group == "Treatment") %>% pull(!!sym(var))
  tibble(Measure = label, !!ctrl_label := n_pct(ctrl, level), !!trt_label := n_pct(trt, level))
}

# --- Assemble Table 1 ---
table1 <- bind_rows(
  tibble(Measure = "Number of customers",
         !!ctrl_label := as.character(n_control),
         !!trt_label  := as.character(n_treat)),
  build_row_continuous(df, "customer_age",          "Age, years \u2014 mean (SD)"),
  build_row_categorical(df, "customer_type", "New", "Customer type: New \u2014 n (%)"),
  build_row_continuous(df, "avg_order_value_gbp",   "Avg order value, GBP \u2014 mean (SD)"),
  build_row_continuous(df, "orders_last_90d",        "Orders in last 90 days \u2014 mean (SD)"),
  build_row_continuous(df, "web_sessions_last_30d",  "Web sessions in last 30 days \u2014 mean (SD)"),
  build_row_categorical(df, "discount_eligible", "Yes", "Discount eligible: Yes \u2014 n (%)"),
  build_row_continuous(df, "area_affluence_score",   "Area affluence score \u2014 median [IQR]", fn = median_iqr),
  build_row_categorical(df, "made_purchase_30d", "Yes", "Made purchase in 30 days: Yes \u2014 n (%)")
)

# --- Styled kable ---
table1_styled <- kable(table1,
                        caption = "Table 1: Baseline summary of customer characteristics by group",
                        align = "lcc",
                        format = "html") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"),
                full_width = FALSE) %>%
  row_spec(nrow(table1), bold = TRUE)

# --- Export JPG ---
dir.create("outputs/tables", recursive = TRUE, showWarnings = FALSE)
save_kable(table1_styled, "outputs/tables/table1_baseline_summary.jpg")
