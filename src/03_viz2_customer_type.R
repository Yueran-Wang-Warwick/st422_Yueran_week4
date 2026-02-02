# 03_viz2_customer_type.R
# Builds Visualisation 2 (purchase rate by customer type & group) and exports JPG.
# Expects: rates_subgroup already in the environment (computed by Rmd).
# Run from project root via source("src/03_viz2_customer_type.R")

library(tidyverse)

p2 <- ggplot(rates_subgroup, aes(x = customer_type, y = rate, fill = group)) +
  geom_col(position = position_dodge(width = 0.7), width = 0.6,
           colour = "grey30", linewidth = 0.3) +
  geom_text(aes(label = sprintf("%.1f%%\n(%d/%d)", rate * 100, n_yes, n),
                group = group),
            position = position_dodge(width = 0.7),
            vjust = -0.3, size = 3) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1),
                     limits = c(0, 0.55),
                     expand = expansion(mult = c(0, 0.05))) +
  scale_fill_manual(values = c("Control" = "#4E79A7", "Treatment" = "#E15759")) +
  labs(
    title    = "Visualisation 2: 30-Day Purchase Rate by Customer Type and Group",
    subtitle = "Comparing New vs Existing customers across Control and Treatment",
    x = "Customer type",
    y = "Purchase rate",
    fill = "Group"
  ) +
  theme_minimal(base_size = 12) +
  theme(plot.title = element_text(face = "bold"))

# --- Export JPG ---
dir.create("outputs/figures", recursive = TRUE, showWarnings = FALSE)
ggsave("outputs/figures/viz2_purchase_rate_by_customer_type.jpg", p2,
       width = 7, height = 4.5, dpi = 300)
