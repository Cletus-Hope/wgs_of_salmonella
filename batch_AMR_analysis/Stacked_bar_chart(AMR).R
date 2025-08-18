library(ggplot2)
library(tidyr)
library(dplyr)

# Sample data
data <- data.frame(
  Timepoints = rep(c("Dec-22", "Feb-23", "Apr-23", "Jul-23", "Nov-23"), each = 2),
  Hosts = c("Pigs", "Rodents", "Pigs", "Rodents", "Pigs", "Rodents", "Pigs", "Rodents", "Pigs", "Rodents"),
  
  'aac(3)-IVa_1' = c(95.8, NA, 93.3, NA, NA, 75, 50, 100, 100, 80),
  'aac(6)-Iaa_1' = c(100, NA, 100, NA, NA, 100, 100, 100, 100, 100),
  'ant(3)-Ia_1' = c(95.8, NA, 95, NA, NA, 75, 50, 100, 100, 80),
  'aph(3)-Ia_9' = c(14.6, NA, 11.7, NA, NA, 0, 0, 0, 0, 0),
  'aph(4)-Ia_1' = c(1, NA, 0, NA, NA, 0, 0, 0, 0, 0),
  'blaTEM_1B_1' = c(1, NA, 0, NA, NA, 0, 0, 0, 0, 0),
  'lnu(G)_1' = c(95.8, NA, 88.3, NA, NA, 75, 50, 100, 100, 80),
  'sul1_5' = c(95.8, NA, 93.3, NA, NA, 75, 50, 100, 100, 80),
  'tet(B)_2' = c(95.8, NA, 95, NA, NA, 75, 50, 100, 100, 80)
)

# Convert Timepoints to a factor with chronological order
data$Timepoints <- factor(data$Timepoints, levels = c("Dec-22", "Feb-23", "Apr-23", "Jul-23", "Nov-23"))


# Convert to long format
data_long <- pivot_longer(data, cols = -c(Timepoints, Hosts), names_to = "AMR_Gene", values_to = "Percentage")


# Create a combined label for x-axis
data_long <- data_long %>%
  mutate(Time_Host = paste(Timepoints, Hosts, sep = " - "))


# Reorder Time_Host based on Timepoints
data_long$Time_Host <- factor(data_long$Time_Host,
                              levels = unique(data_long$Time_Host[order(data_long$Timepoints)]))

# Plot
ggplot(data_long, aes(x = Time_Host, y = Percentage, fill = AMR_Gene)) +
  geom_bar(stat = "identity") +
  labs(title = "Proportion of AMR Gene by Timepoint and Host",
       x = "Timepoint and Host", y = "Proportion of AMR gene type", fill = "AMR_Gene") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(
  ggplot(data_long, aes(x = Time_Host, y = Percentage, fill = AMR_Gene)) +
    geom_bar(stat = "identity") +
    labs(title = "Proportion of AMR Gene by Timepoint and Host",
         x = "Timepoint and Host", y = "Proportion of AMR gene type", fill = "AMR_Gene") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
)
