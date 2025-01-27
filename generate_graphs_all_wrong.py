#!/usr/bin/env python3

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Apply seaborn style directly
sns.set()

# Load the CSV file
df = pd.read_csv('execution_times.csv')

# Convert 'Mean_Time' and 'Std_Dev' to numeric for plotting
df['Mean_Time'] = pd.to_numeric(df['Mean_Time'], errors='coerce')
df['Std_Dev'] = pd.to_numeric(df['Std_Dev'], errors='coerce')

# Create a single subplot for both mean and std
fig, ax = plt.subplots(figsize=(12, 8))

# Plot Mean Execution Time with error bars based on standard deviation, connecting points with lines
sns.pointplot(x='Concurrency', y='Mean_Time', hue='Folder', data=df, ax=ax, errorbar='sd', markersize=5, capsize=.2)
ax.errorbar(x=df['Concurrency'], y=df['Mean_Time'], yerr=df['Std_Dev'], fmt='none', ecolor='black', elinewidth=1, capsize=4, capthick=1)

ax.set_title('Mean Execution Time vs Concurrency Level with Standard Deviation')
ax.set_xlabel('Concurrency Level (log scale)')
ax.set_ylabel('Mean Execution Time (seconds)')
ax.legend(title='Folder')

# Set x-axis to log scale
ax.set_xscale('log')

# Adjust layout to prevent overlapping
plt.tight_layout()

# Save the plot
plt.savefig('mean_and_std_deviation_log_scale_with_lines.png')
