USE Faker;

-- Procedure 1: Total and Average Sales by Day, Month, Year
DELIMITER //

DROP PROCEDURE IF EXISTS TotalAvgSales;

CREATE PROCEDURE TotalAvgSales(IN start_date DATE, IN end_date DATE)
BEGIN
    -- Daily
    SELECT order_date AS Date, 
           SUM(total_amount) AS TotalSales, 
           AVG(total_amount) AS AvgSales
    FROM orders
    WHERE order_date BETWEEN start_date AND end_date
    GROUP BY order_date;

    -- Monthly
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS Month,
        SUM(total_amount) AS TotalSales,
        AVG(total_amount) AS AvgSales
    FROM
        orders
    WHERE
        order_date BETWEEN start_date AND end_date
    GROUP BY Month;

    -- Yearly
    SELECT 
        YEAR(order_date) AS Year,
        SUM(total_amount) AS TotalSales,
        AVG(total_amount) AS AvgSales
    FROM
        orders
    WHERE
        order_date BETWEEN start_date AND end_date
    GROUP BY Year;
END //

DELIMITER ;

CALL TotalAvgSales('2024-01-01', '2024-12-31');

-- Procedure 2: Sales by Product Category and Store Name
DELIMITER //

DROP PROCEDURE IF EXISTS SalesByStoreName;

CREATE PROCEDURE SalesByStoreName(IN start_date DATE, IN end_date DATE)
BEGIN
    SELECT 
        p.category, 
        s.store_name,
        SUM(oi.quantity * oi.unit_price) AS TotalSales,
        AVG(oi.quantity * oi.unit_price) AS AvgSales
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN products p ON oi.product_id = p.product_id
    JOIN stores s ON o.store_id = s.store_id
    WHERE o.order_date BETWEEN start_date AND end_date
    GROUP BY p.category, s.store_name;
END //

DELIMITER ;

CALL SalesByStoreName('2024-01-01', '2024-12-31');