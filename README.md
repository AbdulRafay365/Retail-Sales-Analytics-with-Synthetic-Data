# Retail Analytics: Synthetic Sales and Orders Database

A normalized, synthetic SQL database project that simulates a retail business environment, including customers, orders, products, stores, and payment methods. Ideal for OLTP modeling, business queries, and analytics visualization with Tableau.

---
Dashboard Preview
<img width="1280" height="741" alt="image" src="https://github.com/user-attachments/assets/fc4fedf0-a9eb-41cc-86a5-7404f59dc87a" />

---

## 📌 Project Overview

This project is designed to:
- Practice advanced SQL concepts including procedures, joins, and grouping.
- Support business use cases such as sales trends, payment distributions, and store performance.
- Serve as a backend for dashboards and data analytics exercises.

---

## 🧱 Database Tables

- **Customers** – User profile data including contact and address.
- **Orders** – Order metadata linking customers, stores, and payment methods.
- **Order Items** – Item-level breakdown of each order.
- **Products** – Product details with categories and prices.
- **Stores** – Store metadata with inferred region.
- **Payment Methods** – Payment types, banks, and provider details.

---

## 🔗 Relationships & Keys

- One customer can place many orders.
- Each order can have multiple order items.
- Products and stores are related via foreign keys in order items.
- Orders use a payment method.
- Each store stocks multiple products and fulfills orders.

---

## 📦 Entity Relationship Diagram

```mermaid
erDiagram
    CUSTOMERS ||--o{ ORDERS : places
    CUSTOMERS {
        int customer_id PK
        varchar customer_name
        varchar email
        varchar phone_number
        varchar address
        date join_date
    }

    ORDERS ||--o{ ORDER_ITEMS : contains
    ORDERS {
        int order_id PK
        int customer_id FK
        date order_date
        decimal total_amount
        int store_id FK
        int payment_method_id FK
    }

    ORDER_ITEMS {
        int order_item_id PK
        int order_id FK
        int store_id FK
        int product_id FK
        int quantity
        decimal unit_price
    }

    PRODUCTS ||--o{ ORDER_ITEMS : included_in
    PRODUCTS {
        int product_id PK
        varchar product_name
        varchar category
        decimal price
        int stock_quantity
        int store_id
    }

    STORES ||--o{ ORDERS : placed_at
    STORES ||--o{ ORDER_ITEMS : fulfilled_by
    STORES {
        int store_id PK
        varchar store_name
        varchar address
        varchar region
    }

    PAYMENT_METHODS ||--o{ ORDERS : used_by
    PAYMENT_METHODS {
        int payment_method_id PK
        varchar method_name
        enum method_category
        varchar provider
        varchar issuing_bank
    }
```

⚙️ Sample Stored Procedures
	•	TotalAvgSales() – Calculates total and average sales from order_items.
	•	SalesByStoreName(start_date, end_date) – Aggregates sales by store and category in a given date range.
	•	get_payment_distribution_top_region() – Shows top payment methods used by region.

⸻

📈 Use Cases
	•	Business Intelligence Dashboards
	•	OLAP Integration
	•	SQL Practice (Joins, Grouping, Aggregation, Procedures)
	•	Data Cleaning (Address → Region extraction)

⸻

🛠️ Technologies
	•	MySQL 8+
	•       Workbench
	•	Mermaid.js for ERD
	•	Tableau
