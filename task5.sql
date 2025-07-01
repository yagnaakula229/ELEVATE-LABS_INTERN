use ecommerce;
SELECT 
    o.order_id,
    u.name AS customer_name,
    o.order_date,
    o.total_amount
FROM 
    Orders o
INNER JOIN Users u ON o.user_id = u.user_id;


SELECT 
    u.user_id,
    u.name AS customer_name,
    o.order_id,
    o.order_date
FROM 
    Users u
LEFT JOIN Orders o ON u.user_id = o.user_id;


SELECT 
    u.user_id,
    u.name AS customer_name,
    o.order_id,
    o.order_date
FROM 
    Users u
RIGHT JOIN Orders o ON u.user_id = o.user_id;


-- First: LEFT JOIN
SELECT 
    u.user_id,
    u.name AS customer_name,
    o.order_id,
    o.order_date
FROM 
    Users u
LEFT JOIN Orders o ON u.user_id = o.user_id

UNION

-- Then: RIGHT JOIN simulated with LEFT JOIN reversed
SELECT 
    u.user_id,
    u.name AS customer_name,
    o.order_id,
    o.order_date
FROM 
    Orders o
LEFT JOIN Users u ON o.user_id = u.user_id;

