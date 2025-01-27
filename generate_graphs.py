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

# Plotting
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(12, 16))

# Plot Mean Execution Time vs Concurrency for each folder
sns.pointplot(x='Concurrency', y='Mean_Time', hue='Folder', data=df, ax=ax1)
ax1.set_title('Mean Execution Time vs Concurrency Level')
ax1.set_xlabel('Concurrency Level')
ax1.set_ylabel('Mean Execution Time (seconds)')
ax1.legend(title='Folder')

# Plot Standard Deviation vs Concurrency for each folder
sns.pointplot(x='Concurrency', y='Std_Dev', hue='Folder', data=df, ax=ax2)
ax2.set_title('Standard Deviation of Execution Time vs Concurrency Level')
ax2.set_xlabel('Concurrency Level')
ax2.set_ylabel('Standard Deviation (seconds)')
ax2.legend(title='Folder')

# Adjust layout to prevent overlapping
plt.tight_layout()

# Save the plots
plt.savefig('execution_time_graphs.png')
