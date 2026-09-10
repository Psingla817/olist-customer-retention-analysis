import pandas as pd
import matplotlib.pyplot as plt

# Load category retention data
df = pd.read_csv("data/category_retention.csv")

# Sort from lowest to highest so the highest appears at the top
df = df.sort_values("repeat_purchase_rate", ascending=True)

# Create figure
plt.figure(figsize=(10, 9))

# Horizontal bar chart
plt.barh(
    df["first_category"],
    df["repeat_purchase_rate"]
)

# Add percentage labels
for i, value in enumerate(df["repeat_purchase_rate"]):
    plt.text(
        value + 0.05,
        i,
        f"{value:.2f}%",
        va="center",
        fontsize=9
    )

# Titles and labels
plt.title(
    "Repeat Purchase Rate by First-Purchase Category",
    fontsize=16
)

plt.xlabel("Repeat Purchase Rate (%)", fontsize=12)
plt.ylabel("First-Purchase Category", fontsize=12)

# Grid
plt.grid(
    axis="x",
    alpha=0.3
)

# Improve layout
plt.tight_layout()

# Save chart
plt.savefig(
    "category_retention.png",
    dpi=300,
    bbox_inches="tight"
)

# Close figure
plt.close()

print("Category retention chart saved successfully as category_retention.png")