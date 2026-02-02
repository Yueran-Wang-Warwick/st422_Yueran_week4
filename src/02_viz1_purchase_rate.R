# 02_viz1_purchase_rate.R
# Builds Visualisation 1 (purchase rate by group) and exports JPG.
# Expects: rates_overall already in the environment (computed by Rmd).
# Run from project root via source("src/02_viz1_purchase_rate.R")

library(tidyverse)

p1 <- ggplot(rates_overall, aes(x = group, y = rate, fill = group)) +
  geom_col(width = 0.6, colour = "grey30", linewidth = 0.3) +
  geom_text(aes(label = sprintf("%.1f%%\n(%d / %d)", rate * 100, n_yes, n)),
            vjust = -0.3, size = 3.5) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1),
                     limits = c(0, 0.5),
                     expand = expansion(mult = c(0, 0.05))) +
  scale_fill_manual(values = c("Control" = "#4E79A7", "Treatment" = "#E15759")) +
  labs(
    title    = "Visualisation 1: 30-Day Purchase Rate by Group",
    subtitle = "Proportion of customers who made at least one purchase within 30 days",
    x = NULL,
    y = "Purchase rate"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "none",
        plot.title = element_text(face = "bold"))

# --- Export JPG ---
dir.create("outputs/figures", recursive = TRUE, showWarnings = FALSE)
ggsave("outputs/figures/viz1_purchase_rate_by_group.jpg", p1,
       width = 7, height = 4.5, dpi = 300)
