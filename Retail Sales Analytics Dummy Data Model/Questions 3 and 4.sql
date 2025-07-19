USE Faker;

-- 3. Customer retention based on order frequency

DROP PROCEDURE IF EXISTS get_customer_retention;
DELIMITER $$

CREATE PROCEDURE get_customer_retention(IN min_orders INT)
BEGIN
    DECLARE total_customers INT;

    -- Step 1: Total number of customers
    SELECT COUNT(*) INTO total_customers
    FROM customers;

    -- Step 2: Customers who have placed at least `min_orders`
    SELECT 
        c.customer_id,
        c.customer_name,
        COUNT(o.order_id) AS total_orders
    FROM 
        customers c
    JOIN 
        orders o ON c.customer_id = o.customer_id
    GROUP BY 
        c.customer_id, c.customer_name
    HAVING 
        COUNT(o.order_id) >= min_orders;

    -- Step 3: Retention percentage
    SELECT 
        ROUND((COUNT(*) / total_customers) * 100, 2) AS retention_percentage
    FROM (
        SELECT 
            o.customer_id
        FROM 
            orders o
        GROUP BY 
            o.customer_id
        HAVING 
            COUNT(o.order_id) >= min_orders
    ) AS retained_customers;
END $$

DELIMITER ;

-- 4. Payment Method Distribution in Top Revenue-Generating Region

DROP PROCEDURE IF EXISTS get_payment_distribution_top_region;
DELIMITER $$

CREATE PROCEDURE get_payment_distribution_top_region()
BEGIN
    DECLARE top_region VARCHAR(100);
    DECLARE total_orders INT;

    -- Step 1: Get top revenue-generating region
    SELECT 
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(s.address, ',', 2), ',', -1)) AS region
    INTO 
        top_region
    FROM 
        orders o
    JOIN 
        stores s ON o.store_id = s.store_id
    GROUP BY 
        region
    ORDER BY 
        SUM(o.total_amount) DESC
    LIMIT 1;

    -- Step 2: Get total orders for that region
    SELECT 
        COUNT(*) 
    INTO 
        total_orders
    FROM 
        orders o
    JOIN 
        stores s ON o.store_id = s.store_id
    WHERE 
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(s.address, ',', 2), ',', -1)) = top_region;

    -- Step 3: Return payment method category distribution
    SELECT 
        pm.method_category AS payment_method_category,
        COUNT(*) AS usage_count,
        ROUND(COUNT(*) / total_orders * 100, 2) AS percentage_usage
    FROM 
        orders o
    JOIN 
        payment_methods pm ON o.payment_method_id = pm.payment_method_id
    JOIN 
        stores s ON o.store_id = s.store_id
    WHERE 
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(s.address, ',', 2), ',', -1)) = top_region
    GROUP BY 
        pm.method_category;
END $$

DELIMITER ;

DESCRIBE payment_methods;

CALL get_customer_retention(3);
CALL get_payment_distribution_top_region();