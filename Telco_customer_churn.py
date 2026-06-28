from statistics import correlation

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load dataset
df = pd.read_csv("Telco-Customer-Churn.csv")

# Show first 5 rows
# print(df.head())

# # Check dataset info
# print(df.info())

# # Check column names
# print(df.columns.tolist())

# # Summary statistics
# print(df.describe())

# # Check blank spaces before cleaning
# print((df == " ").sum())

# Standardize column names
df.columns = df.columns.str.lower().str.replace(" ", "_")

# Remove leading and trailing spaces from all object columns
df = df.apply(lambda x: x.str.strip() if x.dtype == "object" else x)

# Replace empty strings with NaN
df["totalcharges"] = df["totalcharges"].replace("", pd.NA)

# Check null values before conversion
print("\nMissing values before conversion:")
print(df.isnull().sum())

# Convert totalcharges to numeric
df["totalcharges"] = pd.to_numeric(df["totalcharges"], errors="coerce")

# Drop rows where totalcharges is null
df = df.dropna(subset=["totalcharges"])

# # Final check
# print("\nMissing values after cleaning:")
# print(df.isnull().sum())

# Final shape
# print("\nFinal dataset shape:")
# print(df.shape)

# Final datatypes
# print("\nFinal dataset info:")
# print(df.info())

# find duplicates
# print("\nDuplicate rows:")
# print(df.duplicated().sum())

# Remove customer ID because it is only a unique identifier
df.drop("customerid", axis=1, inplace=True)


# print(df.columns.tolist())

# # Check unique values in all categorical columns
# for col in df.select_dtypes(include="object").columns:
#     print(col, ":", df[col].unique())

# Total churn counts
# print("Total churn counts:")
# print(df["churn"].value_counts())

# Calculate churn percentage
# churn_rate = (df["churn"].value_counts(normalize=True)*100)
# print(churn_rate)

# Plot churn distribution
# sns.countplot(x="churn", data=df)

# plt.title("Customer Churn Distribution")
# plt.xlabel("Churn")
# plt.ylabel("Number of Customers")

# plt.show()

# Compare churn based on gender
# sns.countplot(x="gender", hue="churn", data=df)

# plt.title("Churn by Gender")
# plt.xlabel("Gender")
# plt.ylabel("Number of Customers")

# plt.show()

# Analyze churn based on contract type
# sns.countplot(x="contract", hue="churn", data=df)

# plt.title("Churn by Contract Type")
# plt.xlabel("Contract Type")
# plt.ylabel("Number of Customers")

# plt.show()

# Analyze churn by payment method
# sns.countplot(x="paymentmethod", hue="churn", data=df)

# plt.title("Churn by Payment Method")
# plt.xlabel("Payment Method")
# plt.ylabel("Number of Customers")

# plt.xticks(rotation=45)

# plt.show()

# Analyze tenure distribution by churn
# sns.boxplot(x="churn", y="tenure", data=df)

# plt.title("Tenure vs Churn")
# plt.xlabel("Churn")
# plt.ylabel("Tenure (Months)")

# plt.show()

# Compare monthly charges based on churn
# sns.boxplot(x="churn", y="monthlycharges", data=df)

# plt.title("Monthly Charges vs Churn")
# plt.xlabel("Churn")
# plt.ylabel("Monthly Charges")

# plt.show()

# # Compare total spending based on churn
# sns.boxplot(x="churn", y="totalcharges", data=df)

# plt.title("Total Charges vs Churn")
# plt.xlabel("Churn")
# plt.ylabel("Total Charges")

# plt.show()

# Check correlation between numeric columns
# correlation = df[['tenure', 'monthlycharges', 'totalcharges']].corr()

# print(correlation)

# sns.heatmap(correlation, annot=True, cmap="coolwarm")

# plt.title("Correlation Heatmap")

# plt.show()

# Create tenure groups
# df["tenure_group"] = pd.cut(
#     df["tenure"],
#     bins=[0, 12, 24, 72],
#     labels=["New", "Mid", "Loyal"]
# )

# print(df["tenure_group"].value_counts())

# Create tenure group column again
# df["tenure_group"] = pd.cut(
#     df["tenure"],
#     bins=[0, 12, 24, 72],
#     labels=["New", "Mid", "Loyal"]
# )

# print(df.columns)

# sns.countplot(x="tenure_group", hue="churn", data=df)

# plt.title("Churn by Tenure Group")
# plt.xlabel("Tenure Group")
# plt.ylabel("Number of Customers")

# plt.show()

# Save cleaned dataset
df.to_csv("cleaned_telco_churn.csv", index=False)