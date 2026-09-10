import pandas as pd
import matplotlib.pyplot as plt

# Load customer value retention data
df = pd.read_csv("data/customer_value_retention.csv")

# Keep the segments in logical order
segment_order = ["Low Value", "Medium Value", "High Value"]

df["customer_value_segment"] = pd.Categorical(
    df["customer_value_segment"],
    categories=segment_order,
    ordered=True
)

df = df.sort_values("customer_value_segment")

# Create chart
plt.figure(figsize=(9, 6))

plt.bar(
    df["customer_value_segment"],
    df["repeat_purchase_rate"]
)

# Add percentage labels
for i, value in enumerate(df["repeat_purchase_rate"]):
    plt.text(
        i,
        value + 0.03,
        f"{value:.2f}%",
        ha="center",
        fontsize=11
    )

# Title and labels
plt.title(
    "Repeat Purchase Rate by Customer Value Segment",
    fontsize=16
)

plt.xlabel("Customer Value Segment", fontsize=12)
plt.ylabel("Repeat Purchase Rate (%)", fontsize=12)

# Appropriate scale
plt.ylim(0, 4)

# Grid
plt.grid(
    axis="y",
    alpha=0.3
)

plt.tight_layout()

# Save chart
plt.savefig(
    "customer_value_retention.png",
    dpi=300,
    bbox_inches="tight"
)

# Close figure
plt.close()

print(
    "Customer value retention chart saved successfully as "
    "customer_value_retention.png"
)