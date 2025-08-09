library(readxl)
library(dplyr)

# STEP 1: Read Excel file
metadata <- read_excel("your_metadata_file.xlsx")

# STEP 2: Identify which columns contain AMR gene data
# For example, suppose the first 3 columns are Sample_ID, Host, Timepoint:
amr_cols <- 4:ncol(metadata)  # adjust if needed

# STEP 3: Convert AMR coverage values to presence (1) / absence (0)
metadata[amr_cols] <- lapply(metadata[amr_cols], function(x) {
  x <- as.character(x)  # Ensure all values are treated consistently
  x[is.na(x) | x == "" | x == "."] <- "0"  # Absence
  x[x != "0"] <- "1"                      # Presence
  as.numeric(x)
})
