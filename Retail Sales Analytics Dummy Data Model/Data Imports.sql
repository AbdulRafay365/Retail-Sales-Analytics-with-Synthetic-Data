-- Set global config for local data loading (only if needed)
SET GLOBAL local_infile = 1;

-- Customers
TRUNCATE TABLE customers;
LOAD DATA LOCAL INFILE '/Users/mohammedabdulrafay/Desktop/Faker/Data/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Products
TRUNCATE TABLE products;
LOAD DATA LOCAL INFILE '/Users/mohammedabdulrafay/Desktop/Faker/Data/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Stores
TRUNCATE TABLE stores;
LOAD DATA LOCAL INFILE '/Users/mohammedabdulrafay/Desktop/Faker/Data/stores.csv'
INTO TABLE stores
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Orders
TRUNCATE TABLE orders;
LOAD DATA LOCAL INFILE '/Users/mohammedabdulrafay/Desktop/Faker/Data/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Order Items
TRUNCATE TABLE order_items;
LOAD DATA LOCAL INFILE '/Users/mohammedabdulrafay/Desktop/Faker/Data/order_items.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Payment Methods
TRUNCATE TABLE payment_methods;
LOAD DATA LOCAL INFILE '/Users/mohammedabdulrafay/Desktop/Faker/Data/payment_methods.csv'
INTO TABLE payment_methods
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;