import pandas as pd
import matplotlib.pyplot as plt

# Load the retention data
df = pd.read_csv("data/retention_curve_data.csv")

# Create the chart
plt.figure(figsize=(10, 6))

plt.plot(
    df["month"],
    df["retention_rate"],
    marker="o",
    linewidth=2
)

# Title and labels
plt.title("Customer Retention After First Purchase", fontsize=16)
plt.xlabel("Months Since First Purchase", fontsize=12)
plt.ylabel("Retention Rate (%)", fontsize=12)

# X-axis
plt.xticks(range(13))

# Grid
plt.grid(True, alpha=0.3)

# Add values to points
for x, y in zip(df["month"], df["retention_rate"]):
    plt.annotate(
        f"{y:.2f}%",
        (x, y),
        textcoords="offset points",
        xytext=(0, 8),
        ha="center",
        fontsize=9
    )

plt.tight_layout()

# Save the chart
plt.savefig(
    "retention_curve.png",
    dpi=300,
    bbox_inches="tight"
)

# Close the figure instead of opening a window
plt.close()

print("Retention curve saved successfully as retention_curve.png")