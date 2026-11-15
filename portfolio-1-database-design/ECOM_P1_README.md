# Portfolio 1 — Relational Database Design

## 1. Introduction

ShopSphere Technologies is a simulated Nigerian
multi-vendor e-commerce platform.

The platform allows customers to:
- Register and manage their profiles.
- Browse products from multiple vendors.
- Add products to shopping carts.
- Place orders and make payments.
- Track deliveries.
- Review purchased products.

## 2. Database selection

PostgreSQL was selected as the primary relational
database because it provides:

- ACID transaction support.
- Referential integrity.
- Foreign key constraints.
- Complex SQL queries.
- Indexing and query optimisation.
- JSONB support for flexible attributes.

## 3. Main entities

The database contains:

1. Customers
2. Customer Addresses
3. Vendors
4. Categories
5. Products
6. Product Images
7. Inventory
8. Carts
9. Cart Items
10. Orders
11. Order Items
12. Payments
13. Shipments
14. Shipment Events
15. Reviews

## 4. Normalisation

The relational design follows Third Normal Form (3NF).

- Each table represents one business entity.
- Repeating data is separated into related tables.
- Foreign keys establish relationships.
- Product categories are stored separately.
- Customer details are not duplicated in order records.

Order items intentionally preserve product name and
price snapshots. These values represent the actual
commercial details at the time of purchase.

## 5. Integrity constraints

The schema uses:
- Primary keys.
- Foreign keys.
- NOT NULL constraints.
- UNIQUE constraints.
- CHECK constraints.

These constraints help prevent invalid records,
duplicate identifiers and negative inventory values.

## 6. Conclusion

The relational database provides a consistent
foundation for ShopSphere's transactional operations.