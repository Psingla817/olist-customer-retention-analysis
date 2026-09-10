import pandas as pd
import matplotlib.pyplot as plt

# Load delivery retention data
df = pd.read_csv("data/delivery_retention.csv")

# Order categories for a clearer comparison
order = ["On time", "Late", "Not delivered"]

df["first_delivery_status"] = pd.Categorical(
    df["first_delivery_status"],
    categories=order,
    ordered=True
)

df = df.sort_values("first_delivery_status")

# Create chart
plt.figure(figsize=(9, 6))

plt.bar(
    df["first_delivery_status"],
    df["repeat_purchase_rate"]
)

# Add percentage labels
for i, value in enumerate(df["repeat_purchase_rate"]):
    plt.text(
        i,
        value + 0.05,
        f"{value:.2f}%",
        ha="center",
        fontsize=11
    )

# Title and labels
plt.title(
    "Repeat Purchase Rate by First Delivery Experience",
    fontsize=16
)

plt.xlabel("First Delivery Experience", fontsize=12)
plt.ylabel("Repeat Purchase Rate (%)", fontsize=12)

# Keep the scale appropriate for these small percentages
plt.ylim(0, 5)

# Grid
plt.grid(
    axis="y",
    alpha=0.3
)

plt.tight_layout()

# Save chart
plt.savefig(
    "delivery_retention.png",
    dpi=300,
    bbox_inches="tight"
)

# Close figure
plt.close()

print("Delivery retention chart saved successfully as delivery_retention.png")