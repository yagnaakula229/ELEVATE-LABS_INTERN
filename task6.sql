use ecommerce;
SELECT 
    name,
    (SELECT MAX(order_date) 
     FROM Orders 
     WHERE Orders.user_id = Users.user_id) AS latest_order
FROM Users;


SELECT name 
FROM Users 
WHERE user_id IN (
    SELECT user_id 
    FROM Orders 
    WHERE total_amount > 5000
);

SELECT u.name, order_summary.total_orders
FROM Users u
JOIN (
    SELECT user_id, COUNT(*) AS total_orders
    FROM Orders
    GROUP BY user_id
) AS order_summary
ON u.user_id = order_summary.user_id;

SELECT name 
FROM Users u
WHERE EXISTS (
    SELECT 1 
    FROM Orders o 
    WHERE o.user_id = u.user_id
);


SELECT name
FROM Users
WHERE user_id = (
    SELECT user_id
    FROM Orders
    WHERE total_amount = 10000
    LIMIT 1
);
