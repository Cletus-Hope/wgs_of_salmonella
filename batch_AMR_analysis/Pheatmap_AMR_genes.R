# Load required libraries
library(readxl)
library(tidyverse)
library(viridis)
library(pheatmap)

# Load the data
file_path <- "abricate_resfinder_summary.xlsx"
df <- read_excel(file_path, sheet = 1)

# Clean column names
colnames(df)[1] <- "Isolate_ID"

# Replace '.' with NA and convert to numeric
df_clean <- df %>%
  mutate(across(-Isolate_ID, ~ suppressWarnings(as.numeric(replace(., . == ".", NA))))) %>%
  column_to_rownames("Isolate_ID")

# Convert to presence/absence
df_binary <- ifelse(is.na(df_clean), 0, 1)

# Save heatmap to a new PDF file
pdf("presence_absence_amr_heatmapwithcluster.pdf", width = 20, height = 16)
pheatmap(
  mat = df_binary,
  color = viridis(2),
  cluster_rows = TRUE, # Disable row clustering
  cluster_cols = TRUE, # Disable column clustering
  fontsize_row = 10,
  fontsize_col = 10,
  main = "Presence/Absence Heatmap of AMR Genes"
)
dev.off()
