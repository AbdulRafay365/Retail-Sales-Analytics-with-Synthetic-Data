# Retail Sales & Analytics Dashboard (Faker SQL Project)

This project simulates a retail analytics environment using a **Faker-generated transactional database**, complete with **stored procedures**, **dimensional modeling**, and **sales analysis reports**. It's designed to mirror real-world business intelligence and data warehouse practices for learning and portfolio demonstration.

## Features

- Sales summaries by **day, month, year**
- Sales breakdowns by **product category** and **store**
- Procedures to track **customer retention**
- Payment method distribution in **top-performing regions**
- Designed for reporting tools like **Tableau**, **Power BI**, and **Looker**

---

## Database Schema

### 📦 Fact Tables
- `orders` – Contains transactional order data
- `order_items` – Line items with quantity, unit price per product

### 📘 Dimension Tables
- `customers`
- `products`
- `stores` *(includes address for region parsing)*
- `payment_methods`

---

## ⚙️ Stored Procedures

### 1. `TotalAvgSales(start_date, end_date)`
Returns total and average sales:
- Daily
- Monthly
- Yearly

```sql
CALL TotalAvgSales('2024-01-01', '2024-12-31');
```

2. SalesByStoreName(start_date, end_date)

Returns total and average sales by:
	•	Product category
	•	Store name

 ```sql
CALL SalesByStoreName('2024-01-01', '2024-12-31');
```

Future Enhancements
	•	Add ML-based demand forecasting
	•	Include customer segmentation (RFM)
	•	Connect to real-time BI tools
	•	Normalize address into separate region, city, and postal_code fields

⸻

💻 Tech Stack
	•	MySQL, Workbench
	•	Python (for ETL / Faker Generation)
	•	Tableau (for dashboards)

⸻

🧪 Example Queries

Top 5 Product Categories by Sales

```sql
SELECT p.category, SUM(oi.quantity * oi.unit_price) AS TotalSales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY TotalSales DESC
LIMIT 5;
```

